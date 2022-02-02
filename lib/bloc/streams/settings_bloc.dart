import 'dart:async';

import 'package:clover_flutter/repository/shared_preferences_helper.dart';
import 'package:rxdart/rxdart.dart';

// enum settingsActions {}

class SettingsBloc {
  final PublishSubject<Map<String, dynamic>> _settingsStreamController =
      PublishSubject();
  Stream<Map<String, dynamic>> get _settingsStream =>
      _settingsStreamController.stream;

  final BehaviorSubject<String> _localeStreamController =
      BehaviorSubject.seeded('en');
  Stream<String> get localeStream => _localeStreamController.stream;
  String get currentLocale => _localeStreamController.value;

  final BehaviorSubject<bool> _darkModeStreamController =
      BehaviorSubject.seeded(false);
  Stream<bool> get darkModeStream => _darkModeStreamController.stream;
  bool get currentDarkMode => _darkModeStreamController.value;

  final _eventStreamController = BehaviorSubject<Map<String, dynamic>>();
  StreamSink<Map<String, dynamic>> get eventSink => _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _eventStream =>
      _eventStreamController.stream;

  SettingsBloc() {
    _settingsStream.listen((event) {
      String _locale = event['locale']!;
      bool _darkMode = event['darkMode']!;

      _localeStreamController.add(_locale);
      _darkModeStreamController.add(_darkMode);
    });

    _eventStream.listen((event) {
      switch (event['type']) {
      }
    });

    // get settings
    SharedPreferencesHelper.getSettings.then((Map<String, dynamic> value) {
      _settingsStreamController.add(value);
    });
  }
}

SettingsBloc settingsBloc = SettingsBloc();
