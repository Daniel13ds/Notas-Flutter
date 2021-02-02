import 'package:flutter/material.dart';
import 'package:notas_flutter/models/user.dart';
import 'package:notas_flutter/pages/notesLogin.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';

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

  register() async {}

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
                    child: Icon(Icons.person, size: 100),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(70)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Correo alectrónico'),
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
                    RaisedButton(child: Text('Crear Cuenta'), onPressed: () {}),
                    RaisedButton(
                      child: Text('Iniciar Sesión'),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, NotesLogin.route),
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
