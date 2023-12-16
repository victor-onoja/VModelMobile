import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../res/gap.dart';

class MarketplaceHomeItemsShimmerPage extends StatelessWidget {
  final bool showTrailing;
  final bool showTitle;
  const MarketplaceHomeItemsShimmerPage(
      {this.showTrailing = true, super.key, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surfaceVariant,
        highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: SizerUtil.width * 0.50,
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
                Container(
                  height: 20,
                  width: 50,
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
              ],
            ),
            addVerticalSpacing(10),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          height: 150,
                          width: SizerUtil.width * 0.40,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF303030),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [Container()],
                            ),
                          ),
                        ),
                        for (var i = 0; i < 3; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 15,
                                  width: 100,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF303030),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [Container()],
                                    ),
                                  ),
                                ),
                                addHorizontalSpacing(5),
                                Container(
                                  height: 15,
                                  width: 50,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF303030),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      children: [Container()],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        addVerticalSpacing(10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
