class UserModel {
  String userId;
  UserDetails userDetails;
  bool isSignedIn;

  UserModel(
      {required this.userId,
      required this.userDetails,
      required this.isSignedIn});

  Map<String, dynamic> toDatabaseJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userDetails'] = userDetails.toDatabaseJSON();
    return data;
  }
}

class UserDetails {
  String name;
  String email;

  UserDetails({required this.name, required this.email});

  Map<String, String> toDatabaseJSON() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
