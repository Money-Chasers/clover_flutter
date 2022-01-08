import 'package:clover_flutter/data_models/paper_model.dart';
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
      BackendHelper.fetchQuestionPapers().then((snapshot) {
        setState(() {
          _paperModels = snapshot.docs.map<PaperModel>((doc) {
            final Map _requiredData = doc.data();
            return PaperModel(
                _requiredData['paperTitle'],
                _requiredData['questionIds'] as List<String>,
                _requiredData['paperTags']  as List<String>);
          }).toList(growable: false);
        });
      });
    });
  }

  Widget _buildQuestionPaperTile(PaperModel model) {
    return Container(
      child: Text(model.paperTitle),
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
