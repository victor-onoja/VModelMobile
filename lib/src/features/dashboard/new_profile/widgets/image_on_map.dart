import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';

import '../../../../shared/rend_paint/render_svg.dart';

class ImageOnMap extends StatelessWidget {
  const ImageOnMap({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipOval(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: VmodelColors.white, width: 6),
            ),
            child: CachedNetworkImage(
              memCacheHeight: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: "$imagePath",
              placeholderFadeInDuration: Duration.zero,
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              placeholder: (context, url) =>
                  const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
              errorWidget: (context, url, error) =>
                  const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
            ),
          ),
        ),
      ],
    );
  }
}
