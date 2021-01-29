import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/models/notesModel.dart';
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
          rebuildOnChange: true,
          builder: (context, child, model) => Background(
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
    return ScopedModelDescendant<NotesModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => FutureBuilder<List<Note>>(
              future: model.notes,
              builder: (context, snapshot) {
                var childWidgets;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    childWidgets = ListView(
                      children: [Center(child: CircularProgressIndicator())],
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      childWidgets = ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Card(
                              child: ListTile(
                                leading: Icon(Icons.wifi_off_rounded),
                                title: Text('Error de conexión'),
                                subtitle: Text(
                                    'No se ha podido establecer la conexión con el servidor'),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      if (snapshot.data == null || snapshot.data.length == 0) {
                        childWidgets = _buildEmptyList();
                      } else {
                        childWidgets = _buildNotesList(snapshot.data);
                      }
                    }
                    break;
                  default:
                    childWidgets = ListView(
                      children: [
                        Center(
                          child: Text('Text'),
                        )
                      ],
                    );
                    break;
                }
                return RefreshIndicator(
                  onRefresh: model.refresh,
                  child: childWidgets,
                );
              },
            ));
  }

  Widget _buildEmptyList() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.warning),
              title: Text('No hay Notas Creadas'),
              subtitle: Text('Pulsa el botón + para crear una nota'),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNotesList(List<Note> notes) {
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
                onTap: () async {
                  var updated = await Navigator.pushNamed(
                      context, NotesForm.route,
                      arguments: note);
                  if (!updated) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('No se ha podido actualizar la nota'),
                        duration: Duration(seconds: 5)));
                  }
                },
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
            rebuildOnChange: true,
            builder: (context, child, model) => FlatButton(
              onPressed: () async {
                Navigator.pop(context);
                var deleted = await model.removeNote(note);
                if (!deleted) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('No se ha podido eliminar la nota'),
                    duration: Duration(seconds: 5),
                  ));
                }
              },
              child: Text('Aceptar'),
            ),
          )
        ],
      ),
    );
  }
}
