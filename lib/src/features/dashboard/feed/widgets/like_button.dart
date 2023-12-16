import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../res/icons.dart';
import '../../../../shared/rend_paint/render_svg.dart';

class VWidgetsAnimatedLikeButton extends StatelessWidget {
  final double buttonSize;
  final Future<bool?> Function(bool) onTap;
  final bool? isLiked;
  const VWidgetsAnimatedLikeButton({
    super.key,
    required this.onTap,
    required this.isLiked,
    this.buttonSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: buttonSize,
      onTap: onTap,
      isLiked: isLiked,
      padding: EdgeInsets.zero,
      circleColor: CircleColor(
        start: Theme.of(context).colorScheme.primary,
        end: Theme.of(context).colorScheme.primary,
      ),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Theme.of(context).colorScheme.primary,
        dotSecondaryColor: Theme.of(context).colorScheme.primary,
      ),
      likeBuilder: (bool isLiked) {
        // return Icon(
        //   Icons.favorite,
        //   color: isLiked ? Colors.red : Colors.grey,
        //   size: buttonSize,
        // );
        return RenderSvg(
          svgPath: isLiked ? VIcons.likedIcon : VIcons.feedLikeIcon,
          // color: Theme.of(context).buttonTheme.colorScheme?.,
          color: isLiked
              ? Color.fromARGB(255, 242, 79, 67)
              : Theme.of(context).iconTheme.color,
          svgHeight: 22,
          svgWidth: 22,
        );
      },
      likeCount: null,
      countBuilder: (count, isLiked, text) {
        var color = isLiked ? Colors.red : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "love",
            style: TextStyle(color: color),
          );
        } else
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        return result;
        // return;
      },
    );
  }
}
