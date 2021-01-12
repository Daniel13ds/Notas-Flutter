import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/pages/notesForm.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Notas'),
      ),
      body: _createList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesForm(),
              ));
        },
      ),
    );
  }

  ListView _createList() {
    return ListView.builder(
      itemCount: NOTES.length,
      itemBuilder: (context, index) {
        var note = NOTES[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: Card(
            elevation: 10,
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
            ),
            color: note.getMaterialColor(),
          ),
        );
      },
    );
  }
}
