import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VText extends StatelessWidget {
  final String text;
  final double fontSize;
  // final Color color;
  const VText({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          wordSpacing: 5,
          color: VmodelColors.white,
          fontSize: fontSize,
          fontFamily: "AvenirNext",
        ));
  }
}
