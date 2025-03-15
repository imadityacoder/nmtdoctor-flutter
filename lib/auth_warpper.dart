import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/permissions_manager.dart';
import 'package:nmt_doctor_app/providers/auth_provider.dart';
import 'package:nmt_doctor_app/screens/auth/signup.dart';
import 'package:nmt_doctor_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _permissionsRequested = false; // Prevents duplicate requests

  // Function to handle permission requests
  Future<void> _requestPermissions() async {
    if (_permissionsRequested) return; // Prevent multiple calls
    _permissionsRequested = true;

    try {
      final permissionService = PermissionService();
      await permissionService.requestPermissions();
      debugPrint("Permissions granted successfully");
    } catch (e) {
      debugPrint("Error requesting permissions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
          Provider.of<MyAuthProvider>(context, listen: false).authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else if (snapshot.hasData) {
          // Request permissions after user authentication
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _requestPermissions());
          return const HomeContent(); // Show home page if logged in
        } else {
          return const SignUpContent(); // Show signup page if not logged in
        }
      },
    );
  }
}
