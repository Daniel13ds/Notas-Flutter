import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/models/preferences.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'package:notas_flutter/pages/notesSettings.dart';
import 'package:notas_flutter/widgets/background.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';

class NotesList extends StatefulWidget {
  static final route = '/notesList';

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    var background = preferences.notesBackground;

    return Scaffold(
      drawer: MyDrawer(onPop: () {
        setState(() {});
      }),
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
        Background(
          containNotes: NOTES.isNotEmpty,
          background: background,
        ),
        _createList()
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newNote = await Navigator.pushNamed(context, NotesForm.route);
          if (newNote) setState(() {});
        },
      ),
    );
  }

  Widget _createList() {
    if (NOTES.length == 0) {
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
      itemCount: NOTES.length,
      itemBuilder: (context, index) {
        var note = NOTES[index];
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
              child: ListTile(
                title: Text(note.title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                subtitle:
                    Text(note.content, style: TextStyle(color: Colors.black)),
                onTap: () async {
                  var changed = await Navigator.pushNamed(
                      context, NotesForm.route,
                      arguments: note);
                  if (changed) setState(() {});
                },
              ),
              color: note.getMaterialColor(),
            ),
          ),
        );
      },
    );
  }

  void _deleteNote(BuildContext context, Note note) async {
    var isDeleted = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Nota'),
        content:
            Text('¿Estas seguro de que quieres borrar la nota ${note.title}?'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          FlatButton(
            onPressed: () {
              NOTES.remove(note);
              Navigator.pop(context, true);
            },
            child: Text('Aceptar'),
          )
        ],
      ),
    );
    if (isDeleted) setState(() {});
  }
}
