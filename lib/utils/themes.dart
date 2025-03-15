// theme.dart
import 'package:flutter/material.dart';

final ThemeData nmtDoctorTheme = ThemeData(
  fontFamily: 'Rubik',
  colorSchemeSeed: const Color(0xFF003580),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 23,
      fontFamily: 'Roboto',
    ),
    backgroundColor: Color(0xFF003580),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: const Color(0xFF003580),
    unselectedItemColor: Colors.black,
    backgroundColor: Colors.blueGrey[50],
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(const Color(0xFF003580)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
    ),
  ),
);
