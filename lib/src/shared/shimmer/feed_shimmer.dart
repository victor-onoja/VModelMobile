import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/res/gap.dart';

feedShimmer(BuildContext context,
    [double? paddingRight, double? paddingLeft, double? paddingBottom]) {
  return Shimmer.fromColors(
    // baseColor: const Color(0xffD9D9D9),
    // highlightColor: const Color(0xffF0F1F5),
    baseColor: Theme.of(context).colorScheme.surfaceVariant,
    highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpacing(18),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          bottom: paddingBottom ??= 10, left: 18),
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(15),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10, left: 18),
                      height: 30,
                      width: 160,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(2),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(2),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                )
              ],
            ),
          ),
          addVerticalSpacing(12),
          Container(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            height: MediaQuery.of(context).size.height / 1.7,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(vertical: 5),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              child: Column(
                children: [Container()],
              ),
            ),
          ),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(5),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(2),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(2),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(2),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(2),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    addHorizontalSpacing(5),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      // padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          addVerticalSpacing(12),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Container(
              height: 25,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // padding: EdgeInsets.symmetric(vertical: 5),
            ),
          ),
          addVerticalSpacing(6),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Container(
              height: 25,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // padding: EdgeInsets.symmetric(vertical: 5),
            ),
          ),
          addVerticalSpacing(6),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Container(
              height: 25,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // padding: EdgeInsets.symmetric(vertical: 5),
            ),
          ),
        ]),
  );
}
