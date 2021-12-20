import 'package:clover_flutter/screens/main_screen/dashboard_section/settings_screen/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'choose_language_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final _authInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                AppLocalizations.of(context)!.profile,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _authInstance.currentUser!.displayName.toString(),
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        _authInstance.currentUser!.email.toString(),
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.editProfile,
                      style: GoogleFonts.prompt(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                AppLocalizations.of(context)!.preferences,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffd4d4d4)))),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, size: 30),
                        const SizedBox(width: 10),
                        Text(AppLocalizations.of(context)!.language,
                            style: GoogleFonts.prompt(
                                textStyle: const TextStyle(fontSize: 16)))
                      ],
                    ),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context)!.languageName,
                            style: GoogleFonts.prompt(
                                textStyle: const TextStyle(fontSize: 16))),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios, size: 15)
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseLanguageScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
