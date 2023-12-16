import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/res/gap.dart';

contentShimmer(BuildContext context,
    [double? paddingRight, double? paddingLeft, double? paddingBottom]) {
  return Shimmer.fromColors(
    //  baseColor: const Color(0xff949599),
    //   highlightColor: const Color(0xffF0F1F5),
    baseColor: Theme.of(context).colorScheme.surfaceVariant,
    highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            addVerticalSpacing(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 160,
                  decoration: const BoxDecoration(
                    color: Color(0xFF303030),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  // padding: EdgeInsets.symmetric(vertical: 5),
                ),
                addHorizontalSpacing(15),
                Container(
                  padding:
                      EdgeInsets.only(bottom: paddingBottom ??= 10, left: 18),
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Color(0xFF303030),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  // padding: EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
            addVerticalSpacing(10),
            Container(
              height: 25,
              width: 160,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // padding: EdgeInsets.symmetric(vertical: 5),
            ),
            addVerticalSpacing(2),
            Container(
              height: 25,
              width: 160,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // padding: EdgeInsets.symmetric(vertical: 5),
            ),
            addVerticalSpacing(2),
            Container(
              height: 25,
              width: 160,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // padding: EdgeInsets.symmetric(vertical: 5),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Color(0xFF303030),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // padding: EdgeInsets.symmetric(vertical: 5),
              ),
              addVerticalSpacing(10),
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Color(0xFF303030),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // padding: EdgeInsets.symmetric(vertical: 5),
              ),
              addVerticalSpacing(10),
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Color(0xFF303030),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // padding: EdgeInsets.symmetric(vertical: 5),
              ),
              addVerticalSpacing(10),
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Color(0xFF303030),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // padding: EdgeInsets.symmetric(vertical: 5),
              ),
              addVerticalSpacing(10),
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Color(0xFF303030),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // padding: EdgeInsets.symmetric(vertical: 5),
              ),
              addVerticalSpacing(10),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF303030),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // padding: EdgeInsets.symmetric(vertical: 5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
