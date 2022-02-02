import 'package:clover_flutter/bloc/models/paper_model.dart';
import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/bloc/streams/attempt_paper_bloc.dart';
import 'package:clover_flutter/screens/main_application/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class AttemptPaperScreen extends StatefulWidget {
  const AttemptPaperScreen({Key? key}) : super(key: key);

  @override
  _AttemptPaperScreenState createState() => _AttemptPaperScreenState();
}

class _AttemptPaperScreenState extends State<AttemptPaperScreen> {
  Widget _buildOption(int index, OptionModel optionModel) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1),
          color: optionModel.isCorrect ? Colors.lightGreenAccent : Colors.white,
        ),
        child: Text('${index + 1}. ${optionModel.text}'),
      ),
      onTap: () {
        attemptPaperBloc.attemptPaperEventSink.add({
          'type': attemptPaperActions.changeOptionBoolean,
          'payload': index
        });
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

  Widget _buildChooseQuestionModalItem(int index) {
    return ElevatedButton(
      onPressed: () {
        attemptPaperBloc.attemptPaperEventSink.add({
          'type': attemptPaperActions.setCurrentQuestionIndex,
          'payload': index
        });
        Navigator.pop(context);
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
                    attemptPaperBloc.currentBlankPaper.questionModels.length),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainWidget(int currentQuestionIndex, PaperModel paperModel) {
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
                  'Q. ${attemptPaperBloc.currentQuestionIndex + 1}/${attemptPaperBloc.currentBlankPaper.questionModels.length}',
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
                  attemptPaperBloc
                      .currentBlankPaper
                      .questionModels[attemptPaperBloc.currentQuestionIndex]
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
                    paperModel.questionModels[currentQuestionIndex].options),
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
                  onPressed: () {
                    if (currentQuestionIndex > 0) {
                      attemptPaperBloc.attemptPaperEventSink.add({
                        'type': attemptPaperActions.setCurrentQuestionIndex,
                        'payload': currentQuestionIndex - 1
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Text(
                              'Do you really want to leave the test ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardSection()),
                                      (route) => false);
                                },
                                child: const Text('Yes'))
                          ],
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.arrow_left),
                      Text(currentQuestionIndex == 0
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
                  onPressed: () {
                    if (currentQuestionIndex <
                        paperModel.questionModels.length - 1) {
                      attemptPaperBloc.attemptPaperEventSink.add({
                        'type': attemptPaperActions.setCurrentQuestionIndex,
                        'payload': currentQuestionIndex + 1
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Text(
                              'Do you really want to submit the test ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardSection()));
                                },
                                child: const Text('Yes'))
                          ],
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currentQuestionIndex ==
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
        stream: attemptPaperBloc.blankPaperStream,
        initialData: attemptPaperBloc.currentBlankPaper,
        builder: (BuildContext context, AsyncSnapshot blankPaperSnap) {
          return StreamBuilder(
              stream: attemptPaperBloc.currentQuestionIndexStream,
              initialData: attemptPaperBloc.currentQuestionIndex,
              builder: (BuildContext context,
                  AsyncSnapshot currentQuestionIndexSnap) {
                return _buildMainWidget(
                    currentQuestionIndexSnap.data, blankPaperSnap.data);
              });
        },
      ),
    );
  }
}
