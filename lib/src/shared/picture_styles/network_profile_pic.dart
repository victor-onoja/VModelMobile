import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

@Deprecated("Use ProfilePicture widget instead")
Widget deprecatedProfilePicture(String url, String errorIconPath,
    {double? width, double? height, bool isContent = false}) {
  return Container(
    height: height ?? 120,
    width: width ?? 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
          width: 2,
          color: isContent ? VmodelColors.white : VmodelColors.primaryColor),
    ),
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
            memCacheHeight: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: url,
            placeholderFadeInDuration: Duration.zero,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            placeholder: (context, url) => RenderSvg(
                  svgPath: errorIconPath,
                  color: isContent
                      ? VmodelColors.white
                      : VmodelColors.primaryColor,
                ),
            errorWidget: (context, url, error) => RenderSvg(
                svgPath: errorIconPath,
                color: isContent
                    ? VmodelColors.white
                    : VmodelColors.primaryColor)),
      ),
    ),
  );
}
