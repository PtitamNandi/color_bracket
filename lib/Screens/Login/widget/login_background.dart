import 'package:color_bracket/common/widget/custom_circle.dart';
import 'package:flutter/material.dart';

Column LoginBkg() {
  return Column(
    children: [
      CutomCircle(
        x: 180,
        y: -30,
        sColor: Colors.purple.shade900,
        eColor: Colors.pink.shade900,
      ),
      CutomCircle(
        x: -200,
        y: -30,
        sColor: Colors.purple.shade900,
        eColor: Colors.pink.shade900,
      ),
      CutomCircle(
        x: 60,
        y: 60,
        sColor: Colors.purple.shade900,
        eColor: Colors.cyan,
      ),
      CutomCircle(
        x: -200,
        y: 10,
        sColor: Colors.purple.shade900,
        eColor: Colors.cyan,
      ),
      Expanded(
        flex: 1,
        child: CutomCircle(
          x: 10,
          y: -9,
          sColor: Colors.purple.shade900,
          eColor: Colors.pink.shade900,
        ),
      ),
    ],
  );
}
