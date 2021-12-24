import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:clover_flutter/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordFieldController = TextEditingController();
  final _newPasswordFieldController = TextEditingController();
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.changePassword)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildSvg('assets/images/password.svg'),
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
                          autofillHints: const [AutofillHints.password],
                          controller: _oldPasswordFieldController,
                          obscureText: !_oldPasswordVisible,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: MyApp.of(context)!.getDarkMode()
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: InkWell(
                                  child: _oldPasswordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onTap: () {
                                    setState(() {
                                      _oldPasswordVisible =
                                          !_oldPasswordVisible;
                                    });
                                  }),
                              border: const OutlineInputBorder(),
                              hintText: AppLocalizations.of(context)!
                                  .enterOldPassword),
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
                        TextFormField(
                          autofillHints: const [AutofillHints.newPassword],
                          obscureText: !_newPasswordVisible,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  child: _newPasswordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onTap: () {
                                    setState(() {
                                      _newPasswordVisible =
                                          !_newPasswordVisible;
                                    });
                                  }),
                              filled: true,
                              fillColor: MyApp.of(context)!.getDarkMode()
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              prefixIcon: const Icon(Icons.password),
                              border: const OutlineInputBorder(),
                              hintText: AppLocalizations.of(context)!
                                  .createNewPassword),
                          controller: _newPasswordFieldController,
                          style: GoogleFonts.prompt(
                              textStyle: const TextStyle(fontSize: 18)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .fieldRequired;
                            } else if (value.length < 6) {
                              return AppLocalizations.of(context)!
                                  .passwordMinLength6;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        buildButton(
                            AppLocalizations.of(context)!.changePassword, () {
                          if (_formKey.currentState!.validate()) {
                            updateUserPassword(
                                context,
                                _oldPasswordFieldController.text,
                                _newPasswordFieldController.text);
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
