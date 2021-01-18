import 'package:flutter/widgets.dart';

class Rainbow extends StatelessWidget {
  const Rainbow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF0064),
              Color(0xFFFF7600),
              Color(0xFFFFD500),
              Color(0xFF8CFE00),
              Color(0xFF00E86C),
              Color(0xFF00F4F2),
              Color(0xFF00CCFF),
              Color(0xFF70A2FF),
              Color(0xFFA96CFF),
            ]),
      ),
    );
  }
}
