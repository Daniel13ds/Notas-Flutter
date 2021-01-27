import 'dart:convert';

import 'package:notas_flutter/models/userCredentials.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  static final baseUrl = 'http://192.168.1.41:3000';

  Future<String> login(UserCredentials credentials) async {
    final response = await http.post(baseUrl + "/login",
        headers: {"Content-type": "application/json"},
        body: credentials.toJson());
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final token = body['accessToken'];
      return token;
    }
  }
}
