import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/paper_model.dart';

class Paper {
  late List<PaperModel> papers;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<DocumentSnapshot?> _paperDocs = [];
  List<DocumentSnapshot?> _quesDocs = [];

  Paper();

  Future<List<DocumentSnapshot<Object?>?>?> getPapers(List<String?> tags) async {

    _paperDocs = (await db.collection("papers").
    where("tags", arrayContainsAny: tags).get()).docs;

    return _paperDocs;
    //print(documents.length);
  }

  PaperModel? getPaper(String id) {
    PaperModel? paper;

    return paper;
  }

  void initializeQuestions(List<String?> ids) async {

    _quesDocs = (await db.collection("papers").
    where(FieldPath.documentId, whereIn: ids).get()).docs;

  }

}
