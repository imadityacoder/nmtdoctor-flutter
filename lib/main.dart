import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/providers/healthpack_provider.dart';
import 'package:nmt_doctor_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HealthpackProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
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
        fontFamily: 'Inter',
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black87,
          backgroundColor: Colors.blueGrey[50],
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 50, 190, 255)),
                foregroundColor: WidgetStatePropertyAll(Colors.white))),
      ),
      builder: (context, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              Navigator.pop(context);
            }
          },
          child: child!,
        );
      },
    );
  }
}
