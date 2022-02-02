import 'package:clover_flutter/bloc/models/user_model.dart';
import 'package:clover_flutter/repository/authentication_helper.dart';
import 'package:clover_flutter/repository/database_helper.dart';
import 'package:uuid/uuid.dart';

class BackendHelper {
  static Future createUserWithEmailAndPassword(
      String name, String email, String password) {
    Future _future1 =
        AuthenticationHelper.createUserWithEmailAndPassword(email, password);
    Future _future2 = DatabaseHelper.addUserInDatabase(UserModel(
        userId: const Uuid().v1(),
        userDetails: UserDetails(name: name, email: email),
        isSignedIn: false));

    return Future.wait([_future1, _future2]);
  }
}
