import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/screens/main_screen/navigation_drawer/settings_screen/account_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _authInstance = FirebaseAuth.instance;
final _firestoreInstance = FirebaseFirestore.instance;

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
      return 'English';
  }
}

void updateUserEmail(context, newEmail, password) {
  final oldEmail = _authInstance.currentUser!.email;
  _authInstance
      .signInWithEmailAndPassword(
          email: oldEmail.toString(), password: password)
      .then((_) {
    Future future1 = _firestoreInstance
        .collection('users')
        .where('email', isEqualTo: oldEmail)
        .get()
        .then((value) {
      final requiredDocId = value.docs[0].id;
      _firestoreInstance
          .collection('users')
          .doc(requiredDocId)
          .update({'email': newEmail});
    });
    Future future2 = _authInstance.currentUser!.updateEmail(newEmail);

    Future.wait([future1, future2]).then((_) {
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
