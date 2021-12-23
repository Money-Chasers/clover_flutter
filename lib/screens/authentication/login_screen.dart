import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/main.dart';
import 'package:clover_flutter/screens/authentication/education_screen.dart';
import 'package:clover_flutter/screens/main_screen/main_screen.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:clover_flutter/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  final _authInstance = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isPasswordVisible = false;

  _handleValidation(email, password) {
    _authInstance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => firestoreInstance
            .collection('users')
            .where('email', isEqualTo: email)
            .where('education', isNotEqualTo: "0")
            .get()
            .then((snapshot) => {
                  if (snapshot.docs.isEmpty)
                    {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EducationScreen()),
                          (e) => false)
                    }
                  else
                    {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (e) => false)
                    }
                }))
        .catchError((error) {
      showSnackBarMessage(
          context, generateAuthExceptionString(context, error.hashCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.login)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildSvg('assets/images/login.svg'),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorLight,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailFieldController,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .fieldRequired;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: MyApp.of(context)!.getDarkMode()
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              border: const OutlineInputBorder(),
                              hintText:
                                  AppLocalizations.of(context)!.enterEmail,
                              prefixIcon: const Icon(Icons.email),
                            ),
                            style: GoogleFonts.prompt(
                                textStyle: const TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordFieldController,
                            autofillHints: const [AutofillHints.password],
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .fieldRequired;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: MyApp.of(context)!.getDarkMode()
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              border: const OutlineInputBorder(),
                              hintText:
                                  AppLocalizations.of(context)!.enterPassword,
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: InkWell(
                                child: _isPasswordVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onTap: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            style: GoogleFonts.prompt(
                                textStyle: const TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(height: 20),
                          buildButton(AppLocalizations.of(context)!.login, () {
                            if (_formKey.currentState!.validate()) {
                              _handleValidation(_emailFieldController.text,
                                  _passwordFieldController.text);
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
