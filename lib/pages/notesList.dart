import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/models/notesModel.dart';
import 'package:notas_flutter/models/preferences.dart';
import 'package:notas_flutter/models/settingsModel.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'package:notas_flutter/pages/notesSettings.dart';
import 'package:notas_flutter/widgets/background.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NotesList extends StatelessWidget {
  static final route = '/notesList';
  @override
  Widget build(BuildContext context) {
    final notes =
        ScopedModel.of<NotesModel>(context, rebuildOnChange: true).notes;
    final preferences = Preferences();
    var background = preferences.notesBackground;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Mis Notas'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, NotesSettings.route),
          ),
        ],
      ),
      body: Stack(children: [
        ScopedModelDescendant<SettingsModel>(
          builder: (context, child, model) => Background(
            containNotes: notes.isNotEmpty,
            background: model.background,
          ),
        ),
        _createList(context)
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, NotesForm.route)),
    );
  }

  Widget _createList(BuildContext context) {
    final notes =
        ScopedModel.of<NotesModel>(context, rebuildOnChange: true).notes;
    if (notes.length == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.warning),
            title: Text('No hay Notas Creadas'),
            subtitle: Text('Pulsa el botón + para crear una nota'),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        var note = notes[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: [
              SlideAction(
                child: ClipOval(
                  child: Material(
                    color: Colors.red, // button color
                    child: InkWell(
                      child: SizedBox(
                          width: 65, height: 65, child: Icon(Icons.delete)),
                    ),
                  ),
                ),
                onTap: () => _deleteNote(context, note),
              )
            ],
            child: Card(
              elevation: 10,
              color: note.getMaterialColor(),
              child: ListTile(
                title: Text(note.title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                subtitle:
                    Text(note.content, style: TextStyle(color: Colors.black)),
                onTap: () => Navigator.pushNamed(context, NotesForm.route,
                    arguments: note),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteNote(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Nota'),
        content:
            Text('¿Estas seguro de que quieres borrar la nota ${note.title}?'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ScopedModelDescendant<NotesModel>(
            builder: (context, child, model) => FlatButton(
              onPressed: () {
                model.removeNote(note);
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            ),
          )
        ],
      ),
    );
  }
}
