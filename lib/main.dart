import 'package:flutter/material.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'pages/notesList.dart';

void main() {
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
      },
      initialRoute: NotesList.route,
    );
  }
}
