import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/main_screen/navigation_drawer/practice_section/practice_screen.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'navigation_drawer/dashboard_section/dashboard_section.dart';
import 'navigation_drawer/settings_screen/settings_screen.dart';
import 'navigation_drawer/submit_questions_section/paper_details_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
            Text(text, style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
      onTap: () {
        _setScreenId(screenId);
        Navigator.pop(context);
      },
    );
  }

  _handleScaffoldTitleFetch(screenId) {
    switch (screenId) {
      case (0):
        return AppLocalizations.of(context)!.dashboard;
      case (1):
        return AppLocalizations.of(context)!.paperDetails;
      case (2):
        return AppLocalizations.of(context)!.practice;
    }
  }

  _handleSectionFetch(screenId) {
    switch (screenId) {
      case (0):
        return const DashboardSection();
      case (1):
        return const PaperDetailsScreen();
      case (2):
        return const PracticeScreen();
    }
  }

  _buildDrawerButton(icon, callbackFunction) {
    return GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, size: 30)),
        onTap: () {
          Navigator.pop(context);
          callbackFunction();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_handleScaffoldTitleFetch(_currentScreenId)),
      ),
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
                      _buildNavigationDrawerTile(
                          AppLocalizations.of(context)!.submitQuestions,
                          Icons.question_answer,
                          1),
                      _buildNavigationDrawerTile(
                          AppLocalizations.of(context)!.practice, Icons.quiz, 2)
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
                                  style: Theme.of(context).textTheme.subtitle1),
                              actions: [
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!.no,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                    child: Text(
                                        AppLocalizations.of(context)!.yes,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    onPressed: () {
                                      BackendHelper.signOut().then((_) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const IntroScreen()),
                                            (route) => false);
                                      });
                                    }),
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
      body: SafeArea(
        child: Container(
          child: _handleSectionFetch(_currentScreenId),
        ),
      ),
    );
  }
}
