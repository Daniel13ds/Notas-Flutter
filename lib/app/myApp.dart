import 'package:flutter/material.dart';
import 'package:notas_flutter/models/notesModel.dart';
import 'package:notas_flutter/models/settingsModel.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'package:notas_flutter/pages/notesList.dart';
import 'package:notas_flutter/pages/notesLogin.dart';
import 'package:notas_flutter/pages/notesRegister.dart';
import 'package:notas_flutter/pages/notesSettings.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  NotesModel notesModel;

  @override
  Widget build(BuildContext context) {
    notesModel = NotesModel();
    var initialRoute = NotesLogin.route;
    if (notesModel.tokenIsValid()) initialRoute = NotesList.route;
    return ScopedModel(
      model: notesModel,
      child: ScopedModel(
        model: SettingsModel(),
        child: MaterialApp(
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
            NotesLogin.route: (context) => NotesLogin(),
            NotesRegister.route: (context) => NotesRegister(),
          },
          initialRoute: initialRoute,
        ),
      ),
    );
  }
}
