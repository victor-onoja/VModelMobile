import 'package:cached_network_image/cached_network_image.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsUserTag extends StatelessWidget {
  final String? profilePictureUrl;
  final VoidCallback onTapProfile;
  const VWidgetsUserTag({
    super.key,
    required this.profilePictureUrl,
    required this.onTapProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapProfile,
      child: Container(
        height: 42.sp,
        width: 42.sp,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              memCacheHeight: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: "$profilePictureUrl",
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
      ),
    );
  }
}
