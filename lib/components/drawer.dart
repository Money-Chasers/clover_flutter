import 'package:clover_flutter/screens/authentication/intro_screen.dart';
import 'package:clover_flutter/screens/main_application/dashboard_screen/dashboard_screen.dart';
import 'package:clover_flutter/screens/main_application/settings_screen/settings_screen.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/submit_questions_section.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void _navigateScreen(int screenId) {
    switch (screenId) {
      case (0):
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardSection()));
        break;
      case (1):
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SubmitQuestionsSection()));
        break;
      default:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardSection()));
    }
  }

  Widget _buildNavigationDrawerTile(text, icon, screenId) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 10),
            Text(text, style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
      onTap: () {
        _navigateScreen(screenId);
      },
    );
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
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffd4d4d4)))),
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
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                  child: Text(AppLocalizations.of(context)!.yes,
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
    );
  }
}
