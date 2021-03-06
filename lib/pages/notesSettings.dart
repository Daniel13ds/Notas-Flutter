import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas_flutter/models/preferences.dart';
import 'package:notas_flutter/models/settingsModel.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NotesSettings extends StatefulWidget {
  static final route = '/notesSettings';

  @override
  _NotesSettingsState createState() => _NotesSettingsState();
}

class _NotesSettingsState extends State<NotesSettings> {
  String _background;
  final _preferences = Preferences();

  void initState() {
    super.initState();
    _background = _preferences.notesBackground;
  }

  _onChanged(String value) {
    setState(() {
      _background = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Preferencias'),
      ),
      body: Column(
        children: [
          Text(
            'Selecciona un Fondo',
            style: TextStyle(fontSize: 25),
          ),
          RadioListTile(
            title: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo.jpg'),
                      fit: BoxFit.fitHeight)),
            ),
            value: 'assets/fondo.jpg',
            groupValue: _background,
            onChanged: _onChanged,
          ),
          RadioListTile(
            title: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/fondo3.jpg'),
                      fit: BoxFit.fitHeight)),
            ),
            value: 'assets/fondo3.jpg',
            groupValue: _background,
            onChanged: _onChanged,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
            ScopedModelDescendant<SettingsModel>(
              builder: (context, child, model) => FlatButton(
                  onPressed: () {
                    model.background = _background;
                    Navigator.pop(context);
                  },
                  child: Text('Guardar')),
            ),
          ],
        ),
      ),
    );
  }
}
