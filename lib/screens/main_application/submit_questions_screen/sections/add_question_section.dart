import 'package:clover_flutter/components/common_widgets.dart';
import 'package:clover_flutter/components/drawer/component/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/submit_questions_screen/state_management/submit_paper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddQuestionSection extends StatefulWidget {
  const AddQuestionSection({Key? key}) : super(key: key);

  @override
  _AddQuestionSectionState createState() => _AddQuestionSectionState();
}

class _AddQuestionSectionState extends State<AddQuestionSection> {
  final _formKey = GlobalKey<FormState>();

  QuestionModel _currentQuestionModel =
      QuestionModel(const Uuid().v1(), '', []);

  void _handleChangeQuestionTextField(String value) {
    setState(() {
      _currentQuestionModel.questionText = value;
    });
  }

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  void _addNewOption() {
    setState(() {
      _currentQuestionModel.options.add(OptionModel('', false));
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

  void _handleOptionBoolClick(int index) {
    setState(() {
      _currentQuestionModel.options[index].isCorrect =
          !_currentQuestionModel.options[index].isCorrect;
    });
  }

  void _confirmAddQuestion() {
    if (_formKey.currentState!.validate()) {
      submitPaperBloc.submitPaperEventSink.add({
        'type': submitPaperActions.addQuestion,
        'payload': (_currentQuestionModel),
      });
      Navigator.pop(context);
    }
  }

  void _handleOptionTextChange(String value, int index) {
    setState(() {
      _currentQuestionModel.options[index].text = value;
    });
  }

  void _handleResetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _currentQuestionModel = QuestionModel(const Uuid().v1(), '', []);
    });
  }

  Widget _buildOption(int index, OptionModel optionModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: optionModel.isCorrect
                              ? Colors.green
                              : Colors.red),
                    ),
                    onTap: () {
                      _handleOptionBoolClick(index);
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: optionModel.text,
                      onChanged: (String value) {
                        _handleOptionTextChange(value, index);
                      },
                      validator: _validateTextField,
                      decoration:
                          const InputDecoration(hintText: 'Enter option'),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              child: const Icon(Icons.delete, color: Colors.red),
              onTap: () {
                _removeOption(index);
              },
            ),
          ],
        ),
        const SizedBox(height: 20)
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

  ElevatedButton _buildAddOptionButton(bool enabled) {
    return ElevatedButton(
      onPressed: enabled ? _addNewOption : () {},
      child: const Icon(Icons.add, size: 30),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(5),
        splashFactory:
            enabled ? InkRipple.splashFactory : NoSplash.splashFactory,
        shadowColor:
            enabled ? Theme.of(context).shadowColor : Colors.transparent,
        primary: enabled ? Theme.of(context).primaryColor : Colors.grey,
      ),
    );
  }

  Widget _buildMainWidget(PaperModel paperModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onChanged: (String value) {
                _handleChangeQuestionTextField(value);
              },
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
                _buildAddOptionButton(_currentQuestionModel.options.length < 6)
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _buildOptions(),
                ),
              ),
            ),
            buildButton(context, 'Add question', _confirmAddQuestion)
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
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                child: const Icon(Icons.restart_alt),
                onTap: _handleResetForm,
              ),
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: submitPaperBloc.submitPaperStream,
        initialData: submitPaperBloc.current,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return _buildMainWidget(snap.data);
        },
      ),
    );
  }
}
