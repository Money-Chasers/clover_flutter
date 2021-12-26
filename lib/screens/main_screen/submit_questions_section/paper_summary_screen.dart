import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/data_models/question_model.dart';
import 'package:clover_flutter/screens/main_screen/main_screen.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaperSummaryScreen extends StatefulWidget {
  final String paperTitle;
  final List<QuestionModel> allQuestionModels;

  const PaperSummaryScreen(
      {Key? key, required this.paperTitle, required this.allQuestionModels})
      : super(key: key);

  @override
  _PaperSummaryScreenState createState() => _PaperSummaryScreenState();
}

class _PaperSummaryScreenState extends State<PaperSummaryScreen> {
  final _firestoreInstance = FirebaseFirestore.instance;

  void _submitQuestionPaper() {
    final _batchQuestions = _firestoreInstance.batch();
    final List<String> _questionIds = [];
    final _tagsUnion = <String>{};
    for (var element in widget.allQuestionModels) {
      var docRef = _firestoreInstance.collection("questions").doc();
      _questionIds.add(docRef.id);
      _tagsUnion.union(element.questionTags.toSet());
      _batchQuestions.set(
          docRef,
          QuestionModel(
                  element.questionText, element.options, element.questionTags)
              .toJson());
    }
    _batchQuestions.commit().then((_) {
      _firestoreInstance
          .collection('questionPapers')
          .add(PaperModel(widget.paperTitle, _questionIds,
                  _tagsUnion.toList(growable: false))
              .toJson())
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false);
      });
    });
  }

  List<Widget> _buildQuestionCards(List<QuestionModel> questionModels) {
    return questionModels
        .map((e) => Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1)),
              child: Text(e.questionText,
                  style: Theme.of(context).textTheme.bodyText1),
            ))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.questionPaperSummary)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(widget.paperTitle,
                  style: Theme.of(context).textTheme.headline3),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children:
                              _buildQuestionCards(widget.allQuestionModels)))),
              buildButton(
                  AppLocalizations.of(context)!.proceed, _submitQuestionPaper)
            ],
          ),
        ),
      ),
    );
  }
}
