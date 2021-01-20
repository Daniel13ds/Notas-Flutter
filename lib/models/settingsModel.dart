import 'package:notas_flutter/models/preferences.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsModel extends Model {
  Preferences _preferences = Preferences();

  set background(String background) {
    _preferences.notesBackground = background;
    notifyListeners();
  }

  get background {
    return _preferences.notesBackground;
  }
}
