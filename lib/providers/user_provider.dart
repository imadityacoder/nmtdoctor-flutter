import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/main.dart';

class UserProvider extends ChangeNotifier {
  final Databases _databases;
  final Account _account;

  static const String _databaseId = '67bd478e001b531435c6'; // Replace with your Appwrite Database ID
  static const String _collectionId = '67beb2480017bf5b2dbc'; // Replace with your Appwrite Collection ID

  bool _isLoading = false;
  Map<String, dynamic>? _userData;
  models.User? _user; // Store user object

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData;
  models.User? get user => _user;

  UserProvider()
      : _databases = Databases(client),
        _account = Account(client);

  /// Fetch the current logged-in user and store the user object
  Future<void> getCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _account.get(); // Store user object

      await fetchUserData(); // Fetch user details
    } on AppwriteException catch (e) {
      debugPrint("Error getting current user: ${e.message}");
      _user = null;
      _userData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Fetch user data from Appwrite Database
  Future<void> fetchUserData() async {
    if (_user == null) return; // Ensure user exists

    _isLoading = true;
    notifyListeners();

    try {
      models.Document userDoc = await _databases.getDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: _user!.$id,
      );
      _userData = userDoc.data;
    } on AppwriteException catch (e) {
      debugPrint("Error fetching user data: ${e.message}");
      _userData = null;
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
    
  }) async {
    if (_user == null) return;

    try {
      await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: _user!.$id,
        data: {
          'fullName': fullName,
          'email': user!.email,
          'phone': phone,
          'age': age,
          'gender': gender,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      // Refresh local data.
      await fetchUserData();
    } on AppwriteException catch (e) {
      debugPrint("Error updating user details: ${e.message}");
    }
  }

  /// Add new user
  Future<void> addUser({
    required String fullName,
    required String phone,
    required int age,
    required String gender,
  }) async {
    if (_user == null) return;

    try {
      await _account.updateName(name: fullName);
      // await _account.updatePhone(phone:phone);

      await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: _user!.$id,
        data: {
          'email': user!.email,
          'fullName': fullName,
          'phone': phone,
          'age': age,
          'gender': gender,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      // Refresh local data.
      await fetchUserData();
    } on AppwriteException catch (e) {
      debugPrint("Error adding user: ${e.message}");
    }
  }

  /// Check if the user exists and show the form if details are missing
  Future<void> checkAndShowUserForm(BuildContext context) async {
    await fetchUserData();

    if (_userData == null || (_userData?['fullName']?.isEmpty ?? true)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUserDetailForm(context);
      });
    }
  }

  void showUserDetailForm(BuildContext context) {
    // Implement the function to show the user detail form
  }
}
