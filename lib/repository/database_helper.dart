import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/bloc/models/paper_model.dart';
import 'package:clover_flutter/bloc/models/user_model.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;
  static FirebaseFirestore get firestoreInstance => _firestoreInstance;

  static Future addUserInDatabase(UserModel userModel) {
    // put any value for parameters that are not going to be pushed to database, example, isSignedIn: true/false/null

    return firestoreInstance
        .collection('users')
        .add(userModel.toDatabaseJSON());
  }

  static Future getUserEmail(String userId) {
    return _firestoreInstance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();
  }

  static Future updateUserEmail(String userId, String newEmail) {
    return _firestoreInstance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      final requiredDocId = value.docs[0].id;
      _firestoreInstance
          .collection('users')
          .doc(requiredDocId)
          .update({'email': newEmail});
    });
  }

  static Future addQuestionPaper(PaperModel paperModel) {
    final _batchQuestions = _firestoreInstance.batch();
    for (QuestionModel questionModel in paperModel.questionModels) {
      var docRef = _firestoreInstance.collection("questions").doc();
      _batchQuestions.set(
          docRef,
          QuestionModel(const Uuid().v1(), questionModel.questionText,
                  questionModel.options)
              .toDatabaseJSON());
    }
    Future future1 = _batchQuestions.commit();
    Future future2 = _firestoreInstance
        .collection('questionPapers')
        .add(paperModel.toDatabaseJSON());

    return Future.wait([future1, future2]);
  }

  static fetchQuestionPapers() {
    return _firestoreInstance.collection('questionPapers').get();
  }

  static fetchQuestions(List<String> questionIds) {
    return _firestoreInstance
        .collection('questions')
        .where(FieldPath.documentId, whereIn: questionIds)
        .get();
  }
}
