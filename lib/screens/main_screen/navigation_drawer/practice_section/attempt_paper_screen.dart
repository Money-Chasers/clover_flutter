import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clover_flutter/data_models/question_model.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
import 'package:clover_flutter/utils/common_widgets.dart';
import 'package:flutter/material.dart';

class AttemptPaperScreen extends StatefulWidget {
  final List<String> questionIds;
  const AttemptPaperScreen({Key? key, required this.questionIds})
      : super(key: key);

  @override
  _AttemptPaperScreenState createState() => _AttemptPaperScreenState();
}

class _AttemptPaperScreenState extends State<AttemptPaperScreen> {
  List<QuestionModel> _allQuestionModels = [];
  int _currentQuestionIndex = 0;
  int _currentSelectedOptionIndex = -1;

  _AttemptPaperScreenState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BackendHelper.fetchQuestions(widget.questionIds)
          .then((QuerySnapshot value) {
        List<QuestionModel> _tempList = [];
        _tempList = value.docs.map((DocumentSnapshot doc) {
          final _requiredData = doc.data() as Map<String, dynamic>;

          List<OptionModel> _questionOptionsModelList =
          _requiredData['options'].map<OptionModel>((value) {
            return OptionModel(value['text'], value['isCorrect']);
          }).toList(growable: false);

          List<String> _questionTagsStringList =
          _requiredData['questionTags'].map<String>((value) {
            return value.toString();
          }).toList(growable: false);

          return QuestionModel(_requiredData['questionText'],_questionOptionsModelList, _questionTagsStringList);
        }).toList(growable: false);
        setState(() {
          _allQuestionModels = _tempList;
        });
      });
    });
  }

  QuestionModel _getCurrentQuestionModel(int index) {
    if (_allQuestionModels.isNotEmpty) {
      return _allQuestionModels[index];
    } else {
      return QuestionModel('', [], []);
    }
  }

  Widget _buildQuestionTextCard(index) {
    QuestionModel _currentQuestionModel = _getCurrentQuestionModel(index);

    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(width: 1), borderRadius: BorderRadius.circular(4)),
      child: Text(_currentQuestionModel.questionText,
          style: Theme.of(context).textTheme.bodyText1),
    );
  }

  List<Widget> _buildQuestionOptions(int index) {
    Widget _buildQuestionOption(String text, bool isCorrect, myIndex) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(4),
          color: _currentSelectedOptionIndex == myIndex
              ? Theme.of(context).primaryColorLight
              : Colors.white,
        ),
        child: Text(text, style: Theme.of(context).textTheme.bodyText1),
      );
    }

    List<OptionModel> _currentQuestionOptions =
        _getCurrentQuestionModel(index).options;
    List<Widget> _returnList = [];
    for (int i = 0; i < _currentQuestionOptions.length; i++) {
      _returnList.add(_buildQuestionOption(_currentQuestionOptions[i].text,
          _currentQuestionOptions[i].isCorrect, i));
    }
    return _returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attempt Paper'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                _buildQuestionTextCard(_currentQuestionIndex),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: _buildQuestionOptions(_currentQuestionIndex)),
                  ),
                ),
                buildButton(context, 'Next', () {
                  if (_currentQuestionIndex + 1 < widget.questionIds.length) {
                    setState(() {
                      _currentQuestionIndex += 1;
                    });
                  } else {
                    buildSnackBarMessage(context, 'Last Question it was!');
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
