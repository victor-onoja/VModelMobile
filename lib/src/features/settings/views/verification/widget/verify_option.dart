import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class VerifyOption extends StatelessWidget {
  const VerifyOption({Key? key, required this.text, required this.iconPath})
      : super(key: key);

  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RenderSvg(
          svgPath: iconPath,
          svgHeight: 22,
          svgWidth: 22,
        ),
        addHorizontalSpacing(10),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: VmodelColors.primaryColor),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
