import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:rxdart/rxdart.dart';

class QuestionPaperState {
  final BehaviorSubject<PaperModel> _questionPaper =
      BehaviorSubject.seeded(PaperModel('', [], [0, 0], true));

  Stream get stream$ => _questionPaper.stream;
  PaperModel get current => _questionPaper.value;

  void update(PaperModel newPaperModel) {
    // add new packet to stream
    _questionPaper.add(newPaperModel);
  }

  void reset() {
    _questionPaper.add(PaperModel('', [], [0, 0], true));
  }
}

QuestionPaperState questionPaperService = QuestionPaperState();
