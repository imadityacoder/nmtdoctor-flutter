import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationProvider() {
    _initializeFCM();
    _initializeLocalNotifications();
  }

  /// ✅ Initialize Firebase Cloud Messaging (FCM)
  void _initializeFCM() async {
    // Request permission for notifications (iOS)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('Notification Permission: ${settings.authorizationStatus}');

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Handle background notification taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message);
    });

    // Get FCM token (for debugging)
    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");
  }

  /// ✅ Initialize Local Notifications
  void _initializeLocalNotifications() {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    _localNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        _handleNotificationTap(
            RemoteMessage(data: {'activity': response.payload!}));
      }
    });
  }

  /// ✅ Show Local Notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Channel for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? "New Notification",
      message.notification?.body ?? "",
      notificationDetails,
      payload: message.data['activity'], // Pass activity data
    );
  }

  /// ✅ Handle Background Notification Tap
  void _handleNotificationTap(RemoteMessage message) {
    String? activity = message.data['activity'];
    if (activity != null) {
      debugPrint("Navigating to: $activity");
    }
  }
}

/// ✅ Background Notification Handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Received background notification: ${message.data}");
}
