import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/paper/paper_display.dart';
import 'package:clover_flutter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  bool _darkMode = false;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  bool getDarkMode() {
    return _darkMode;
  }

  void setDarkMode(String value) {
    switch (value) {
      case 'true':
        setState(() {
          _darkMode = true;
        });
        break;
      default:
        setState(() {
          _darkMode = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clover',
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColorDark: const Color(0xff084e38)),
      darkTheme: ThemeData(brightness: Brightness.dark),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      home: const SplashScreen(),
      routes: {
        "paper-display": (context) => const PaperDisplay(),
        "paper-attempt": (context) => const PaperAttempt(),
        "paper-result": (context) => const PaperResult(),
        "practice-screen": (context) => const PracticeSection(),
      },
    );
  }
}
