import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/core/network/urls.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/data/field_mock_data.dart';
import 'package:vmodel/src/features/dashboard/feed/views/feed_home_view.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_history_main.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class FeedMainUI extends ConsumerStatefulWidget {
  const FeedMainUI({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FeedMainUI> createState() => _FeedHomeUIState();
}

class _FeedHomeUIState extends ConsumerState<FeedMainUI> {
  final homeCtrl = Get.put<HomeController>(HomeController());

  bool isLoading = VUrls.shouldLoadSomefeatures;
  bool issearching = false;
  Future stopLoading() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  Future<void> onRefresh() async {}

  @override
  Widget build(
    BuildContext context,
  ) {
    final isProView = ref.watch(isProViewProvider);

    List postImages = [
      feedImagesList2,
      feedImagesList1,
      feedImagesList3,
      feedImagesList4,
      feedImagesList5,
      feedImagesList6,
      feedImagesList7,
      feedImagesList8,
      feedImagesList9,
      feedImagesList10,
      feedImagesList11,
      feedImagesList12,
      feedImagesList13,
      feedImagesList14,
      feedImagesList15,
      feedImagesList16,
      feedImagesList17,
      feedImagesList18,
      feedImagesList19,
      feedImagesList20,
    ];

    return GestureDetector(
      onTap: () {
        closeAnySnack();
      },
      child: Scaffold(
        appBar: VWidgetsAppBar(
          appbarTitle: "Feed",
          leadingWidth: 150,
          leadingIcon: Padding(
            padding: const EdgeInsets.only(top: 0, left: 8),
            child: Row(
              children: [
                GestureDetector(
                  child: RenderSvg(
                    svgPath: VIcons.verticalPostIcon,
                    color: VmodelColors.disabledButonColor.withOpacity(0.15),
                  ),
                ),
                addHorizontalSpacing(15),
                GestureDetector(
                  child: SvgPicture.asset(VIcons.horizontalPostIcon,
                      color: VmodelColors.disabledButonColor.withOpacity(0.15)),
                ),
              ],
            ),
          ),
          elevation: 0,
          trailingIcon: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 0, right: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final current =
                              ref.read(isProViewProvider.notifier).state;
                          print('EEEEEEEEEEEE $current');
                          ref.read(isProViewProvider.notifier).state = !current;
                          // fProvider.isPictureViewState();
                        },
                        child: isProView
                            ? const RenderSvg(
                                svgPath: VIcons.videoFilmIcon,
                              )
                            : RenderSvg(
                                svgPath: VIcons.videoFilmIcon,
                                color: VmodelColors.disabledButonColor
                                    .withOpacity(0.15),
                              ),
                      ),
                      addHorizontalSpacing(15),
                      GestureDetector(
                        onTap: () {
                          navigateToRoute(context, const NotificationMain());
                        },
                        child: const RenderSvg(
                          svgPath: VIcons.notification,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // child: ,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 12, right: 0),
            //   child: SizedBox(
            //     height: 30,
            //     width: 60,
            //     child: IconButton(
            //       padding: const EdgeInsets.all(0),
            //       onPressed: () {
            //         navigateToRoute(context,  SavedView());
            //       },
            //       icon: const RenderSvg(
            //         svgPath: VIcons.unsavedPostsIcon,
            //       ),
            //     ),
            //   ),
            // ),
            // fProvider.isFeed
            //     ?
            // Padding(
            //         padding: const EdgeInsets.only(top: 12, right: 0),
            //         child: IconButton(
            //           padding: const EdgeInsets.all(0),
            //           onPressed: () {
            //             navigateToRoute(context, NotificationsView());
            //           },
            //           icon: const RenderSvg(
            //             svgPath: VIcons.notification,
            //           ),
            //         ),
            //       )
            // : Padding(
            //     padding: const EdgeInsets.only(top: 12, right: 0),
            //     child: IconButton(
            //       padding: const EdgeInsets.all(0),
            //       onPressed: () {
            //         setState(() {
            //           issearching = !issearching;
            //           print(issearching);
            //         });
            //       },
            //       icon: const RenderSvg(
            //         svgPath: VIcons.searchNormal,
            //       ),
            //     ),
            //   ),
          ],
        ),

        // commit

        body: FeedHomeView(),
      ),
      // FeedExplore(issearching: issearching,)),
    );
  }
}
