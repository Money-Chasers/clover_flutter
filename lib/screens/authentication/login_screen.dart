import 'dart:async';

import 'package:clover_flutter/bloc/streams/settings_bloc.dart';
import 'package:clover_flutter/bloc/streams/user_bloc.dart';
import 'package:clover_flutter/screens/main_application/dashboard_screen/dashboard_screen.dart';
import 'package:clover_flutter/components/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isPasswordVisible = false;

  late StreamSubscription _isSignedInStreamSubscription;

  @override
  void initState() {
    _isSignedInStreamSubscription =
        userBloc.isSignedInStream.listen((bool isSignedIn) {
      if (isSignedIn) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardSection()),
            (route) => false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _isSignedInStreamSubscription.cancel();

    super.dispose();
  }

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
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
                          StreamBuilder(
                              initialData: false,
                              stream: settingsBloc.darkModeStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snap) {
                                return TextFormField(
                                    controller: _emailFieldController,
                                    autofillHints: const [AutofillHints.email],
                                    validator: _validateTextField,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: snap.data!
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      border: const OutlineInputBorder(),
                                      hintText: AppLocalizations.of(context)!
                                          .enterEmail,
                                      prefixIcon: const Icon(Icons.email),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.subtitle2);
                              }),
                          const SizedBox(height: 20),
                          StreamBuilder(
                              initialData: false,
                              stream: settingsBloc.darkModeStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snap) {
                                return TextFormField(
                                    controller: _passwordFieldController,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    obscureText: !_isPasswordVisible,
                                    validator: _validateTextField,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: snap.data!
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      border: const OutlineInputBorder(),
                                      hintText: AppLocalizations.of(context)!
                                          .enterPassword,
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: InkWell(
                                        child: _isPasswordVisible
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onTap: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.subtitle2);
                              }),
                          const SizedBox(height: 20),
                          buildButton(
                              context, AppLocalizations.of(context)!.login, () {
                            if (_formKey.currentState!.validate()) {
                              userBloc.eventSink.add({
                                'type': userActions.signInWithEmailAndPassword,
                                'payload': {
                                  'email': _emailFieldController.text,
                                  'password': _passwordFieldController.text,
                                }
                              });
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
