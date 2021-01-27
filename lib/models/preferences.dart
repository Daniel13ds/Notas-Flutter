import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = Preferences._internal();
  static final backgroundKey = 'notes_background';
  static final tokenKey = 'notes_token';
  SharedPreferences _preferences;

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set notesBackground(String background) {
    _preferences.setString(backgroundKey, background);
  }

  get notesBackground {
    return _preferences.getString(backgroundKey) ?? 'assets/fondo.jpg';
  }

  set token(String token) {
    _preferences.setString(tokenKey, token);
  }

  get token {
    return _preferences.getString(tokenKey);
  }
}
