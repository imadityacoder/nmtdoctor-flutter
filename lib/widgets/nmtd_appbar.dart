import 'package:flutter/material.dart';

AppBar nmtdAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset('assets/images/logo.jpeg'),
        ),
        const SizedBox(width: 10),
        const Text(
          'NMT DOCTOR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ],
    ),
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: CircleAvatar(
          child: Icon(Icons.person),
        ),
      ),
    ],
  );
}
