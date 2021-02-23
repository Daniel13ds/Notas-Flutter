import 'package:flutter/material.dart';
import 'package:notas_flutter/models/notesModel.dart';
import 'package:notas_flutter/models/user.dart';
import 'package:notas_flutter/pages/notesList.dart';
import 'package:notas_flutter/pages/notesLogin.dart';
import 'package:notas_flutter/reponse/registerResponse.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

import 'notesSettings.dart';

class NotesRegister extends StatefulWidget {
  static final route = '/notesRegister';
  NotesRegister({Key key}) : super(key: key);

  @override
  _NotesLoginState createState() => _NotesLoginState();
}

class _NotesLoginState extends State<NotesRegister> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  User _user = User();
  String errorMessage;
  RegisterResponse registerResponse =
      RegisterResponse.unknownError("Error Desconocido");

  _register() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      registerResponse =
          await ScopedModel.of<NotesModel>(context, rebuildOnChange: true)
              .register(_user);
      if (registerResponse.status == RegisterResponseStatus.Success) {
        Navigator.pushNamedAndRemoveUntil(
            context, NotesList.route, (route) => false);
      } else {
        setState(() {
          errorMessage = registerResponse.errorMessage;
        });
      }
    }
  }

  String _nameValidator(String value) {
    if (value == null || value.length == 0) {
      return "Nombre y apellidos obligatorios";
    }
  }

  String _emailValidator(String value) {
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) return 'No es un email válido';
  }

  String _passwordValidator(String value) {
    if (value.length < 3)
      return 'La contraseña no puede contener menos de 3 caracteres';
  }

  _onChangeField(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, NotesSettings.route),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.app_registration,
                      size: 100,
                      color: Colors.grey[850],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(70)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Nombre'),
                  validator: _nameValidator,
                  onSaved: (newValue) => _user.firstname = newValue,
                  onChanged: _onChangeField,
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Apellidos'),
                  validator: _nameValidator,
                  onSaved: (newValue) => _user.lastname = newValue,
                  onChanged: _onChangeField,
                ),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Correo electrónico'),
                  validator: _emailValidator,
                  onSaved: (newValue) => _user.email = newValue,
                  onChanged: _onChangeField,
                ),
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: TextFormField(
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                      hintText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      )),
                  validator: _passwordValidator,
                  onSaved: (newValue) => _user.password = newValue,
                  onChanged: _onChangeField,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                        child: Text('Crear Cuenta'),
                        onPressed: () {
                          _register();
                        }),
                    RaisedButton(
                      child: Text('Iniciar Sesión'),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, NotesLogin.route, (route) => false),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
