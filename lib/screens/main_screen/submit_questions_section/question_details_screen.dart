import 'package:clover_flutter/data_models/question_model.dart';
import 'package:clover_flutter/utils/constant_values.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final String title;
  final String nQuestions;

  const QuestionDetailsScreen(
      {Key? key, required this.title, required this.nQuestions})
      : super(key: key);

  @override
  _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionFieldController = TextEditingController();
  List<String> _selectedTags = [];
  List<QuestionOption> _optionsList = [];
  List<QuestionModel> _fullQuestionList = [];

  int _currentQuestionIndex = 0;

  _QuestionDetailsScreenState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fullQuestionList =
          List.filled(int.parse(widget.nQuestions), QuestionModel('', [], []));
    });
  }

  void _recordState() {
    final _optionModelList = _optionsList
        .map((element) => OptionModel(element.text, element.isCorrectOption))
        .toList(growable: false);
    _fullQuestionList[_currentQuestionIndex] = QuestionModel(
        _questionFieldController.text, _optionModelList, _selectedTags);
  }

  _handleForwardButtonPress() {
    if (_formKey.currentState!.validate()) {
      if (_currentQuestionIndex < int.parse(widget.nQuestions) - 1) {
        _recordState();
        setState(() {
          _currentQuestionIndex += 1;
        });
        initState();
      } else {
        // if last question
      }
    }
  }

  _handleBackButtonPress() {
    if (_currentQuestionIndex > 0) {
      _recordState();
      setState(() {
        _currentQuestionIndex -= 1;
      });
      initState();
    }
  }

  void _eraseState() {
    _fullQuestionList[_currentQuestionIndex] = QuestionModel('', [], []);
    initState();
  }

  @override
  void initState() {
    if (_fullQuestionList.isNotEmpty) {
      setState(() {
        _questionFieldController.text =
            _fullQuestionList[_currentQuestionIndex].questionText;
        _selectedTags.clear();
        // _selectedTags = _fullQuestionList[_currentQuestionIndex].questionTags
        //     as List<String>;
        _optionsList =
            _fullQuestionList[_currentQuestionIndex].options.map((element) {
          final tempQuestionOption = QuestionOption();
          tempQuestionOption.text = element.text;
          tempQuestionOption.isCorrectOption = element.isCorrect;
          return tempQuestionOption;
        }).toList(growable: false);
      });
    }
    super.initState();
  }

  _buildButton(icon, callbackFunction) {
    return InkWell(
      child: Icon(icon, size: 30),
      onTap: callbackFunction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.questionDetails),
          actions: [
            InkWell(child: const Icon(Icons.refresh), onTap: _eraseState),
            const SizedBox(width: 10)
          ]),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _questionFieldController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .fieldRequired;
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: MyApp.of(context)!.getDarkMode()
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                border: const OutlineInputBorder(),
                                hintText: AppLocalizations.of(context)!
                                    .enterQuestionText,
                                prefixIcon: const Icon(Icons.short_text)),
                            minLines: 6,
                            maxLines: 6),
                        if (_optionsList.isNotEmpty) const SizedBox(height: 20),
                        ..._optionsList,
                        const SizedBox(height: 20),
                        if (_optionsList.length < 6)
                          MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _optionsList.add(QuestionOption());
                                });
                              },
                              color: Theme.of(context).primaryColor,
                              child: const Icon(Icons.add, size: 30),
                              padding: const EdgeInsets.all(10),
                              shape: const CircleBorder()),
                        if (_optionsList.length < 6) const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownSearch<String>.multiSelection(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  items: QUESTION_TAGS,
                  dropdownSearchDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.selectTagsForQuestion,
                      filled: true,
                      fillColor: MyApp.of(context)!.getDarkMode()
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      prefixIcon: const Icon(Icons.label)),
                  selectedItems: _selectedTags,
                  onChanged: (selectedItems) {
                    setState(() {
                      _selectedTags = selectedItems;
                    });
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(Icons.arrow_back_ios, _handleBackButtonPress),
                  const SizedBox(width: 10),
                  Expanded(
                      child: LinearProgressIndicator(
                          value: (_currentQuestionIndex + 1) /
                              (int.parse(widget.nQuestions)))),
                  const SizedBox(width: 10),
                  _buildButton(
                      Icons.arrow_forward_ios, _handleForwardButtonPress),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionOption extends StatefulWidget {
  bool isCorrectOption = false;
  String text = '';

  QuestionOption({Key? key}) : super(key: key);

  @override
  State<QuestionOption> createState() => _QuestionOptionState();
}

class _QuestionOptionState extends State<QuestionOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: TextFormField(
                  initialValue: widget.text,
                  onChanged: (value) {
                    setState(() {
                      widget.text = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.enterOptionText,
                      filled: true,
                      fillColor: MyApp.of(context)!.getDarkMode()
                          ? Theme.of(context).primaryColor
                          : Colors.white),
                  minLines: 2,
                  maxLines: 2)),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: MyApp.of(context)!.getDarkMode()
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: Colors.grey)),
            child: Row(
              children: [
                InkWell(
                  child: CircleAvatar(
                      radius: 18,
                      child: const Icon(Icons.check),
                      backgroundColor:
                          widget.isCorrectOption ? Colors.green : Colors.grey),
                  onTap: () {
                    setState(() {
                      widget.isCorrectOption = true;
                    });
                  },
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          widget.isCorrectOption ? Colors.grey : Colors.red,
                      child: const Icon(Icons.close)),
                  onTap: () {
                    setState(() {
                      widget.isCorrectOption = false;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
