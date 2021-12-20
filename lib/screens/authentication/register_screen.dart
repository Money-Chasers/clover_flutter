import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/user_model.dart';
import 'package:clover_flutter/screens/authentication/education_screen.dart';
import 'package:clover_flutter/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  final _authInstance = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createAccount),),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: Image.asset('assets/images/register.png').image),
                  const SizedBox(height: 40),
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
                            controller: _nameFieldController,
                            autofillHints: const [AutofillHints.name],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.fieldRequired;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              hintText: AppLocalizations.of(context)!.enterName,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailFieldController,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.fieldRequired;
                              } else if (!(checkEmailValid(value))) {
                                return AppLocalizations.of(context)!.invalidEmail;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              hintText: AppLocalizations.of(context)!.enterEmail,
                              prefixIcon: const Icon(Icons.alternate_email),
                            ),
                            style: GoogleFonts.prompt(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordFieldController,
                            autofillHints: const [AutofillHints.newPassword],
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return AppLocalizations.of(context)!.passwordMinLength6;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              hintText: AppLocalizations.of(context)!.createPassword,
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
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var name = _nameFieldController.text;
                                    var email = _emailFieldController.text;
                                    var password =
                                        _passwordFieldController.text;
                                    _authInstance
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password)
                                        .then((tempAuthInstance) => tempAuthInstance.user
                                            ?.updateDisplayName(name)
                                            .then((value) => firestoreInstance
                                                .collection('users')
                                                .add(UserModel(
                                                        name: name,
                                                        email: email,
                                                        education: "0")
                                                    .toJson())
                                                .then((value) => Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const EducationScreen()),
                                                    (e) => false))))
                                        .onError((error, stackTrace) {
                                      showSnackBarMessage(
                                          context,
                                          generateAuthExceptionString(
                                              error.hashCode));
                                    });
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.createAccount,
                                  style: GoogleFonts.prompt(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
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
