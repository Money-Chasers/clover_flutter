import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/main_screen/dashboard_section/dashboard_section.dart';
import 'package:clover_flutter/screens/main_screen/dashboard_section/settings_screen/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _authInstance = FirebaseAuth.instance;

  int _currentScreenId = 0;

  void _setScreenId(newId) {
    setState(() {
      _currentScreenId = newId;
    });
  }

  _buildNavigationDrawerTile(text, icon, screenId) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentScreenId == screenId
                ? Theme.of(context).primaryColorLight
                : Colors.transparent),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 10),
            Text(
              text,
              style:
                  GoogleFonts.prompt(textStyle: const TextStyle(fontSize: 15)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () {
        _setScreenId(screenId);
        Navigator.pop(context);
      },
    );
  }

  Widget? _getSection(screenId) {
    switch (screenId) {
      case (0):
        {
          return const DashboardSection();
        }
    }
  }

  _buildDrawerButton(icon, callbackFunction) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 30),
      ),
      onTap: () {
        Navigator.pop(context);
        callbackFunction();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffd4d4d4)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(4)),
                      child: Image(
                          image: Image.asset('assets/images/logo.png', scale: 5)
                              .image),
                    ),
                    _buildDrawerButton(Icons.arrow_back, () {})
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildNavigationDrawerTile(
                          AppLocalizations.of(context)!.dashboard,
                          Icons.dashboard,
                          0),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Color(0xffd4d4d4)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDrawerButton(Icons.settings, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()));
                    }),
                    _buildDrawerButton(
                      Icons.power_settings_new,
                      () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                AppLocalizations.of(context)!.logoutConfirm,
                                style: GoogleFonts.prompt(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.no,
                                    style: GoogleFonts.prompt(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.yes,
                                    style: GoogleFonts.prompt(
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  onPressed: () {
                                    _authInstance.signOut().then((value) =>
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const IntroScreen()),
                                            (e) => false));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Clover"),
      ),
      body: SafeArea(
        child: Container(
          child: _getSection(_currentScreenId),
        ),
      ),
    );
  }
}
