import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:notas_flutter/models/userCredentials.dart';
import 'package:http/http.dart' as http;
import 'package:notas_flutter/services/apiService.dart';

class AuthApiService extends ApiService {
  AuthApiService({token}) : super(token);

  Future<String> login(UserCredentials credentials) async {
    final response = await http.post(ApiService.baseUrl + "/login",
        headers: {"Content-type": "application/json"},
        body: credentials.toJson());
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final token = body['accessToken'];
      return token;
    }
  }

  bool tokenIsValid() {
    return !JwtDecoder.isExpired(token);
  }
}
