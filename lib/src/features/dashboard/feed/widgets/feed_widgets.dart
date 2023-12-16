import 'package:badges/badges.dart' as notiBadge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';
import '../controller/feed_provider.dart';


class IconsRow extends ConsumerWidget {
  final String firstIcon;
  final String iconReplacement;
  final bool notification;
  final String secondIcon;
  final String? thirdIcon;
  final double spaceBetween;
  final int numberOfShares;
  final int numberOfLikes;
  final Function()? onLikeTap;
  final HomeController homeCtrl;
  final bool isOption;
  final MainAxisAlignment mainAxisAlignment;

  const IconsRow(
      {Key? key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.notification = false,
      this.numberOfLikes = 0,
      required this.homeCtrl,
      this.numberOfShares = 0,
        required this.isOption,
      this.onLikeTap,
      this.thirdIcon,
      this.spaceBetween = 20.0,
      this.firstIcon = 'assets/images/doc/box1.svg',
      this.iconReplacement = 'assets/images/doc/box1.svg',
      this.secondIcon = 'assets/images/doc/box2.svg'})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(feedProvider);
    final fProvider = ref.watch(feedProvider.notifier);

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (thirdIcon != null && !fProvider.isFeed)
          Row(
            children: [
              SvgPicture.asset(
                thirdIcon!, width: 23, height: 23,
              ),
              SizedBox(
                width: spaceBetween,
              ),
            ],
          ),

        Column(
          children: [
            GestureDetector(
              onTap: onLikeTap,
              child: RenderSvg(
                svgPath: firstIcon, svgHeight: 23, svgWidth: 23,
              ),
            ),
            if (numberOfShares > 0)
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text(
                  NumberFormat.compactCurrency(
                    decimalDigits: 2,
                    symbol: '',
                  ).format(numberOfShares).toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: VmodelColors.primaryColor),
                ),
              ),
          ],
        ),

        SizedBox(
          width: spaceBetween,
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                if (notification == false)
                  InkWell(
                    onTap: (onLikeTap == null) ? () {} : onLikeTap!,
                    child: SvgPicture.asset(
                      (isOption) ? secondIcon : iconReplacement,
                   width: 23, height:23, ),
                  ),
                if (notification == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: notiBadge.Badge(
                      alignment: Alignment.topRight,
                      badgeColor: VmodelColors.bottomNavIndicatiorColor,
                      elevation: 0,
                      toAnimate: true,
                      showBadge: true,
                      badgeContent: Text(
                        '3',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: VmodelColors.white),
                      ),
                      child: SvgPicture.asset(
                        secondIcon, width: 230, height: 23,
                      ),
                    ),
                  ),
              ],
            ),
            if (numberOfLikes > 0)
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text(
                  NumberFormat.compactCurrency(
                    decimalDigits: 2,
                    symbol: '',
                  ).format(numberOfLikes).toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: VmodelColors.primaryColor),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class IconsRowPageSwap extends ConsumerWidget {
  final String firstIcon;
  final bool notification;
  final String secondIcon;
  final double spaceBetween;
  final Function()? onLikeTap;
  final HomeController homeCtrl;
  final MainAxisAlignment mainAxisAlignment;

  const IconsRowPageSwap(
      {Key? key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.notification = false,
      required this.homeCtrl,
      this.onLikeTap,
      this.spaceBetween = 20.0,
      this.firstIcon = 'assets/images/doc/box1.svg',
      this.secondIcon = 'assets/images/doc/box2.svg'})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(feedProvider);
    final fProvider = ref.watch(feedProvider.notifier);

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                fProvider.isFeedPage();
              },
              child: RenderSvg(
                svgPath: firstIcon,
                color: fProvider.isFeed
                    ? null
                    : VmodelColors.disabledButonColor.withOpacity(0.15),
              ),
            ),
          ],
        ),
        SizedBox(
          width: spaceBetween,
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                if (notification == false)
                  InkWell(
                    onTap: () {
                      fProvider.isFeedPage();
                    },
                    child: SvgPicture.asset(
                      secondIcon,
                      color: fProvider.isFeed
                          ? VmodelColors.disabledButonColor.withOpacity(0.15)
                          : null,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}







