import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/paper_model.dart';

class Paper {
  late List<PaperModel> papers;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late List<DocumentSnapshot?> paperDocs = [];
  late List<DocumentSnapshot?> quesDocs = [];

  Paper();

  void initializePapersData(List<String> tags) async {

    paperDocs = (await db.collection("papers").
    where("tags", arrayContainsAny: tags).get()).docs;

    //print(documents.length);
  }

  PaperModel? getPaper(String id) {
    PaperModel? paper;

    return paper;
  }

  void initializeQuestions(List<String?> ids) async {

    paperDocs = (await db.collection("papers").
    where(FieldPath.documentId, whereIn: ids).get()).docs;

  }

}
