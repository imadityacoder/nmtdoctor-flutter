import 'package:flutter/material.dart';

AppBar nmtdAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 10,
    leading: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/images/logo.png'),
      ),
    ),
    title: const Text(
      'NMT DOCTOR',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 25,
        fontFamily: 'Poppins',
      ),
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Icon(
          Icons.notifications,
          size: 26,
        ),
      ),
    ],
  );
}
