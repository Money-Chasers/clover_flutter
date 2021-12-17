class UserModel {
  String name;
  String email;
  String password;
  String education;

  UserModel({required this.name, required this.email, required this.password, required this.education});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['education'] = education;
    return data;
  }
}
