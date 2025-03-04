import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Stream to track authentication state changes.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Sign up with email and password.
  /// After creating the user, send a verification email.
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      // Create a new user
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred during signup');
    }
  }

  /// Sign in with email and password.
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred during sign-in');
    }
  }

  /// Sign in with Google.
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In was canceled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred during Google sign-in');
    }
  }

  /// Send a password reset email.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      throw Exception('An unexpected error occurred while sending reset email');
    }
  }

  /// Sign out from all sessions.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      notifyListeners();
    } catch (e) {
      throw Exception('Sign-out failed. Please try again.');
    }
  }

  /// Handle FirebaseAuth exceptions and throw meaningful errors.
  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        throw Exception(
            'This email is already in use. Please use a different email.');
      case 'invalid-email':
        throw Exception('The email address is not valid.');
      case 'weak-password':
        throw Exception('The password is too weak.');
      case 'user-not-found':
        throw Exception('No user found with this email.');
      case 'wrong-password':
        throw Exception('Incorrect password. Please try again.');
      case 'account-exists-with-different-credential':
        throw Exception(
            'This email is already associated with a different sign-in method.');
      case 'network-request-failed':
        throw Exception(
            'Network error. Please check your connection and try again.');
      default:
        throw Exception(e.message ?? 'An unknown error occurred.');
    }
  }
}
