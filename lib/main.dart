import 'package:flutter/material.dart';
import 'package:notas_flutter/models/preferences.dart';
import 'app/myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = Preferences();
  await preferences.initPreferences();
  runApp(MyApp());
}
