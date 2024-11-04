import 'dart:async';

import 'package:course_compass/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/src/shared_preferences_legacy.dart';

class SplashScreen extends StatefulWidget {
  final bool initScreen;
  final SharedPreferences prefs;

  const SplashScreen(this.initScreen, this.prefs, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void delayed() {
    if (!widget.initScreen) {
      print("now ${!widget.initScreen}");
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OnboardingScreen(
            prefs: widget.prefs,
          ),
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
    delayed();
    return Scaffold(
      body: Center(
        child: Image.asset("assets/splashlogo.png"),
      ),
    );
  }
}
