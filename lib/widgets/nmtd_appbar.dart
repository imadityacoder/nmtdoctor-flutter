import 'package:flutter/material.dart';

AppBar nmtdAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 10,
    leading: Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
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
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
      ),
    ],
  );
}
