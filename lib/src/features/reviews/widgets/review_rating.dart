import 'package:flutter/material.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class ReviewRatings extends StatelessWidget {
  const ReviewRatings({Key? key, required this.rating, required this.title})
      : super(key: key);

  final String rating;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rating,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: VmodelColors.primaryColor),
            ),
            addHorizontalSpacing(3),
            const RenderSvg(
              svgPath: VIcons.star,
              svgHeight: 14,
              svgWidth: 14,
              color: VmodelColors.primaryColor,
            ),
          ],
        ),
        addVerticalSpacing(4),
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w500, color: VmodelColors.primaryColor),
        ),
      ],
    );
  }
}
