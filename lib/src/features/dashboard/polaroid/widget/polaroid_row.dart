import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';


class PolaroidRow extends StatelessWidget {
  final Function()? onPressed;
  final bool isSelected;
  final String text;
  const PolaroidRow({
    Key? key,
    this.onPressed,
    required this.isSelected,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? VmodelColors.mainColor : VmodelColors.ligtenedText,
          fontSize: 13,
          //  fontWeight: FontWeight.bold,
          fontFamily: "AvenirNext,Medium",
        ),
      ),
    );
  }
}
