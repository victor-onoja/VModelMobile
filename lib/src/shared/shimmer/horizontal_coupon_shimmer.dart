import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


class HorizontalCouponShimmer extends StatelessWidget {
  final bool showTrailing;
  final bool showTitle;
  const HorizontalCouponShimmer(
      {this.showTrailing = true, super.key, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surfaceVariant,
        highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
        child: SizedBox(
          height: 100,
          width: SizerUtil.width * .9,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: 100,
                  width: 60.w,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF303030),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [Container()],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
