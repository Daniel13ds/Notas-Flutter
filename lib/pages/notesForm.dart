import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/models/note.dart';

class NotesForm extends StatelessWidget {
  static final route = '/notesForm';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Note note = Note();

  String _validateTitle(String value) {
    if (value == null || value == '') {
      return 'El título es obligatorio';
    } else if (value.length < 3) {
      return 'El título no puede tener menos de 3 carácteres';
    }
  }

  saveForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      NOTES.add(note);
      note = Note();
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Nota'),
      ),
      bottomNavigationBar: _buttonsForm(context),
      body: _bodyForm(),
    );
  }

  Form _bodyForm() {
    return Form(
      key: _formKey,
      child: Column(children: [
        ListTile(
          leading: Icon(Icons.title),
          title: TextFormField(
            decoration: InputDecoration(hintText: 'Titulo de la nota'),
            validator: _validateTitle,
            onSaved: (newValue) => note.title = newValue,
          ),
        ),
        ListTile(
          leading: Icon(Icons.content_copy),
          title: TextFormField(
            decoration: InputDecoration(hintText: 'Contenido de la nota'),
            maxLines: 6,
            onSaved: (newValue) => note.content = newValue,
          ),
        ),
      ]),
    );
  }

  Padding _buttonsForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancelar')),
          FlatButton(
              onPressed: () {
                saveForm(context);
              },
              child: Text('Guardar')),
        ],
      ),
    );
  }
}
