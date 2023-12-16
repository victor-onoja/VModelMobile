import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';


class RewardsInfoCard extends StatelessWidget {
  const RewardsInfoCard({
    required this.titleText,
    required this.subtitleText,
    this.leadingSvgAsset,
    this.onCopyPressed,
    super.key,
  });

  final Widget? leadingSvgAsset;
  final String titleText;
  final String subtitleText;
  final VoidCallback? onCopyPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          // CustomBoxShadow(
          //     color: Colors.grey.withOpacity(.5),
          //     offset: Offset(5.0, 5.0),
          //     blurRadius: 5.0,
          //     blurStyle: BlurStyle.outer)
          BoxShadow(
            color: Colors.black.withOpacity(.07),
            blurRadius: 5.0, // soften the shadow
            spreadRadius: -3, //extend the shadow
            offset: const Offset(0.0, 0.0),
          )
          // BoxShadow(
          //   color: Colors.black.withOpacity(.07),
          //   blurRadius: 10.0, // soften the shadow
          //   spreadRadius: 5.0, //extend the shadow
          //   offset: const Offset(
          //     2.0, // Move to right 10  horizontally
          //     5.0, // Move to bottom 10 Vertically
          //   ),
          // )
        ],
      ),
      child: Card(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(children: [
            if (leadingSvgAsset != null) leadingSvgAsset!,
            addHorizontalSpacing(16),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titleText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  addVerticalSpacing(4),
                  Text(subtitleText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!),
                ],
              ),
            ),
            addHorizontalSpacing(16),
            IconButton(
              onPressed: () {
                onCopyPressed?.call();
              },
              icon: SvgPicture.asset(
                VIcons.copyUrlIcon,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
