
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/main.dart';

class MyAuthProvider extends ChangeNotifier {
  final Account _account;

  MyAuthProvider() : _account = Account(client);



  /// Sign up with email and password.
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      // Send verification email
      await _account.createVerification(url: 'https://yourapp.com/verify');
      notifyListeners();
    } catch (e) {
      _handleException(e);
    }
  }

  /// Sign in with email and password.
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      notifyListeners();
    } catch (e) {
      _handleException(e);
    }
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    try {
      await _account.createOAuth2Session(provider: OAuthProvider.google);
      notifyListeners();
    } catch (e) {
      _handleException(e);
    }
  }

  /// Send a password reset email.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _account.createRecovery(
        email: email,
        url: 'https://yourapp.com/reset-password',
      );
    } catch (e) {
      _handleException(e);
    }
  }

  /// Sign out from the current session.
  Future<void> signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      notifyListeners();
    } catch (e) {
      _handleException(e);
    }
  }

  /// Handle Appwrite exceptions and provide meaningful messages.
  void _handleException(dynamic e) {
    String message = 'An unknown error occurred';
    if (e is AppwriteException) {
      switch (e.code) {
        case 400:
          message = 'Bad request. Please check your input.';
          break;
        case 401:
          message = 'Unauthorized. Please check your credentials.';
          break; 
        case 403:
          message = 'Access forbidden. You do not have permission.';
          break;
        case 404:
          message = 'Resource not found.';
          break;
        case 409:
          message = 'Conflict. The user already exists.';
          break;
        case 500:
          message = 'Server error. Please try again later.';
          break;
        default:
          message = e.message ?? message;
      }
    }
    throw Exception(message);
  }


}
