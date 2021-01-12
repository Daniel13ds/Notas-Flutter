import 'package:flutter/material.dart';
import 'pages/notesForm.dart';

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
      home: NotesForm(),
    );
  }
}
