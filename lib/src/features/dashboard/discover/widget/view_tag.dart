import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class ViewTag extends StatelessWidget {
  final String text;
  const ViewTag({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: VmodelColors.borderColor,
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: VmodelColors.mainColor),
      ),
    );
  }
}
