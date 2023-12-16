import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/res/gap.dart';

jobShimmer(BuildContext context,
    [double? paddingRight, double? paddingLeft, double? paddingBottom]) {
  return Shimmer.fromColors(
    // baseColor: const Color(0xffD9D9D9),
    // highlightColor: const Color(0xffF0F1F5),
    baseColor: Theme.of(context).colorScheme.surfaceVariant,
    highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(18),
            Container(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.symmetric(vertical: 5),
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
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      // padding: EdgeInsets.symmetric(vertical: 5),
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
                );
              }),
            ),
          ]),
    ),
  );
}
