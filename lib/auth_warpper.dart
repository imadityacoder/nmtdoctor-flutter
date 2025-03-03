import 'package:appwrite_auth_kit/appwrite_auth_kit.dart';
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/screens/auth/login.dart';
import 'package:nmt_doctor_app/screens/home/home.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.authNotifier;

    switch (authNotifier.status) {
      case AuthStatus.authenticated:
        return const HomeContent(); // User is authenticated
      case AuthStatus.unauthenticated:
      case AuthStatus.authenticating:
        return const LoginContent(); // User is not authenticated
      case AuthStatus.uninitialized:
      default:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ); // Loading state
    }
  }
}
