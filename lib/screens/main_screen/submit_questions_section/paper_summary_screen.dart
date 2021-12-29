import 'package:clover_flutter/data_models/question_model.dart';
import 'package:clover_flutter/screens/main_screen/main_screen.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
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
  void _submitQuestionPaper() async {
    final checkValue = await BackendHelper.addQuestionPaper(
        widget.paperTitle, widget.allQuestionModels);
    if (checkValue != null) {
      if (checkValue) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false);
      }
    }
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
              buildButton(context, AppLocalizations.of(context)!.proceed,
                  _submitQuestionPaper)
            ],
          ),
        ),
      ),
    );
  }
}
