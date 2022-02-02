import 'package:clover_flutter/components/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.welcome,
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.headline2)),
                const SizedBox(height: 30),
                Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.white),
                    child: buildSvg('assets/images/questions.svg')),
                const SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.boostYourPreparation,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                buildButton(
                  context,
                  AppLocalizations.of(context)!.login,
                  () {
                    Navigator.of(context).pushNamed('/login');
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Text(AppLocalizations.of(context)!.dontHaveAnAccount,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
