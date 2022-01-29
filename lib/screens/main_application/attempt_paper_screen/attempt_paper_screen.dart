import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/attempt_paper_screen/paper_analysis_screen.dart';
import 'package:clover_flutter/screens/main_application/attempt_paper_screen/state_management/question_paper_state.dart';
import 'package:clover_flutter/screens/main_application/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class AttemptPaperScreen extends StatefulWidget {
  final PaperModel paperModel;
  const AttemptPaperScreen({Key? key, required this.paperModel})
      : super(key: key);

  @override
  _AttemptPaperScreenState createState() => _AttemptPaperScreenState();
}

class _AttemptPaperScreenState extends State<AttemptPaperScreen> {
  int _currentQuestionIndex = 0;

  @override
  initState() {
    super.initState();

    // update to the passed model while starting to give the paper( load the paper model ).
    questionPaperAttemptService.update(widget.paperModel);
  }

  QuestionModel _getCurrentQuestionModel(int index, PaperModel paperModel) {
    return paperModel.questionModels[index];
  }

  void _handleConfirmLeaveTest() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardSection()),
        (route) => false);
  }

  void _handleCancelLeaveTest() {
    Navigator.pop(context);
  }

  void _handlePreviousButtonClick() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex -= 1;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Do you really want to leave the test ?'),
          actions: [
            TextButton(
                onPressed: _handleCancelLeaveTest, child: const Text('No')),
            TextButton(
                onPressed: _handleConfirmLeaveTest, child: const Text('Yes'))
          ],
        ),
      );
    }
  }

  void _handleConfirmSubmitTest() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PaperAnalysisScreen(correctPaperModel: widget.paperModel)));
  }

  void _handleCancelSubmitTest() {
    Navigator.pop(context);
  }

  void _handleNextButtonClick() {
    if (_currentQuestionIndex < widget.paperModel.questionModels.length - 1) {
      setState(() {
        _currentQuestionIndex += 1;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Do you really want to submit the test ?'),
          actions: [
            TextButton(
                onPressed: _handleCancelSubmitTest, child: const Text('No')),
            TextButton(
                onPressed: _handleConfirmSubmitTest, child: const Text('Yes'))
          ],
        ),
      );
    }
  }

  void _handleOptionBoolClick(int questionIndex, int index) {
    PaperModel _currentPaperModel = questionPaperAttemptService.current;
    _currentPaperModel.questionModels[questionIndex].options[index].isCorrect =
        !_currentPaperModel
            .questionModels[questionIndex].options[index].isCorrect;
    questionPaperAttemptService.update(_currentPaperModel);
  }

  Widget _buildOption(int index, OptionModel optionModel) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1),
          color: optionModel.isCorrect
              ? Colors.lightGreenAccent
              : Colors.redAccent,
        ),
        child: Text('${index + 1}. ${optionModel.text}'),
      ),
      onTap: () {
        _handleOptionBoolClick(_currentQuestionIndex, index);
      },
    );
  }

  List<Widget> _buildOptions(List<OptionModel> optionModels) {
    List<Widget> _optionsList = [];
    optionModels.asMap().forEach((key, value) {
      _optionsList.add(_buildOption(key, value));
    });
    return _optionsList;
  }

  void _handleCancelChooseQuestionModal() {
    Navigator.pop(context);
  }

  void _handleChooseQuestion(int index) {
    setState(() {
      _currentQuestionIndex = index;
    });
    Navigator.pop(context);
  }

  Widget _buildChooseQuestionModalItem(int index) {
    return ElevatedButton(
      onPressed: () {
        _handleChooseQuestion(index);
      },
      child: Text(
        (index + 1).toString(),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
    );
  }

  List<Widget> _buildChooseQuestionModalItems(int nItems) {
    List<Widget> items = [];
    for (int i = 0; i < nItems; i++) {
      items.add(_buildChooseQuestionModalItem(i));
    }
    return items;
  }

  void _showChooseQuestionList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: _buildChooseQuestionModalItems(
                    widget.paperModel.questionModels.length),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleCancelChooseQuestionModal,
              child: const Text('Cancel'),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainWidget(PaperModel paperModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Q. ${_currentQuestionIndex + 1}/${paperModel.questionModels.length}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Theme.of(context).primaryColorLight,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  _getCurrentQuestionModel(_currentQuestionIndex, paperModel)
                      .questionText,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildOptions(
                    _getCurrentQuestionModel(_currentQuestionIndex, paperModel)
                        .options),
              ),
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _handlePreviousButtonClick,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.arrow_left),
                      Text(_currentQuestionIndex == 0
                          ? 'Leave test'
                          : 'Previous'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _showChooseQuestionList,
                child: const Icon(Icons.menu),
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleNextButtonClick,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_currentQuestionIndex ==
                              paperModel.questionModels.length - 1
                          ? 'Submit test'
                          : 'Next'),
                      const Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attempt paper'),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: questionPaperAttemptService.stream$,
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
    );
  }
}
