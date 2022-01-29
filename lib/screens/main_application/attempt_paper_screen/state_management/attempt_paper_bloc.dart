import 'dart:async';

import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:rxdart/rxdart.dart';

enum attemptPaperActions {
  assignFullPaperModel,
  setCurrentQuestionIndex,
  changeOptionBoolean
}

class AttemptPaperBloc {
  final BehaviorSubject<int> _currentQuestionIndexController =
      BehaviorSubject.seeded(0);
  Stream<int> get currentQuestionIndexStream =>
      _currentQuestionIndexController.stream;
  int get currentQuestionIndex => _currentQuestionIndexController.value;

  final BehaviorSubject<PaperModel> _fullPaperStreamController =
      BehaviorSubject();
  Stream<PaperModel> get _fullPaperStream => _fullPaperStreamController.stream;

  final BehaviorSubject<PaperModel> _blankPaperStateStreamController =
      BehaviorSubject.seeded(PaperModel('', '', [], [], true));
  Stream<PaperModel> get blankPaperStream =>
      _blankPaperStateStreamController.stream;
  PaperModel get currentBlankPaper => _blankPaperStateStreamController.value;

  final _eventStreamController = BehaviorSubject<Map<String, dynamic>>();
  StreamSink<Map<String, dynamic>> get attemptPaperEventSink =>
      _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _submitPaperEventStream =>
      _eventStreamController.stream;

  PaperModel _eraseOptions(PaperModel requiredPaperModel) {
    PaperModel _tempPaperModel = requiredPaperModel;
    List<QuestionModel> _tempQuestionModels =
        requiredPaperModel.questionModels.map((e) {
      QuestionModel _tempQuestionModel = e;
      List<OptionModel> _tempOptionModels = e.options.map((e) {
        OptionModel _tempOptionModel = e;
        _tempOptionModel.isCorrect = false;
        return _tempOptionModel;
      }).toList(growable: false);
      _tempQuestionModel.options = _tempOptionModels;
      return _tempQuestionModel;
    }).toList(growable: false);
    _tempPaperModel.questionModels = _tempQuestionModels;

    return _tempPaperModel;
  }

  AttemptPaperBloc() {
    _fullPaperStream.listen((value) {
      // when the full paper model is assigned, we have to convert it to a blank PaperModel without answers and pass it down the stream.
      PaperModel _tempPaperModel = _eraseOptions(value);
      _blankPaperStateStreamController.add(_tempPaperModel);
    });

    _submitPaperEventStream.listen((event) {
      switch (event['type']) {
        case (attemptPaperActions.assignFullPaperModel):
          PaperModel _requiredPaperModel = event['payload'];
          _fullPaperStreamController.add(_requiredPaperModel);
          break;
        case (attemptPaperActions.setCurrentQuestionIndex):
          int _requiredIndex = event['payload'];
          _currentQuestionIndexController.add(_requiredIndex);
          break;
        case (attemptPaperActions.changeOptionBoolean):
          int _requiredOptionIndex = event['payload'];
          PaperModel _tempPaperModel = currentBlankPaper;
          _tempPaperModel.questionModels[currentQuestionIndex]
                  .options[_requiredOptionIndex].isCorrect =
              !_tempPaperModel.questionModels[currentQuestionIndex]
                  .options[_requiredOptionIndex].isCorrect;
          _blankPaperStateStreamController.add(_tempPaperModel);
          break;
      }
    });
  }
}

AttemptPaperBloc attemptPaperBloc = AttemptPaperBloc();
