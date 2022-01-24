import 'package:clover_flutter/screens/authentication/education_screen.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
import 'package:clover_flutter/components/common_widgets.dart';
import 'package:clover_flutter/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createAccount)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.white),
                    child: buildSvg('assets/images/register.svg')),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColorLight),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _nameFieldController,
                            autofillHints: const [AutofillHints.name],
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
                              hintText: AppLocalizations.of(context)!.enterName,
                              prefixIcon: const Icon(Icons.person),
                            ),
                            style: Theme.of(context).textTheme.subtitle2),
                        const SizedBox(height: 20),
                        TextFormField(
                            controller: _emailFieldController,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .fieldRequired;
                              } else if (!(checkEmailValid(value))) {
                                return AppLocalizations.of(context)!
                                    .invalidEmail;
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
                            style: Theme.of(context).textTheme.subtitle2),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _passwordFieldController,
                            autofillHints: const [AutofillHints.newPassword],
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return AppLocalizations.of(context)!
                                    .passwordMinLength6;
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
                                  AppLocalizations.of(context)!.createPassword,
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
                            style: Theme.of(context).textTheme.subtitle2),
                        const SizedBox(height: 20),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BackendHelper.createUserWithEmailAndPassword(
                                          _nameFieldController.text,
                                          _emailFieldController.text,
                                          _passwordFieldController.text)
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EducationScreen()),
                                        (route) => false);
                                  }).catchError((error) {
                                    buildSnackBarMessage(
                                        context,
                                        AppLocalizations.of(context)!
                                            .anErrorOccurred);
                                  });
                                }
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.createAccount,
                                  style: Theme.of(context).textTheme.subtitle2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40)
              ], mainAxisAlignment: MainAxisAlignment.center),
            ),
          ),
        ),
      ),
    );
  }
}
