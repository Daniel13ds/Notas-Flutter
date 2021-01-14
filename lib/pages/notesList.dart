import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/pages/notesForm.dart';

class NotesList extends StatefulWidget {
  static final route = '/notesList';

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Notas'),
      ),
      body: _createList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newNote = await Navigator.pushNamed(context, NotesForm.route);
          if (newNote) setState(() {});
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
              title: Text(note.title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              subtitle:
                  Text(note.content, style: TextStyle(color: Colors.black)),
            ),
            color: note.getMaterialColor(),
          ),
        );
      },
    );
  }
}
