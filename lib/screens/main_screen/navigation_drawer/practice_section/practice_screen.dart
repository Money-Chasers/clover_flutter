import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_screen/navigation_drawer/practice_section/attempt_paper_screen.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({Key? key}) : super(key: key);

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<PaperModel> _paperModels = [];

  _PracticeScreenState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BackendHelper.fetchQuestionPapers().then((QuerySnapshot snapshot) {
        final _requiredDocs = snapshot.docs;
        setState(() {
          _paperModels = _requiredDocs.map((DocumentSnapshot doc) {
            Map<String, dynamic> _requiredData =
                doc.data() as Map<String, dynamic>;
            List<String> _questionIdsStringList =
                _requiredData['questionIds'].map<String>((value) {
              return value.toString();
            }).toList(growable: false);
            List<String> _paperTagsStringList =
                _requiredData['paperTags'].map<String>((value) {
              return value.toString();
            }).toList(growable: false);
            return PaperModel(_requiredData['paperTitle'],
                _questionIdsStringList, _paperTagsStringList);
          }).toList(growable: false);
        });
      });
    });
  }

  Widget _buildQuestionPaperTile(PaperModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AttemptPaperScreen(questionIds: model.questionIds)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(4)),
        child: Text(model.paperTitle,
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ..._paperModels
                        .map((e) => _buildQuestionPaperTile(e))
                        .toList(growable: false)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
