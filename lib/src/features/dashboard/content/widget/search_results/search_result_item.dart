import 'package:flutter/material.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RenderSvg(
              svgPath: VIcons.searchIcon,
              svgHeight: 24,
              svgWidth: 24,
              color: VmodelColors.white,
            ),
            addHorizontalSpacing(10),
            Text(
              text,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.white),
            )
          ],
        ),
        Divider(
          color: VmodelColors.white.withOpacity(0.15),
          height: 25,
        ),
      ],
    );
  }
}
