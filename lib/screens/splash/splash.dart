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
          duration: const Duration(milliseconds: 600),
          opacity: _opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 100,),
              const CircularProgressIndicator(color: Colors.black54,),
            ],
          ),
        ),
      ),
    );
  }
}
