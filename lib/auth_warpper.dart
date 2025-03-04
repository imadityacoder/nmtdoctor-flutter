import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/providers/auth_provider.dart';
import 'package:nmt_doctor_app/screens/auth/signup.dart';
import 'package:nmt_doctor_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

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
          ));
        } else if (snapshot.hasData) {
          return const HomeContent(); // Show home page if logged in
        } else {
          return const SignUpContent(); // Show signup page if not logged in
        }
      },
    );
  }
}
