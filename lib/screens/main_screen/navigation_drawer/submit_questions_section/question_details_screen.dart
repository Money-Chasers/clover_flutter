import 'package:clover_flutter/data_models/question_model.dart';
import 'package:clover_flutter/screens/main_screen/navigation_drawer/submit_questions_section/paper_summary_screen.dart';
import 'package:clover_flutter/utils/constant_values.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../main.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final String paperTitle;
  final int nQuestions;

  const QuestionDetailsScreen(
      {Key? key, required this.paperTitle, required this.nQuestions})
      : super(key: key);

  @override
  _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionModel> _allQuestionModels = [];
  final TextEditingController _controller = TextEditingController();

  int _currentQuestionIndex = 0;

  List<Widget> _buildQuestionOptions(int index) {
    return _getQuestionModel(_currentQuestionIndex)
        .options
        .map((e) => Option(state: e))
        .toList();
  }

  void _handleForwardButtonPress() {
    if (_formKey.currentState!.validate()) {
      if (_currentQuestionIndex < widget.nQuestions - 1) {
        setState(() {
          _currentQuestionIndex += 1;
          _controller.text =
              _getQuestionModel(_currentQuestionIndex).questionText;
        });
      } else {
        // if last question
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaperSummaryScreen(
                    allQuestionModels: _allQuestionModels,
                    paperTitle: widget.paperTitle)));
      }
    }
  }

  void _handleBackButtonPress() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex -= 1;
        _controller.text =
            _getQuestionModel(_currentQuestionIndex).questionText;
      });
    }
  }

  QuestionModel _getQuestionModel(int index) {
    return _allQuestionModels.isNotEmpty
        ? _allQuestionModels[index]
        : QuestionModel('', [], []);
  }

  void _eraseState() {
    setState(() {
      _allQuestionModels[_currentQuestionIndex] = QuestionModel('', [], []);
      _controller.text = '';
    });
  }

  Widget _buildButton(icon, callbackFunction) {
    return InkWell(
      child: Icon(icon, size: 30),
      onTap: callbackFunction,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final List<QuestionModel> _tempList = [];
      for (var i = 0; i < widget.nQuestions; i++) {
        _tempList.add(QuestionModel('', [], []));
      }
      _allQuestionModels = _tempList;
    });
    super.initState();
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
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                _getQuestionModel(_currentQuestionIndex)
                                    .questionText = value;
                              });
                            },
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
                        if (_getQuestionModel(_currentQuestionIndex)
                            .options
                            .isNotEmpty)
                          const SizedBox(height: 20),
                        ..._buildQuestionOptions(_currentQuestionIndex),
                        const SizedBox(height: 20),
                        if (_getQuestionModel(_currentQuestionIndex)
                                .options
                                .length <
                            6)
                          MaterialButton(
                              onPressed: () {
                                final List<OptionModel> _tempListShort =
                                    List.from(
                                        _getQuestionModel(_currentQuestionIndex)
                                            .options);
                                _tempListShort.add(OptionModel('', false));
                                setState(() {
                                  _getQuestionModel(_currentQuestionIndex)
                                      .options = _tempListShort;
                                });
                              },
                              color: Theme.of(context).primaryColor,
                              child: const Icon(Icons.add, size: 30),
                              padding: const EdgeInsets.all(10),
                              shape: const CircleBorder()),
                        if (_getQuestionModel(_currentQuestionIndex)
                                .options
                                .length <
                            6)
                          const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownSearch<String>.multiSelection(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  items: questionTags,
                  dropdownSearchDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.selectTagsForQuestion,
                      filled: true,
                      fillColor: MyApp.of(context)!.getDarkMode()
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      prefixIcon: const Icon(Icons.label)),
                  selectedItems:
                      _getQuestionModel(_currentQuestionIndex).questionTags,
                  onChanged: (selectedItems) {
                    List<String> _tempListShort = List.from(
                        _getQuestionModel(_currentQuestionIndex).questionTags);
                    _tempListShort = selectedItems;
                    setState(() {
                      _getQuestionModel(_currentQuestionIndex).questionTags =
                          _tempListShort;
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
                              (widget.nQuestions))),
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

class Option extends StatefulWidget {
  final OptionModel state;

  const Option({Key? key, required this.state}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
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
                  initialValue: widget.state.text,
                  onChanged: (value) {
                    setState(() {
                      widget.state.text = value;
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
                          widget.state.isCorrect ? Colors.green : Colors.grey),
                  onTap: () {
                    setState(() {
                      widget.state.isCorrect = true;
                    });
                  },
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor:
                          widget.state.isCorrect ? Colors.grey : Colors.red,
                      child: const Icon(Icons.close)),
                  onTap: () {
                    setState(() {
                      widget.state.isCorrect = false;
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
