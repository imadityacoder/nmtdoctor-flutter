import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Handles all Firebase Cloud Messaging functionality for Android.
class MessagingProvider with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  String? _fcmToken;
  List<RemoteMessage> _notifications = [];

  MessagingProvider() {
    _initMessaging();
  }

  /// Gets the current FCM token
  String? get fcmToken => _fcmToken;

  /// Gets the list of received notifications
  List<RemoteMessage> get notifications => _notifications;

  /// Initialize messaging related services
  Future<void> _initMessaging() async {
    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // Initialize local notifications for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // Get the FCM token
    await _updateToken();

    // Configure how to handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Configure how to handle messages when the app is opened from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then(_handleInitialMessage);

    // Configure how to handle messages when the app is in the background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Load notifications from local storage
    await _loadNotifications();
  }

  /// Updates the FCM token and saves it
  Future<void> _updateToken() async {
    final token = await _firebaseMessaging.getToken();
    _fcmToken = token;
    debugPrint('FCM Token: $token');

    // Save token to shared preferences
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token);
    }

    // Set up token refresh listener
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      _fcmToken = newToken;
      debugPrint('FCM Token refreshed: $newToken');

      // Save refreshed token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', newToken);

      // TODO: Send the new token to your server
    });

    notifyListeners();
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Got a message while in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint('Message notification: ${message.notification}');

      // Show local notification
      _showLocalNotification(message);

      // Add to notifications list
      _addNotification(message);
    }
  }

  /// Handle messages when app is launched from a terminated state
  void _handleInitialMessage(RemoteMessage? message) async {
    if (message != null) {
      debugPrint(
          'App opened from terminated state with message: ${message.data}');
      _addNotification(message);

      // TODO: Navigate to relevant screen based on the message data
    }
  }

  /// Handle messages when app is in background
  void _handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('App opened from background with message: ${message.data}');
    _addNotification(message);

    // TODO: Navigate to relevant screen based on the message data
  }

  /// Show a local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    final AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'nmt_doctor_channel',
            'NMT Doctor Notifications',
            channelDescription: 'Notification channel for NMT Doctor app',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: json.encode(message.data),
      );
    }
  }

  /// Add notification to the list and save to storage
  Future<void> _addNotification(RemoteMessage message) async {
    _notifications.insert(0, message);
    notifyListeners();

    // Save notifications to local storage
    await _saveNotifications();
  }

  /// Save notifications to shared preferences
  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    // We can only store basic types in SharedPreferences, so convert to a list of maps
    final notificationsJson = _notifications.map((msg) {
      return {
        'title': msg.notification?.title,
        'body': msg.notification?.body,
        'data': msg.data,
        'sentTime': msg.sentTime?.millisecondsSinceEpoch,
      };
    }).toList();

    await prefs.setString('notifications', json.encode(notificationsJson));
  }

  /// Load notifications from shared preferences
  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsString = prefs.getString('notifications');

    if (notificationsString != null) {
      try {
        final List<dynamic> notificationsJson =
            json.decode(notificationsString);

        // We need to convert back to RemoteMessage
        // Since we can't fully reconstruct a RemoteMessage, we'll make a simplified version
        _notifications = notificationsJson.map((json) {
          final sentTime = json['sentTime'] != null
              ? DateTime.fromMillisecondsSinceEpoch(json['sentTime'])
              : DateTime.now();

          return RemoteMessage(
            notification: json['title'] != null || json['body'] != null
                ? RemoteNotification(
                    title: json['title'],
                    body: json['body'],
                  )
                : null,
            data: Map<String, dynamic>.from(json['data'] ?? {}),
            sentTime: sentTime,
          );
        }).toList();

        notifyListeners();
      } catch (e) {
        debugPrint('Error loading notifications: $e');
      }
    }
  }

  /// Clear all notifications
  Future<void> clearNotifications() async {
    _notifications = [];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
  }

  /// Handle notification taps
  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    debugPrint('Notification clicked: ${details.payload}');

    if (details.payload != null) {
      final data = json.decode(details.payload!);

      // TODO: Navigate to the appropriate screen based on data
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }
}
