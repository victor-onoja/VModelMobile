import 'package:flutter/material.dart';

import '../../../../../res/res.dart';

class OpenNowOrClosedText extends StatelessWidget {
  const OpenNowOrClosedText({super.key, required this.isOpen});
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    final fadedTextColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5);

    return RichText(
        text: TextSpan(text: '', children: [
      TextSpan(
        text: '${VMString.bullet} ',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              // fontWeight: FontWeight.w600,
              color: isOpen ? Colors.green : fadedTextColor,
              // fontSize: 12,
            ),
      ),
      TextSpan(
        text: isOpen ? "Open now" : "Closed",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              // fontWeight: FontWeight.w600,
              color: fadedTextColor,
              fontSize: 12,
            ),
      ),
    ]));
  }
}
