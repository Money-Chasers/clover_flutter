import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:rxdart/rxdart.dart';

class QuestionPaperAttemptState {
  final BehaviorSubject<PaperModel> _questionPaper =
      BehaviorSubject.seeded(PaperModel('', '', [], [0, 0], true));

  Stream get stream$ => _questionPaper.stream;
  PaperModel get current => _questionPaper.value;

  void update(PaperModel newPaperModel) {
    // add new packet to stream
    _questionPaper.add(newPaperModel);
  }
}

QuestionPaperAttemptState questionPaperAttemptService =
    QuestionPaperAttemptState();
