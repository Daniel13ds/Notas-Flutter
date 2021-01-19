import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
  bool containNotes = true;
  String background;
  Background({this.containNotes, this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage(containNotes ? background : 'assets/fondo2.jpg'),
              fit: BoxFit.fill)),
    );
  }
}
