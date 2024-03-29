import 'dart:async';

import 'package:clover_flutter/bloc/models/user_model.dart';
import 'package:clover_flutter/repository/authentication_helper.dart';
import 'package:clover_flutter/repository/backend_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum userActions {
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  signOut,
}

class UserBloc {
  final PublishSubject<UserModel> _currentUserStreamController =
      PublishSubject();
  Stream<UserModel> get _currentUserStream =>
      _currentUserStreamController.stream;

  final BehaviorSubject<bool> _isSignedInStreamController =
      BehaviorSubject.seeded(false);
  Stream<bool> get isSignedInStream => _isSignedInStreamController.stream;

  final BehaviorSubject<List<Object>> _bookmarksStreamController = BehaviorSubject.seeded([]);
  Stream<List<Object>> get bookmarksStream => _bookmarksStreamController.stream;

  final PublishSubject<Map<String, dynamic>> _eventStreamController =
      PublishSubject();
  StreamSink<Map<String, dynamic>> get eventSink => _eventStreamController.sink;
  Stream<Map<String, dynamic>> get _eventStream =>
      _eventStreamController.stream;

  UserBloc() {
    _currentUserStream.listen((UserModel userModel) {
      // handle signed in state
      _isSignedInStreamController.add(userModel.isSignedIn);

      // handle bookmarks state
      
    });

    _eventStream.listen((event) {
      switch (event['type']) {
        case (userActions.signInWithEmailAndPassword):
          try {
            AuthenticationHelper.signInWithEmailAndPassword(
                    event['payload']['email'], event['payload']['password'])
                .then((UserCredential value) {
              _currentUserStreamController
                  .add(AuthenticationHelper.currentUser);
            });
          } on FirebaseAuthException catch (exception) {
            switch (exception.code) {
              // will handle this later using error codes
            }
          }
          break;
        case (userActions.createUserWithEmailAndPassword):
          try {
            BackendHelper.createUserWithEmailAndPassword(
                    event['payload']['name'],
                    event['payload']['email'],
                    event['payload']['password'])
                .then((_) {
              _currentUserStreamController
                  .add(AuthenticationHelper.currentUser);
            });
          } on FirebaseAuthException catch (exception) {
            switch (exception.code) {
              // will handle this later using error codes
            }
          }
          break;
        case (userActions.signOut):
          try {
            AuthenticationHelper.signOut().then((_) {
              _currentUserStreamController
                  .add(AuthenticationHelper.currentUser);
            });
          } on FirebaseAuthException catch (exception) {
            switch (exception.code) {
              // will handle this later using error codes
            }
          }
          break;
      }
    });

    // get user
    UserModel _currentUserModel = AuthenticationHelper.currentUser;
    _isSignedInStreamController.add(_currentUserModel.isSignedIn);
  }
}

UserBloc userBloc = UserBloc();
