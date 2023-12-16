import 'package:cached_network_image/cached_network_image.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../res/res.dart';

class RoundedSquareAvatar extends StatelessWidget {
  final String? url;
  final String? thumbnail;
  final Size? size;
  final double radius;
  final Color? backgroundColor;
  final Widget? imageWidget;
  final Widget? errorWidget;

  const RoundedSquareAvatar({
    super.key,
    required this.url,
    required this.thumbnail,
    this.size,
    this.radius = 8,
    this.backgroundColor,
    this.imageWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width ?? 50,
      height: size?.height ?? 50,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: imageWidget ??
            CachedNetworkImage(
              imageUrl: '$url',
              fit: BoxFit.cover,
              placeholderFadeInDuration: Duration.zero,
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              placeholder: (context, url) {
                // return const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile);
                return CachedNetworkImage(
                  imageUrl: '$thumbnail',
                  fit: BoxFit.cover,
                  placeholderFadeInDuration: Duration.zero,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  placeholder: (context, url) => ColoredBox(
                    color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                  ),
                  // const RenderSvgWithoutColor(
                  //     svgPath: VIcons.vModelProfile),
                  errorWidget: (context, url, error) => ColoredBox(
                    color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                  ),
                  // const RenderSvgWithoutColor(
                  //     svgPath: VIcons.vModelProfile),
                );
              },
              errorWidget: (context, url, error) =>
                  // const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
                  errorWidget ?? SizedBox.shrink(),
            ),
      ),
    );
  }
}
