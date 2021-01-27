import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/models/notesModel.dart';
import 'package:notas_flutter/widgets/colorPicker.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NotesForm extends StatelessWidget {
  static final route = '/notesForm';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Note note = Note();
  Note updateNote;
  bool isEditing = false;

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
      var updated;
      if (isEditing) {
        updateNote.copyFrom(note);
        ScopedModel.of<NotesModel>(context, rebuildOnChange: true)
            .updateNote(note);
      } else {
        ScopedModel.of<NotesModel>(context, rebuildOnChange: true)
            .addNote(note);
      }
      note = Note();
      Navigator.pop(context, updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      updateNote = arguments;
      note.id = updateNote.id;
      isEditing = true;
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Nueva Nota'),
      ),
      bottomNavigationBar: _buttonsForm(context),
      body: _bodyForm(context),
    );
  }

  Form _bodyForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        ListTile(
          leading: Icon(Icons.title),
          title: TextFormField(
            initialValue: isEditing ? updateNote.title : note.title,
            decoration: InputDecoration(hintText: 'Titulo de la nota'),
            validator: _validateTitle,
            onSaved: (newValue) => note.title = newValue,
          ),
        ),
        ListTile(
          leading: Icon(Icons.content_copy),
          title: TextFormField(
            initialValue: isEditing ? updateNote.content : note.content,
            decoration: InputDecoration(hintText: 'Contenido de la nota'),
            maxLines: 6,
            onSaved: (newValue) => note.content = newValue,
          ),
        ),
        ListTile(
          leading: Icon(Icons.palette),
          title: ColorPicker(
            initialValue: isEditing ? updateNote.color : note.color,
            onChanged: (color) {
              note.color = color;
              FocusScope.of(context).unfocus();
            },
          ),
        )
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
                Navigator.pop(context);
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
