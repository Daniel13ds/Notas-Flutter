import 'dart:convert';

import 'package:notas_flutter/models/userCredentials.dart';

class User extends UserCredentials {
  int id;
  String firstname;
  String lastname;

  User({this.id, email, password, this.firstname, this.lastname})
      : super(email: email, password: password);

  get fullName {
    return '$firstname $lastname';
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
