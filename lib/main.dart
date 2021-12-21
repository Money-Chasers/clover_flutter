import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/paper/paper_attempt.dart';
import 'package:clover_flutter/screens/paper/paper_display.dart';
import 'package:clover_flutter/screens/paper/paper_result.dart';
import 'package:clover_flutter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clover',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColorDark: const Color(0xff084e38)),
      home: const IntroScreen(),
      routes: {
      "paper-attempt": (context) => const PaperAttempt(),
      "paper-result": (context) => const PaperResult(),
      },
    );
  }
}
