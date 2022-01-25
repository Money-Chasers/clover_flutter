import 'package:clover_flutter/main.dart';
import 'package:clover_flutter/screens/main_screen/navigation_drawer/settings_screen/image_picker.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:clover_flutter/utils/shared_preferences_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'account_settings.dart';
import 'choose_language_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final _authInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSettingsSectionHeader(
                context, AppLocalizations.of(context)!.profile),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Container(
                    width: 320.0,
                    height: 320.0,
                    padding: const EdgeInsets.all(10.0),
                    child: const ProfileImageWidget(),
                  ),
                  Text(_authInstance.currentUser!.displayName.toString(),
                      style: Theme.of(context).textTheme.subtitle2),
                  Text(_authInstance.currentUser!.email.toString(),
                      style: Theme.of(context).textTheme.subtitle2),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AccountSettingsScreen()));
                    },
                    child: Text(AppLocalizations.of(context)!.accountSettings,
                        style: Theme.of(context).textTheme.button),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            buildSettingsSectionHeader(
                context, AppLocalizations.of(context)!.preferences),
            buildSettingsCard(
                Row(
                  children: [
                    const Icon(Icons.language, size: 30),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.languageName,
                        style: Theme.of(context).textTheme.subtitle2),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios, size: 15)
                  ],
                ), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChooseLanguageScreen()));
            }),
            buildSettingsCard(
                Row(
                  children: [
                    const Icon(Icons.dark_mode, size: 30),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.darkMode,
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
                Switch(
                    value: MyApp.of(context)!.getDarkMode(),
                    onChanged: (newValue) {
                      MyApp.of(context)!.setDarkMode(newValue.toString());
                      SharedPreferencesHelper.setDarkMode(newValue.toString());
                    }), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChooseLanguageScreen()));
            })
          ],
        ),
      ),
    );
  }
}
