import 'package:flutter/material.dart';

class CutomCircle extends StatelessWidget {
  final double x;
  final double y;
  final Color sColor;
  final Color eColor;
  CutomCircle(
      {Key? key,
      required this.x,
      required this.y,
      required this.sColor,
      required this.eColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [sColor, eColor],
          ),
        ),
      ),
    );
  }
}
