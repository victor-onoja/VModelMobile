import 'package:cached_network_image/cached_network_image.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class TextOverlayedImage extends StatelessWidget {
  const TextOverlayedImage({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    required this.onLongPress,
    required this.title,
    this.size,
    this.gradientStops,
    this.gradientColors,
    this.titleStyle,
    this.titleTextAlign,
    this.subTitle,
    this.imageProvider,
    this.isViewAll = false,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final String imageUrl;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final TextAlign? titleTextAlign;
  final bool isViewAll;
  final ImageProvider? imageProvider;
  final VoidCallback? onLongPress;
  final List<double>? gradientStops;
  final List<Color>? gradientColors;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: size?.height ?? 180,
      width: size?.width ?? SizerUtil.width * 0.42,
      // margin: EdgeInsets.symmetric(horizontal: isViewAll ? 0 : 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: VmodelColors.jobDetailGrey.withOpacity(0.3),
        image: imageProvider != null
            ? DecorationImage(image: imageProvider!, fit: BoxFit.cover)
            : DecorationImage(
                image: CachedNetworkImageProvider('${imageUrl}'),
                fit: BoxFit.cover),
      ),
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        onLongPress: () {
          onLongPress!();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 10, 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: gradientStops ?? [0.5, 1],
                  colors:
                      gradientColors ?? [Colors.transparent, Colors.black54])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: titleTextAlign ?? TextAlign.center,
                      style: titleStyle ??
                          textTheme.displaySmall?.copyWith(
                              fontSize: 12.sp,
                              color: VmodelColors.white,
                              fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              if (subTitle != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        subTitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.displaySmall?.copyWith(
                            fontSize: 12.sp,
                            color: VmodelColors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              addVerticalSpacing(3),
              addVerticalSpacing(4),
            ],
          ),
        ),
      ),
    );
  }
}
