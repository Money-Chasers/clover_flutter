import 'dart:async';

import 'package:clover_flutter/bloc/streams/settings_bloc.dart';
import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/authentication/login_screen.dart';
import 'package:clover_flutter/screens/authentication/register_screen.dart';
import 'package:clover_flutter/screens/main_application/attempt_paper_screen/sections/attempt_questions_section.dart';
import 'package:clover_flutter/screens/main_application/dashboard_screen/dashboard_screen.dart';
import 'package:clover_flutter/screens/main_application/my_space_screen/my_space_screen.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/paper_details_section.dart';
import 'package:clover_flutter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _locale = settingsBloc.currentLocale;
  bool _darkMode = settingsBloc.currentDarkMode;

  late StreamSubscription _localeStreamSubscription;
  late StreamSubscription _darkModeStreamSubscription;

  @override
  void initState() {
    _localeStreamSubscription = settingsBloc.localeStream.listen((event) {
      setState(() {
        _locale = event;
      });
    });
    _darkModeStreamSubscription = settingsBloc.darkModeStream.listen((event) {
      setState(() {
        _darkMode = event;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _localeStreamSubscription.cancel();
    _darkModeStreamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/intro': (context) => const IntroScreen(),
          '/login': (context)=> const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/attemptQuestions': (context) => const AttemptPaperScreen(),
          '/paperDetails': (context) => const PaperDetailsSection(),
          '/mySpace': (context) => const MySpaceScreen(),
        },
        title: 'Clover',
        themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColorDark: const Color(0xff084e38),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale(_locale),
        home: const SplashScreen());
  }
}
