import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../res/gap.dart';

class JobShimmerPage extends StatelessWidget {
  final bool showTrailing;
  final bool showTitle;
  final bool showSearchShimmer;
  const JobShimmerPage(
      {this.showTrailing = true, super.key, this.showTitle = true, this.showSearchShimmer = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: showTitle
            ? VWidgetsAppBar(
                appbarTitle: '',
                leadingIcon: Shimmer.fromColors(
                    // baseColor: const Color(0xffD9D9D9),
                    // highlightColor: const Color(0xffF0F1F5),
                    baseColor: Theme.of(context).colorScheme.surfaceVariant,
                    highlightColor:
                        Theme.of(context).colorScheme.onSurfaceVariant,
                    child: const Padding(
                      padding: EdgeInsets.all(9),
                      child: CircleAvatar(),
                    )),
                titleWidget: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surfaceVariant,
                  highlightColor:
                      Theme.of(context).colorScheme.onSurfaceVariant,
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
                        baseColor: Theme.of(context).colorScheme.surfaceVariant,
                        highlightColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        child: const CircleAvatar()),
                ],
              )
            : null,
        body: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surfaceVariant,
          highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  addVerticalSpacing(18),
                  if(showSearchShimmer)
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
                      child: GridView.builder(
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        height: 150,
                        width: SizerUtil.width * 0.40,
                        // width: MediaQuery.of(context).size.width,
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
                      );
                    },
                  )

                      // ListView.builder(
                      //     itemCount: 10,
                      //     itemBuilder: (context, index) {
                      //       return Column(
                      //         children: [
                      //           Container(
                      //             padding: const EdgeInsets.only(
                      //               bottom: 10,
                      //             ),
                      //             height:
                      //                 MediaQuery.of(context).size.height * 0.15,
                      //             width: MediaQuery.of(context).size.width,
                      //             // padding: EdgeInsets.symmetric(vertical: 5),
                      //             child: Container(
                      //               decoration: const BoxDecoration(
                      //                 color: Color(0xFF303030),
                      //                 borderRadius:
                      //                     BorderRadius.all(Radius.circular(15)),
                      //               ),
                      //               child: Column(
                      //                 children: [Container()],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     }),
                      ),
                ],
              )),
        ));
  }
}
