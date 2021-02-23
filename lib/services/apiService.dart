import 'package:jwt_decoder/jwt_decoder.dart';

abstract class ApiService {
  //static final baseUrl = 'http://192.168.1.41:3000'; //Casa
  //static final baseUrl = 'http://192.168.18.96:3000'; //Clase
  static final baseUrl = 'http://192.168.0.21:3000'; //David

  String token;

  ApiService(this.token);

  int getUserIdFromToken() {
    final mapJwt = JwtDecoder.decode(token);
    return int.parse(mapJwt['sub']);
  }
}
