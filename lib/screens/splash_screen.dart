import 'dart:async';

import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_screen/main_screen.dart';

import 'main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authInstance = FirebaseAuth.instance;

  _SplashScreenState() {
    // to run something as soon as the widget gets mounted.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => _authInstance.currentUser == null
                  ? const IntroScreen()
                  : const MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: Image.asset(
                'assets/images/logo.png',
                scale: 1.25,
              ).image),
              Text(
                "Clover",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
