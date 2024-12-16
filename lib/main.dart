import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/routes/routes.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'NMT Doctor',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black87,
          backgroundColor: Colors.white70,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
} 
