import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
  String background;
  Background({this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(background), fit: BoxFit.fill)),
    );
  }
}
