import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool checkEmailValid(email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

void showSnackBarMessage(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String generateAuthExceptionString(context, errorCode) {
  switch (errorCode) {
    case (34618382):
      return 'An account already exists with this email!';
    case (505284406):
      return 'No user found with this email!';
    case (185768934):
      return AppLocalizations.of(context)!.incorrectPassword;
    default:
      return 'An error occurred';
  }
}

String getCountryCodeFromLanguageCode(languageCode) {
  switch (languageCode) {
    case ('hi'):
      return 'in';
    case ('en'):
      return 'us';
    default:
      return 'null';
  }
}

String getLanguageNameFromLanguageCode(languageCode) {
  switch (languageCode) {
    case ('en'):
      return 'English';
    case ('hi'):
      return 'हिन्दी';
    default:
      return 'null';
  }
}
