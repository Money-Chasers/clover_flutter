import 'dart:async';
import 'package:rxdart/rxdart.dart';

enum drawerActions {
  changeIndex,
}

class DrawerBloc {
  final BehaviorSubject<int> _currentIndexController =
      BehaviorSubject.seeded(0);
  Stream<int> get currentIndexStream => _currentIndexController.stream;
  int get currentIndex => _currentIndexController.value;

  final _eventStreamController = BehaviorSubject<Map<String, dynamic>>();
  StreamSink<Map<String, dynamic>> get attemptPaperEventSink =>
      _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _submitPaperEventStream =>
      _eventStreamController.stream;

  DrawerBloc() {
    _submitPaperEventStream.listen((event) {
      switch (event['type']) {
        case (drawerActions.changeIndex):
          int _requiredIndex = event['payload'];
          _currentIndexController.add(_requiredIndex);
          break;
      }
    });
  }
}

DrawerBloc drawerBloc = DrawerBloc();
