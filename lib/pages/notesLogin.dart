import 'package:flutter/material.dart';
import 'package:notas_flutter/models/user.dart';
import 'package:notas_flutter/widgets/myDrawer.dart';

class NotesLogin extends StatefulWidget {
  static final route = '/notesLogin';
  NotesLogin({Key key}) : super(key: key);

  @override
  _NotesLoginState createState() => _NotesLoginState();
}

class _NotesLoginState extends State<NotesLogin> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  User _user = User();

  _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                        child: Text('Iniciar Sesión'),
                        onPressed: () {
                          _login();
                        }),
                    RaisedButton(child: Text('Registrar'), onPressed: () {}),
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
