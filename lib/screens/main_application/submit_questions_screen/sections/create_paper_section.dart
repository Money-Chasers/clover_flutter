import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/add_question_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/sections/paper_details_section.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/state_management/question_paper_state.dart';
import 'package:flutter/material.dart';

class CreatePaperSection extends StatefulWidget {
  const CreatePaperSection({Key? key}) : super(key: key);

  @override
  _CreatePaperSectionState createState() => _CreatePaperSectionState();
}

class _CreatePaperSectionState extends State<CreatePaperSection> {
  void _handleSaveClick() {}

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

  Widget _buildQuestion(QuestionModel questionModel) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            questionModel.questionText,
            maxLines: 3,
          ),
        ],
      ),
    );
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
              children: paperModel.questionModels
                  .map((e) => _buildQuestion(e))
                  .toList(growable: false),
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
