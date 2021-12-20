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
      // get language
      final _future1 = SharedPreferencesHelper.getLocale();

      // check user authentication state
      final _future2 = _getAuthFuture();

      // execute all futures
      Future.wait([_future1, _future2]).then((resultList) {
        // first future
        MyApp.of(context)!.setLocale(Locale(resultList[0]));

        // second future
        if (resultList[1].docs.isEmpty) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const EducationScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        }
      });
    });
  }

  Future _getAuthFuture() {
    if (_authInstance.currentUser == null) {
      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const IntroScreen()));
    } else {
      return _firestoreInstance
          .collection('users')
          .where('email', isEqualTo: _authInstance.currentUser!.email)
          .where('education', isNotEqualTo: 0)
          .get();
    }
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
