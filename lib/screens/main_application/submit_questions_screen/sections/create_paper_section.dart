import 'package:clover_flutter/components/common_widgets.dart';
import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/dashboard_screen/dashboard_screen.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/add_question_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/edit_question_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/paper_details_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/state_management/question_paper_state.dart';
import 'package:clover_flutter/utils/backend_helper.dart';
import 'package:flutter/material.dart';

class CreatePaperSection extends StatefulWidget {
  const CreatePaperSection({Key? key}) : super(key: key);

  @override
  _CreatePaperSectionState createState() => _CreatePaperSectionState();
}

class _CreatePaperSectionState extends State<CreatePaperSection> {
  void _handleSaveClick() {
    BackendHelper.addQuestionPaper(questionPaperService.current).then((value) {
      buildSnackBarMessage(context, 'Task completed successfully!');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardSection()),
          (route) => false);
      questionPaperService.reset();
    }).onError(
        (error, stackTrace) => buildSnackBarMessage(context, 'Task failed!'));
  }

  void _handleEditPaperClick() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PaperDetailsSection()));
  }

  String _constructDurationString(List<int> durationArr) {
    String _hoursString = '';
    if (durationArr[0] > 0) {
      _hoursString = durationArr[0].toString() + " hours ";
    }
    String _minutesString = '';
    if (durationArr[1] > 0) {
      _minutesString = durationArr[1].toString() + " minutes";
    }
    return _hoursString + _minutesString;
  }

  void _handleFloatingActionButtonClick() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddQuestionSection()));
  }

  void _handleQuestionDeleteClick(int index) {
    // get updated questionModels list.
    List<QuestionModel> _tempQuestionModels = [];
    questionPaperService.current.questionModels.asMap().forEach((key, value) {
      if (key != index) {
        _tempQuestionModels.add(value);
      }
    });

    // now create a new paperModel with this list and add it to the stream.
    PaperModel _tempPaperModel = questionPaperService.current;
    _tempPaperModel.questionModels = _tempQuestionModels;
    questionPaperService.update(_tempPaperModel);
  }

  void _handleQuestionEditClick(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditQuestionSection(editIndex: index),
      ),
    );
  }

  Widget _buildQuestion(int index, QuestionModel questionModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            questionModel.questionText,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: const Icon(
                  Icons.edit,
                ),
                onTap: () {
                  _handleQuestionEditClick(index);
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  _handleQuestionDeleteClick(index);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildQuestions(PaperModel paperModel) {
    List<Widget> _tempQuestionsList = [];
    paperModel.questionModels.asMap().forEach((key, value) {
      _tempQuestionsList.add(_buildQuestion(key, value));
    });
    return _tempQuestionsList;
  }

  Widget _buildMainWidget(PaperModel paperModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minHeight: 200),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            border: const Border(bottom: BorderSide(width: 2)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    paperModel.paperTitle,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  InkWell(
                    child: const Icon(Icons.edit),
                    onTap: _handleEditPaperClick,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.timelapse, color: Colors.grey),
                  Text(_constructDurationString(paperModel.duration),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            Text('Questions', style: Theme.of(context).textTheme.headline4)
          ],
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: _buildQuestions(paperModel),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create paper'),
        actions: [
          InkWell(
            child: const Center(child: Text('Save')),
            onTap: _handleSaveClick,
          ),
          const SizedBox(width: 10)
        ],
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: questionPaperService.stream$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          switch (snap.connectionState) {
            case (ConnectionState.none):
            case ConnectionState.waiting:
              return const Center(
                child: Text('An error occurred!'),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snap.hasError) {
                return const Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return _buildMainWidget(snap.data);
              }
            default:
              return const Center(
                child: Text('An error occurred!'),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, size: 40),
          onPressed: _handleFloatingActionButtonClick),
    );
  }
}
