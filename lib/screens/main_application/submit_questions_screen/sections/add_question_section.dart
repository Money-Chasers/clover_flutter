import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/state_management/question_paper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddQuestionSection extends StatefulWidget {
  const AddQuestionSection({Key? key}) : super(key: key);

  @override
  _AddQuestionSectionState createState() => _AddQuestionSectionState();
}

class _AddQuestionSectionState extends State<AddQuestionSection> {
  final _formKey = GlobalKey<FormState>();

  final QuestionModel _currentQuestionModel = QuestionModel('', [], []);

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  void _addNewOption() {
    setState(() {
      _currentQuestionModel.options.add(OptionModel('text', true));
    });
  }

  void _removeOption(int index) {
    List<OptionModel> _tempOptionModels = [];

    for (int i = 0; i < _currentQuestionModel.options.length; i++) {
      if (i != index) {
        _tempOptionModels.add(_currentQuestionModel.options[i]);
      }
    }

    setState(() {
      _currentQuestionModel.options = _tempOptionModels;
    });
  }

  Widget _buildOption(int index, OptionModel optionModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // TextFormField(
            //   validator: _validateTextField,
            //   decoration: const InputDecoration(hintText: 'Enter option'),
            // )
          ],
        ),
        InkWell(
          child: const Icon(Icons.delete, color: Colors.red),
          onTap: () {
            _removeOption(index);
          },
        )
      ],
    );
  }

  List<Widget> _buildOptions() {
    List<Widget> _optionsList = [];
    _currentQuestionModel.options.asMap().forEach((index, value) {
      _optionsList.add(_buildOption(index, value));
    });
    return _optionsList;
  }

  Widget _buildMainWidget(PaperModel paperModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _currentQuestionModel.questionText,
              validator: _validateTextField,
              minLines: 6,
              maxLines: 6,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Theme.of(context).primaryColorLight),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Options', style: Theme.of(context).textTheme.headline4),
                ElevatedButton(
                  onPressed: _addNewOption,
                  child: const Icon(Icons.add, size: 30),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: Column(
                children: _buildOptions(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add question'),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: questionPaperService.stream$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return _buildMainWidget(snap.data);
        },
      ),
    );
  }
}
