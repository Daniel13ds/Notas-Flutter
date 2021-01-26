import 'dart:convert';

class User {
  int id;
  String email;
  String password;
  String firstname;
  String lastname;

  User({this.id, this.email, this.password, this.firstname, this.lastname});

  get fullName {
    return '$firstname $lastname';
  }

  String loginToJson() {
    final loginData = {"email": email, "password": password};
    return json.encode(loginData);
  }

  static User fromJson(String userJson) {
    final userMap = jsonDecode(userJson);
    return User(
        id: userMap['id'],
        email: userMap['email'],
        firstname: userMap['firstname'],
        lastname: userMap['lastname']);
  }
}
