import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../res/res.dart';
import '../../../shared/picture_styles/rounded_square_avatar.dart';

class HorizontalRecentlyViewedImages<T> extends ConsumerStatefulWidget {
  const HorizontalRecentlyViewedImages({
    super.key,
    required this.items,
    required this.itemSize,
    this.itemRadius = 5,
    required this.title,
    required this.onViewAllTap,
    required this.onTap,
    required this.itemBuilder,
  });

  final double itemRadius;
  final String title;
  final Size itemSize;
  final List<T> items;
  final VoidCallback onViewAllTap;
  final Function(String username) onTap;
  final IndexedWidgetBuilder itemBuilder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HorizontalCouponSectionState();
}

class _HorizontalCouponSectionState
    extends ConsumerState<HorizontalRecentlyViewedImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: context.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: widget.onViewAllTap,
                child: Text(
                  "View all".toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: widget.itemSize.height,
          margin: EdgeInsets.only(bottom: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: widget.items.length,
            padding: EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) {
              return addHorizontalSpacing(8);
            },
            itemBuilder: (context, index) {
              return widget.itemBuilder(context, index);
              return GestureDetector(
                onTap: () {
                  // widget.onTap(widget.items[index].username);
                },
                child: RoundedSquareAvatar(
                    url: widget.items[index],
                    thumbnail: '',
                    radius: widget.itemRadius,
                    size: widget.itemSize,
                    errorWidget: ColoredBox(
                      color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                    )
                    // imageWidget: Image.asset(
                    //   widget.items[index],
                    //   fit: BoxFit.cover,
                    // ),
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}
