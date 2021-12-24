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
  final _questionFieldController = TextEditingController();

  List<String> _selectedTags = [];
  final List<Widget> _optionsList = [];

  _buildButton(icon, callbackFunction) {
    return InkWell(
      child: Icon(icon),
      onTap: callbackFunction,
    );
  }

  _handleForwardButtonPress() {}

  _handleBackButtonPress() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context)!.questionDetails)),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _questionFieldController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .fieldRequired;
                              }
                              return null;
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
                                  _optionsList.add(const QuestionOption());
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
                  onChanged: (selectedItems) {
                    setState(() {
                      _selectedTags = selectedItems;
                    });
                  },
                  selectedItems: _selectedTags),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(Icons.arrow_back_ios, _handleBackButtonPress()),
                  const SizedBox(width: 10),
                  Expanded(
                      child: LinearProgressIndicator(
                          value: 1 / (int.parse(widget.nQuestions)))),
                  const SizedBox(width: 10),
                  _buildButton(
                      Icons.arrow_forward_ios, _handleForwardButtonPress()),
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
  const QuestionOption({Key? key}) : super(key: key);

  @override
  _QuestionOptionState createState() => _QuestionOptionState();
}

class _QuestionOptionState extends State<QuestionOption> {
  final _optionFieldController = TextEditingController();
  bool _isCorrectAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: TextField(
                  controller: _optionFieldController,
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
                          _isCorrectAnswer ? Colors.green : Colors.grey),
                  onTap: () {
                    setState(() {
                      _isCorrectAnswer = true;
                    });
                  },
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          _isCorrectAnswer ? Colors.grey : Colors.red,
                      child: const Icon(Icons.close)),
                  onTap: () {
                    setState(() {
                      _isCorrectAnswer = false;
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
