import 'package:clover_flutter/components/drawer.dart';
import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:clover_flutter/screens/main_application/attempt_paper_screen/state_management/question_paper_state.dart';
import 'package:flutter/material.dart';

class PaperAnalysisScreen extends StatelessWidget {
  final PaperModel correctPaperModel;

  const PaperAnalysisScreen({Key? key, required this.correctPaperModel})
      : super(key: key);

  Widget _buildMainWidget(PaperModel submittedPaperModel) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paper analysis'),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        // here is the stream for submitted paper.
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
