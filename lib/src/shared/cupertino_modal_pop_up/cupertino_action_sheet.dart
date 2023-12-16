import 'package:flutter/cupertino.dart';

import '../../res/typography/textstyle.dart';

class VCupertinoActionSheet extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? style;

  const VCupertinoActionSheet({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: CupertinoActionSheetAction(
          onPressed: onPressed ??
              () {
                Navigator.pop(context);
              },
          child: Text(text, style: style ?? VmodelTypography2.kTitleStyle)),
    );
  }
}
