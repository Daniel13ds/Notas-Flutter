import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'package:notas_flutter/pages/notesList.dart';
import 'package:notas_flutter/pages/notesSettings.dart';
import 'package:notas_flutter/widgets/rainbow.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 100),
        children: [
          Rainbow(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Mis Notas"),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context).settings.name == NotesForm.route ||
                  ModalRoute.of(context).settings.name == NotesSettings.route)
                Navigator.pop(context);
            },
          ),
          Rainbow(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Nueva Nota"),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context).settings.name == NotesList.route)
                Navigator.pushNamed(context, NotesForm.route);
              if (ModalRoute.of(context).settings.name == NotesSettings.route)
                Navigator.popAndPushNamed(context, NotesForm.route);
            },
          ),
          Rainbow(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Preferencias"),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context).settings.name == NotesList.route)
                Navigator.pushNamed(context, NotesSettings.route);
              if (ModalRoute.of(context).settings.name == NotesForm.route)
                Navigator.popAndPushNamed(context, NotesSettings.route);
            },
          ),
          Rainbow(),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/daniel.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
