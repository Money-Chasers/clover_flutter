import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/data_models/question_model.dart';
import 'package:clover_flutter/data_models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BackendHelper {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final _authInstance = FirebaseAuth.instance;

  static User? get getCurrentUser => _authInstance.currentUser;

  static Future checkIfEducationIsSet() {
    return _firestoreInstance
        .collection('users')
        .where('email', isEqualTo: getCurrentUser!.email)
        .where('education', isEqualTo: 0)
        .get();
  }

  static Future createUserWithEmailAndPassword(name, email, password) {
    Future future1 = _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    Future future2 = _firestoreInstance
        .collection('users')
        .add(UserModel(name: name, email: email, education: 0).toJson());
    return Future.wait([future1, future2]);
  }

  static Future signInWithEmailAndPassword(email, password) {
    return _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future signOut() {
    return _authInstance.signOut();
  }

  static Future updateUserEmail(newEmail, password) {
    final oldEmail = getCurrentUser!.email;
    Future future1 = _authInstance
        .signInWithEmailAndPassword(
            email: oldEmail.toString(), password: password)
        .then((_) {
      _firestoreInstance
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
    });

    Future future2 = getCurrentUser!.updateEmail(newEmail);
    return Future.wait([future1, future2]);
  }

  static Future updateUserPassword(oldPassword, newPassword) {
    return _authInstance
        .signInWithEmailAndPassword(
            email: getCurrentUser!.email.toString(), password: oldPassword)
        .then((value) {
      getCurrentUser!.updatePassword(newPassword);
    });
  }

  static Future addQuestionPaper(
      String paperTitle, List<QuestionModel> questionModels) {
    final _batchQuestions = _firestoreInstance.batch();
    final List<String> _questionIds = [];
    final _tagsUnion = <String>{};
    for (var element in questionModels) {
      var docRef = _firestoreInstance.collection("questions").doc();
      _questionIds.add(docRef.id);
      _tagsUnion.union(element.questionTags.toSet());
      _batchQuestions.set(
          docRef,
          QuestionModel(
                  element.questionText, element.options, element.questionTags)
              .toJson());
    }
    Future future1 = _batchQuestions.commit();
    Future future2 = _firestoreInstance.collection('questionPapers').add(
        PaperModel(paperTitle, _questionIds, _tagsUnion.toList(growable: false))
            .toJson());

    return Future.wait([future1, future2]);
  }

  static fetchQuestionPapers() {
    return _firestoreInstance.collection('questionPapers').get();
  }
}
