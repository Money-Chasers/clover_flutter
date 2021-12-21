import 'package:clover_flutter/screens/main_screen/dashboard_section/settings_screen/account_settings.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:clover_flutter/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  _UpdateEmailScreenState createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final _authInstance = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _newEmailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _passwordVisible = false;

  _handleFormSubmit(newEmail, password) {
    _authInstance
        .signInWithEmailAndPassword(
            email: _authInstance.currentUser!.email.toString(),
            password: password)
        .then((value) {
      _authInstance.currentUser!.updateEmail(newEmail).then((value) {
        showSnackBarMessage(
            context, AppLocalizations.of(context)!.emailUpdatedSuccessfully);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AccountSettingsScreen()));
      });
    }).onError((error, stackTrace) {
      showSnackBarMessage(
          context, generateAuthExceptionString(context, error.hashCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.updateEmail)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildSvg('assets/images/email.svg'),
                const SizedBox(height: 40),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorLight),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autofillHints: const [AutofillHints.email],
                          controller: _newEmailFieldController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: MyApp.of(context)!.getDarkMode()
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              prefixIcon: const Icon(Icons.email),
                              border: const OutlineInputBorder(),
                              hintText:
                                  AppLocalizations.of(context)!.enterNewEmail),
                          style: GoogleFonts.prompt(
                              textStyle: const TextStyle(fontSize: 18)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .fieldRequired;
                            } else if (!checkEmailValid(value)) {
                              return AppLocalizations.of(context)!.invalidEmail;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autofillHints: const [AutofillHints.password],
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  child: _passwordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  }),
                              filled: true,
                              fillColor: MyApp.of(context)!.getDarkMode()
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              prefixIcon: const Icon(Icons.password),
                              border: const OutlineInputBorder(),
                              hintText:
                                  AppLocalizations.of(context)!.enterPassword),
                          controller: _passwordFieldController,
                          style: GoogleFonts.prompt(
                              textStyle: const TextStyle(fontSize: 18)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .fieldRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        buildButton(AppLocalizations.of(context)!.updateEmail,
                            () {
                          if (_formKey.currentState!.validate()) {
                            _handleFormSubmit(_newEmailFieldController.text,
                                _passwordFieldController.text);
                          }
                        })
                      ],
                    ),
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
