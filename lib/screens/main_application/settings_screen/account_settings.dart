import 'package:clover_flutter/components/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'change_password_screen.dart';
import 'update_email_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _authInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.accountSettings)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSettingsSectionHeader(
                context, AppLocalizations.of(context)!.basicSettings),
            buildSettingsCard(
                Row(
                  children: [
                    const Icon(Icons.email, size: 30),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.updateEmail,
                            style: Theme.of(context).textTheme.subtitle1),
                        Text(_authInstance.currentUser!.email.toString(),
                            style: Theme.of(context).textTheme.bodyText1)
                      ],
                    )
                  ],
                ),
                const Icon(Icons.arrow_forward), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateEmailScreen()));
            }),
            buildSettingsCard(
                Row(
                  children: [
                    const Icon(Icons.password),
                    const SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.changePassword,
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
                const Icon(Icons.arrow_forward), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()));
            })
          ],
        ),
      ),
    );
  }
}