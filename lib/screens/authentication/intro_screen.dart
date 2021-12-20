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
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image(
                    image: Image.asset("assets/images/questions.png").image,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.boostYourPreparation,
                  style: GoogleFonts.prompt(
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
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
