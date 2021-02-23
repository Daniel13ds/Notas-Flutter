import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:notas_flutter/models/user.dart';
import 'package:notas_flutter/models/userCredentials.dart';
import 'package:http/http.dart' as http;
import 'package:notas_flutter/reponse/registerResponse.dart';
import 'package:notas_flutter/services/apiService.dart';

class AuthApiService extends ApiService {
  AuthApiService({token}) : super(token);

  Future<String> login(UserCredentials credentials) async {
    final response = await http.post(ApiService.baseUrl + "/login",
        headers: {"Content-type": "application/json"},
        body: credentials.toJson());
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      token = body['accessToken'];
      return token;
    }
  }

  Future<RegisterResponse> register(User user) async {
    try {
      final response = await http.post(ApiService.baseUrl + "/register",
          headers: {"Content-type": "application/json"}, body: user.toJson());
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        token = body['accessToken'];
        return RegisterResponse.success(token, 'Usuario registrado con éxito');
      } else if (response.statusCode == 400) {
        final error = response.body;
        switch (error) {
          case '"Email already exists"':
            return RegisterResponse.userExists('Usuario registrado con éxito');
          case '"Password is too short"':
            return RegisterResponse.passwordShort('Contraseña demasiado corta');
          case '"Email format is invalid"':
            return RegisterResponse.emailInvalid(
                'Correo electrónico no válido');
          case '"Email and password are required"':
            return RegisterResponse.emailAndPasswordRequired(
                'Correo electrónico y contraseña obligatorios');
          default:
            return RegisterResponse.unknownError('Error desconocido');
        }
      }
      return RegisterResponse.unknownError('Error desconocido');
    } catch (e) {
      return RegisterResponse.networkError('Error de conexión');
    }
  }

  bool tokenIsValid() {
    return !JwtDecoder.isExpired(token);
  }

  Future<User> getUser() async {
    final idUser = getUserIdFromToken();
    final response = await http.get(ApiService.baseUrl + '/users/$idUser',
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }
  }
}
