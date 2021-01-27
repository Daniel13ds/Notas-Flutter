import 'dart:convert';

import 'package:flutter/material.dart';

class UserCredentials {
  String email;
  String password;

  UserCredentials({@required this.email, this.password});

  String toJson() {
    final loginData = {"email": email, "password": password};
    return json.encode(loginData);
  }
}
