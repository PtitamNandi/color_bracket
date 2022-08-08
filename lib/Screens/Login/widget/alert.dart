import 'dart:ui';

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          // backgroundColor: Color(ColorResources.BLACK_ALPHA_65),
          child: _dialogContent(),
        ));
  }
}

// mixin ColorResources {}

Widget _dialogContent() {
  return Container(
    height: 100,
    width: 200,
    color: Colors.white,
    child: CircularProgressIndicator(),
  );
}
