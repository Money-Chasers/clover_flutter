class UserModel {
  String name;
  String email;
  num education;

  UserModel({required this.name, required this.email, required this.education});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['education'] = education;
    return data;
  }
}
