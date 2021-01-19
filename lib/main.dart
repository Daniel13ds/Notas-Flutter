import 'package:flutter/material.dart';
import 'package:notas_flutter/models/preferences.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'package:notas_flutter/pages/notesSettings.dart';
import 'pages/notesList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = Preferences();
  await preferences.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Notas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.orange,
          buttonColor: Colors.green),
      routes: {
        NotesList.route: (context) => NotesList(),
        NotesForm.route: (context) => NotesForm(),
        NotesSettings.route: (context) => NotesSettings(),
      },
      initialRoute: NotesList.route,
    );
  }
}
