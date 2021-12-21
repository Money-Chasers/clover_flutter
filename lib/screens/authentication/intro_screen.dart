import 'package:clover_flutter/screens/authentication/login_screen.dart';
import 'package:clover_flutter/screens/authentication/register_screen.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
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
          decoration: const BoxDecoration(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.white),
                    child: buildSvg('assets/images/questions.svg')),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.boostYourPreparation,
                  style: GoogleFonts.prompt(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                buildButton(
                  AppLocalizations.of(context)!.login,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.dontHaveAnAccount,
                    style: GoogleFonts.prompt(
                      textStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
