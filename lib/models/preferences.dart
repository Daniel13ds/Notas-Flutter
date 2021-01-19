import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = Preferences._internal();
  static final backgroundKey = 'notes_background';
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
}
