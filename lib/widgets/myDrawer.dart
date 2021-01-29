import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/models/notesModel.dart';
import 'package:notas_flutter/pages/notesForm.dart';
import 'package:notas_flutter/pages/notesList.dart';
import 'package:notas_flutter/pages/notesLogin.dart';
import 'package:notas_flutter/pages/notesSettings.dart';
import 'package:notas_flutter/widgets/rainbow.dart';
import 'package:scoped_model/scoped_model.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NotesModel>(
      builder: (context, child, model) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.only(top: 100),
            children: [
              _buildDrawerHeader(model),
              if (!model.logged) Rainbow(),
              if (!model.logged)
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Iniciar Sesión"),
                  onTap: () {
                    Navigator.pop(context);
                    if (ModalRoute.of(context).settings.name !=
                        NotesLogin.route)
                      Navigator.pushNamedAndRemoveUntil(
                          context, NotesLogin.route, (route) => false);
                  },
                ),
              if (model.logged) Rainbow(),
              if (model.logged)
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text("Mis Notas"),
                  onTap: () {
                    Navigator.pop(context);
                    if (ModalRoute.of(context).settings.name != NotesList.route)
                      Navigator.pushNamedAndRemoveUntil(
                          context, NotesList.route, (route) => false);
                  },
                ),
              if (model.logged) Rainbow(),
              if (model.logged)
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Nueva Nota"),
                  onTap: () {
                    Navigator.pop(context);
                    if (ModalRoute.of(context).settings.name != NotesForm.route)
                      Navigator.pushNamed(context, NotesForm.route);
                  },
                ),
              Rainbow(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Preferencias"),
                onTap: () {
                  Navigator.pop(context);
                  if (ModalRoute.of(context).settings.name !=
                      NotesSettings.route)
                    Navigator.pushNamed(context, NotesSettings.route);
                },
              ),
              if (model.logged) Rainbow(),
              if (model.logged)
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Cerrar Sesión"),
                  onTap: () async {
                    Navigator.pop(context);
                    model.logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, NotesLogin.route, (route) => false);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerHeader(NotesModel model) {
    if (model.logged) {
      return UserAccountsDrawerHeader(
        accountName: Text(model.user.fullName),
        accountEmail: Text(model.user.email),
        currentAccountPicture: CircleAvatar(
          backgroundImage: AssetImage('assets/daniel.png'),
        ),
      );
    } else {
      return DrawerHeader(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/daniel.png'),
          ),
        ),
        child: Center(
          child: Text(
            'Mis Notas',
            style: TextStyle(fontSize: 25),
          ),
        ),
      );
    }
  }
}
