import 'dart:async';

import 'package:course_compass/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final bool initScreen;

  const SplashScreen(this.initScreen, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.initScreen) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ));
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context)
          ..pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/splashlogo.png"),
      ),
    );
  }
}
