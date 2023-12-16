import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../res/gap.dart';
import '../job_service_section_container.dart';

class JobDetailShimmerPage extends StatelessWidget {
  final bool showTrailing;
  const JobDetailShimmerPage({this.showTrailing = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VWidgetsAppBar(
          appbarTitle: '',
          leadingIcon: Shimmer.fromColors(
              // baseColor: const Color(0xffD9D9D9),
              // highlightColor: const Color(0xffF0F1F5),
              baseColor: Theme.of(context).colorScheme.surfaceVariant,
              highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
              child: const Padding(
                padding: EdgeInsets.all(9),
                child: CircleAvatar(),
              )),
          titleWidget: Shimmer.fromColors(
            // baseColor: const Color(0xffD9D9D9),
            // highlightColor: const Color(0xffF0F1F5),
            baseColor: Theme.of(context).colorScheme.surfaceVariant,
            highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
            child: Container(
              height: 20,
              width: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF303030),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          trailingIcon: [
            if (showTrailing)
              Shimmer.fromColors(
                  // baseColor: const Color(0xffD9D9D9),
                  // highlightColor: const Color(0xffF0F1F5),
                  baseColor: Theme.of(context).colorScheme.surfaceVariant,
                  highlightColor:
                      Theme.of(context).colorScheme.onSurfaceVariant,
                  child: const CircleAvatar()),
            addHorizontalSpacing(8),
          ],
        ),
        body: Shimmer.fromColors(
          // baseColor: const Color(0xffD9D9D9),
          // highlightColor: const Color(0xffF0F1F5),
          baseColor: Theme.of(context).colorScheme.surfaceVariant,
          highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  addVerticalSpacing(18),
                  const SectionContainer(
                    bottomRadius: 0,
                    topRadius: 16,
                    color: Color(0xFF303030),
                    child: SizedBox(height: 24),
                  ),
                  addVerticalSpacing(2),
                  const SectionContainer(
                    bottomRadius: 0,
                    topRadius: 0,
                    color: Color(0xFF303030),
                    child: SizedBox(height: 12),
                  ),
                  addVerticalSpacing(2),
                  const SectionContainer(
                    bottomRadius: 16,
                    topRadius: 0,
                    color: Color(0xFF303030),
                    child: SizedBox(height: 56),
                  ),
                  addVerticalSpacing(24),
                  const Row(
                    children: [
                      Expanded(
                        child: SectionContainer(
                          bottomRadius: 16,
                          topRadius: 16,
                          color: Color(0xFF303030),
                          padding: EdgeInsets.zero,
                          child: SizedBox(height: 20),
                        ),
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                  addVerticalSpacing(8),
                  const SectionContainer(
                    bottomRadius: 16,
                    topRadius: 16,
                    color: Color(0xFF303030),
                    child: SizedBox(height: 56),
                  ),
                  addVerticalSpacing(24),
                  const Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SectionContainer(
                          bottomRadius: 16,
                          topRadius: 16,
                          color: Color(0xFF303030),
                          padding: EdgeInsets.zero,
                          child: SizedBox(height: 20),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  addVerticalSpacing(8),
                  const SectionContainer(
                    bottomRadius: 16,
                    topRadius: 16,
                    color: Color(0xFF303030),
                    child: SizedBox(height: 100),
                  ),
                  addVerticalSpacing(24),
                  const Row(
                    children: [
                      Expanded(
                        child: SectionContainer(
                          bottomRadius: 16,
                          topRadius: 16,
                          color: Color(0xFF303030),
                          padding: EdgeInsets.zero,
                          child: SizedBox(height: 20),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  addVerticalSpacing(8),
                  const SectionContainer(
                    bottomRadius: 16,
                    topRadius: 16,
                    color: Color(0xFF303030),
                    child: SizedBox(height: 64),
                  ),
                  addVerticalSpacing(24),
                  // Container(
                  //   padding: const EdgeInsets.only(
                  //     bottom: 15,
                  //   ),
                  //   height: MediaQuery.of(context).size.height * 0.1,
                  //   width: MediaQuery.of(context).size.width,
                  //   // padding: EdgeInsets.symmetric(vertical: 5),
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //       color: Color(0xFF303030),
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //     ),
                  //     child: Column(
                  //       children: [Container()],
                  //     ),
                  //   ),
                  // ),
                ],
              )),
        ));
  }
}
