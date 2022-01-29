import 'dart:async';

import 'package:clover_flutter/data_models/paper_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

enum submitPaperActions {
  resetPaper,
  addQuestion,
  removeQuestion,
  editQuestion,
  updateTitle,
  updateDuration,
  updateIsPublic,
}

class SubmitPaperBloc {
  final BehaviorSubject<PaperModel> _stateStreamController =
      BehaviorSubject.seeded(
          PaperModel(const Uuid().v1(), '', [], [0, 0], true));
  Stream<PaperModel> get submitPaperStream => _stateStreamController.stream;
  PaperModel get current => _stateStreamController.value;

  final _eventStreamController = StreamController<Map<String, dynamic>>();
  StreamSink<Map<String, dynamic>> get submitPaperEventSink =>
      _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _submitPaperEventStream =>
      _eventStreamController.stream;

  SubmitPaperBloc() {
    _submitPaperEventStream.listen((event) {
      switch (event['type']) {
        case (submitPaperActions.resetPaper):
          _stateStreamController
              .add(PaperModel(const Uuid().v1(), '', [], [0, 0], true));
          break;
        case (submitPaperActions.addQuestion):
          QuestionModel _newQuestionModel = event['payload'];
          PaperModel _tempPaperModel = current;
          _tempPaperModel.questionModels.add(_newQuestionModel);
          _stateStreamController.add(_tempPaperModel);
          break;
        case (submitPaperActions.removeQuestion):
          int _requiredIndex = event['payload'];
          PaperModel _tempPaperModel = current;
          _tempPaperModel.questionModels.removeAt(_requiredIndex);
          _stateStreamController.add(_tempPaperModel);
          break;
        case (submitPaperActions.editQuestion):
          int _requiredIndex = event['payload']['index'];
          QuestionModel _newQuestionModel = event['payload']['questionModel'];
          PaperModel _tempPaperModel = current;
          _tempPaperModel.questionModels[_requiredIndex] = _newQuestionModel;
          _stateStreamController.add(_tempPaperModel);
          break;
        case (submitPaperActions.updateTitle):
          String _requiredTitle = event['payload'];
          PaperModel _tempPaperModel = current;
          _tempPaperModel.paperTitle = _requiredTitle;
          _stateStreamController.add(_tempPaperModel);
          break;
        case (submitPaperActions.updateDuration):
          List<int> _requiredDuration = event['payload'];
          PaperModel _tempPaperModel = current;
          _tempPaperModel.duration = _requiredDuration;
          _stateStreamController.add(_tempPaperModel);
          break;
        case (submitPaperActions.updateIsPublic):
          bool _requiredIsPublic = event['payload'];
          PaperModel _tempPaperModel = current;
          _tempPaperModel.isPublic = _requiredIsPublic;
          _stateStreamController.add(_tempPaperModel);
          break;
      }
    });
  }
}

SubmitPaperBloc submitPaperBloc =
    SubmitPaperBloc(); // exposing a single object so that no two references will be made, can also use static fields in class but it will be clumsy.
