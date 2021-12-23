import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/main.dart';
import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/utils/shared_preferences_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'authentication/education_screen.dart';
import 'main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authInstance = FirebaseAuth.instance;
  final _firestoreInstance = FirebaseFirestore.instance;

  _SplashScreenState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final _future1 = _getSettings();

      _future1.then((_) {
        // handle authentication
        if (_authInstance.currentUser == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const IntroScreen()));
        } else {
          _firestoreInstance
              .collection('users')
              .where('email', isEqualTo: _authInstance.currentUser!.email)
              .where('education', isEqualTo: 0)
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EducationScreen()));
            }
          });
        }
      });
    });
  }

  Future _getSettings() {
    final _future1 = SharedPreferencesHelper.getLocale();
    final _future2 = SharedPreferencesHelper.getDarkMode();

    return Future.wait([_future1, _future2]).then((value) {
      MyApp.of(context)!.setLocale(Locale(value[0]));
      MyApp.of(context)!.setDarkMode(value[1]);
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
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 50),
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
