import 'package:clover_flutter/screens/main_screen/dashboard_section/settings_screen/account_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _authInstance = FirebaseAuth.instance;

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

void updateUserEmail(context, newEmail, password) {
  _authInstance
      .signInWithEmailAndPassword(
          email: _authInstance.currentUser!.email.toString(),
          password: password)
      .then((value) {
    _authInstance.currentUser!.updateEmail(newEmail).then((value) {
      showSnackBarMessage(
          context, AppLocalizations.of(context)!.emailUpdatedSuccessfully);
      Navigator.pop(context);
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

void updateUserPassword(context, oldPassword, newPassword) {
  _authInstance
      .signInWithEmailAndPassword(
          email: _authInstance.currentUser!.email.toString(),
          password: oldPassword)
      .then((value) {
    _authInstance.currentUser!.updatePassword(newPassword).then((value) {
      showSnackBarMessage(
          context, AppLocalizations.of(context)!.passwordUpdatedSuccessfully);
      Navigator.pop(context);
    });
  }).onError((error, stackTrace) {
    showSnackBarMessage(
        context, generateAuthExceptionString(context, error.hashCode));
  });
}
