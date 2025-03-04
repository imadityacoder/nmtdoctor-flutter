import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/screens/auth/new_detail.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  Map<String, dynamic>? _userData;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData;

  /// Fetch user data from Firestore
  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        _userData = userDoc.data();
      } else {
        _userData = null;
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Update user details
  Future<void> updateUserDetails({
    required String fullName,
    required String phone,
    required int age,
    required String gender,
    required String? email,
  }) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'fullName': fullName,
        'phone': phone,
        'age': age,
        'gender': gender,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _userData = {
        'fullName': fullName,
        'phone': phone,
        'age': age,
        'gender': gender,
        'email': user.email,
      };
      notifyListeners();
    } catch (e) {
      debugPrint("Error updating user details: $e");
    }
  }

  Future<void> addUser({
    required String uid,
    required String email,
    required String fullName,
    required String phone,
    required int age,
    required String gender,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'fullName': fullName,
        'phone': phone,
        'age': age,
        'gender': gender,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      // Refresh local data.
      await fetchUserData();
    } catch (e) {
      throw Exception('Failed to save user details: $e');
    }
  }

  Future<void> checkAndShowUserForm(BuildContext context) async {
    await fetchUserData();

    // Safely check if fullName is empty or null
    if (_userData == null || (_userData?['fullName']?.isEmpty ?? true)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUserDetailForm(context);
      });
    }
  }
}
