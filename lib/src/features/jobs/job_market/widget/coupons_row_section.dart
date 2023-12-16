import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/shimmer/horizontal_coupon_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';
import '../controller/coupons_controller.dart';
import '../widget/hottest_coupon_tile.dart';

class HorizontalCouponSection extends ConsumerStatefulWidget {
  const HorizontalCouponSection({
    super.key,
    required this.title,
    this.trailingTitleWidget,
  });
  final String title;
  final Widget? trailingTitleWidget;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HorizontalCouponSectionState();
}

class _HorizontalCouponSectionState
    extends ConsumerState<HorizontalCouponSection> {
  late List<MaterialColor> mColors;
  bool isEmptyOrError = false;

  @override
  initState() {
    super.initState();
  }

  void updateIsEmpty(bool value) {
    isEmptyOrError = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hottestCouponsSimple = ref.watch(hottestCouponsProvider);

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
              widget.trailingTitleWidget ?? SizedBox.shrink(),
            ],
          ),
        ),
        Container(
          height: isEmptyOrError ? 0 : 100,
          margin: EdgeInsets.only(bottom: 16),
          child: hottestCouponsSimple.when(
            data: (value) {
              if (value.isEmpty) {
                updateIsEmpty(true);
              }
              return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: value.length + 1,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (context, index) {
                    return addHorizontalSpacing(8);
                  },
                  itemBuilder: (context, index) {
                    if (index == value.length) {
                      return Container(
                        width: 30.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: mColors[index % mColors.length],
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "VIEW MORE",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      );
                    }

                    return HottestCouponTile(
                      index: index,
                      date: value[index].dateCreated,
                      username: value[index].owner!.username!,
                      thumbnail: value[index].owner!.profilePictureUrl!,
                      couponId: value[index].id!,
                      couponTitle: value[index].title!,
                      couponCode: value[index].code!,
                    );
                  });
            },
            loading: () {
              updateIsEmpty(false);
              return HorizontalCouponShimmer();
            },
            error: (error, stackTrace) {
              print('$error, $stackTrace');
              updateIsEmpty(true);

              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
