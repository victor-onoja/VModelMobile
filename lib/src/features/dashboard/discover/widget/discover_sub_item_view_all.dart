// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';
import '../models/discover_item.dart';

class DiscoverSubItemViewAll extends StatelessWidget {
  final DiscoverItemObject item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const DiscoverSubItemViewAll({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      onLongPress: () {
        onLongPress!();
      },
      child: Container(
        height: 200,
        width: SizerUtil.width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.fromLTRB(8, 0, 10, 3),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(item.image),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.6, 1],
                        colors: [Colors.transparent, Colors.black87])),
              ),
            ),
            addVerticalSpacing(9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    item.username,
                    style: textTheme.displaySmall?.copyWith(
                        fontSize: 11.sp,
                        // color: VmodelColors.primaryColor,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RenderSvg(
                      svgPath: VIcons.star,
                      // color: VmodelColors.primaryColor,
                      svgWidth: 10,
                      svgHeight: 10,
                    ),
                    addHorizontalSpacing(10),
                    Text(
                      item.points,
                      style: textTheme.displaySmall?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        // color: VmodelColors.primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            addVerticalSpacing(9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    // "From £299",
                    item.price ?? '£299',
                    style: textTheme.displaySmall?.copyWith(
                        fontSize: 10.sp,
                        // color: VmodelColors.ligtenedText.withOpacity(0.5),
                        color: textTheme.displaySmall?.color?.withOpacity(0.5),
                        fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "2 miles away",
                  style: textTheme.displaySmall?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    // color: VmodelColors.ligtenedText.withOpacity(0.5),
                    color: textTheme.displaySmall?.color?.withOpacity(0.5),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
