import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
  bool containNotes = true;
  Background({this.containNotes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  containNotes ? 'assets/fondo.jpg' : 'assets/fondo2.jpg'),
              fit: BoxFit.fill)),
    );
  }
}
