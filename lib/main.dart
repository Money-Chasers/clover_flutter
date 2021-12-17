import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
        primaryColorDark: const Color(0xff0B6E4F)
      ),
      home: const IntroScreen(),
    );
  }
}
