import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/urls.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/data/field_mock_data.dart';
import 'package:vmodel/src/features/dashboard/feed/views/feed_home_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/pop_scope_to_background_wrapper.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../saved/views/delte_ml/views/example_del_ml_posts.dart';
import '../../content/views/content_main_screen.dart';
import '../../dash/controller.dart';
import '../controller/feed_provider.dart';
import '../controller/new_feed_provider.dart';

class FeedMainUI extends ConsumerStatefulWidget {
  const FeedMainUI({
    Key? key,
  }) : super(key: key);

  static const routeName = 'feed';

  @override
  ConsumerState<FeedMainUI> createState() => _FeedHomeUIState();
}

class _FeedHomeUIState extends ConsumerState<FeedMainUI>
    with TickerProviderStateMixin {
  final homeCtrl = Get.put<HomeController>(HomeController());
  String feedTitle = "Feed";
  late AnimationController _bellController;

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

  final List postImages = [
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

  Future<void> onRefresh() async {}

  @override
  void initState() {
    _bellController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final watchProvider = ref.watch(dashTabProvider.notifier);
    ref.watch(feedProvider);
    final fProvider = ref.watch(feedProvider.notifier);
    final isProView = ref.watch(isProViewProvider);
    final isRecommendedView = ref.watch(isRecommendedViewNotifier);
    final recommendedViewNotifier =
        ref.read(isRecommendedViewNotifier.notifier);

    return PopToBackgroundWrapper(
      child: GestureDetector(
        onTap: () {
          closeAnySnack();
        },
        child: fProvider.isFeed
            ? Scaffold(
                appBar: VWidgetsAppBar(
                  appbarTitle: fProvider.isFeed ? feedTitle : "",
                  elevation: 0,
                  trailingIcon: [
                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 0, right: 0),
                          child: Row(
                            children: [
                              if (fProvider.isFeed)
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();

                                    recommendedViewNotifier
                                        .setRecommended(!isRecommendedView);

                                    if (!isRecommendedView) {
                                      setState(() {
                                        feedTitle = "Recommended";
                                      });
                                    } else {
                                      setState(() {
                                        feedTitle = "Feed";
                                      });
                                    }
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 13),
                                      child: RenderSvg(
                                        svgPath: VIcons.colorFilter,
                                        color: isRecommendedView
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5),
                                      )),
                                ),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  final current = ref
                                      .read(isProViewProvider.notifier)
                                      .state;
                                  ref.read(isProViewProvider.notifier).state =
                                      !current;
                                  // fProvider.isPictureViewState();

                                  setState(() {
                                    isProView
                                        ? isRecommendedView
                                            ? feedTitle = "Recommended"
                                            : feedTitle = "Feed"
                                        : feedTitle = "Slides";
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 13),
                                  child: isProView
                                      ? RenderSvg(
                                          svgPath: VIcons.videoFilmIcon,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : RenderSvg(
                                          svgPath: VIcons.videoFilmIcon,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),

                // commit

                body: isRecommendedView ? RecommendedFeed() : FeedHomeView(),
              )
            : const ContentView(),
        // FeedExplore(issearching: issearching,)),
      ),
    );
  }
}

// LayoutBuilder(builder: (context, constraint) {
//           return ListView(
//             children: [
//               FutureBuilder(
//                   future: stopLoading(),
//                   builder: (context, snapshot) {
//                     return SafeArea(
//                       child: RefreshIndicator(
//                           onRefresh: () {
//                             return reloadData();
//                           },
//                           child: isLoading == true
//                               ? const FeedShimmerPage(
//                                   shouldHaveAppBar: false,
//                                 )
//                               : Container(
//                                   padding: const EdgeInsets.all(20.0),
//                                   constraints: BoxConstraints(
//                                     minHeight: constraint.maxHeight,
//                                   ),
//                                   child: const Center(
//                                     child: EmptyPage(
//                                       title: 'No Posts Yet',
//                                       subtitle:
//                                           'Follow creators or brands to show content here!',
//                                     ),
//                                   ),
//                                 )),
//                     );
//                   }),
//             ],
//           );
//         }),
