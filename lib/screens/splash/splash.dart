import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1;
        // Fade in effect
      });
    });

    // Navigate to the HomePage after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: _opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                height: 230,
                width: 230,
              ),
              const Text(
                "Now My Turn \nDoctor",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 142, 207),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
