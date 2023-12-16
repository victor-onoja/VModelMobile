import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:vmodel/src/core/network/urls.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/send.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/shimmer/contentShimmerPage.dart';

import '../../../../res/colors.dart';
import '../../../../vmodel.dart';
import '../../dash/controller.dart';
import '../../feed/widgets/share.dart';
import '../data/content_mock_data.dart';
import '../widget/content_icons.dart';
import '../widget/content_note.dart';
import '../widget/pop_menu.dart';
import '../widget/search_box.dart';
import '../widget/search_results/current_search.dart';
import '../widget/search_results/no_result_found.dart';
import '../widget/search_results/popular.dart';

class ContentView extends StatefulWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  bool searching = false;
  bool check = false;

  String text = "";
  final TextEditingController _searchController = TextEditingController();
  final PageController _controller = PageController();
  late VideoPlayerController _videoController;
  String videoLink = "assets/videos/ins2.mp4";
  playVideo(String video) {
    _videoController = VideoPlayerController.asset(video)
      ..initialize().then((_) {
        _videoController.setLooping(false);
        _videoController.play();
        setState(() {});
      });
  }

  bool isLoading = VUrls.shouldLoadSomefeatures;
  int taps = 0;
  @override
  void initState() {
    super.initState();
    if (isLoading == false) {
      playVideo(videoLink);
    }
  }

  @override
  void dispose() {
    if (isLoading == false) {
      _controller.dispose();
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button press
        // return goBackHome(context);
        moveAppToBackGround();
        return false;
      },
      child: isLoading == true
          ? const ContentShimmerPage(
              shouldHaveAppBar: false,
            )
          : GestureDetector(
              onTap: () => dismissKeyboard(),
              child: Scaffold(
                backgroundColor: VmodelColors.blackColor,
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _controller,
                      itemCount: contentMockData.length,
                      onPageChanged: (index) async {
                        await _videoController.dispose();
                        playVideo(contentMockData[index]['videoLink']);
                      },
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _videoController.value.isPlaying
                                        ? _videoController.pause()
                                        : _videoController.play();
                                  });
                                },
                                onDoubleTap: () {
                                  setState(() {
                                    contentMockData[index]['isLiked'] =
                                        !contentMockData[index]['isLiked'];
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    contentMockData[index]['isSaved'] =
                                        !contentMockData[index]['isSaved'];
                                  });
                                },
                                child: VideoPlayer(_videoController),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: ContentNote(
                                      name: contentMockData[index]['name'],
                                      rating: contentMockData[index]['rating'],
                                    ),
                                  ),
                                  Flexible(
                                    child: RenderContentIcons(
                                      likes: contentMockData[index]['likes'],
                                      shares: contentMockData[index]['shares'],
                                      isLiked: contentMockData[index]
                                          ['isLiked'],
                                      isShared: contentMockData[index]
                                          ['isShared'],
                                      isSaved: contentMockData[index]
                                          ['isSaved'],
                                      likedFunc: () {
                                        setState(() {
                                          contentMockData[index]['isLiked'] =
                                              !contentMockData[index]
                                                  ['isLiked'];
                                        });
                                      },
                                      saveFunc: () {
                                        setState(() {
                                          contentMockData[index]['isSaved'] =
                                              !contentMockData[index]
                                                  ['isSaved'];
                                        });
                                      },
                                      shieldFunc: () {
                                        setState(() {
                                          contentMockData[index]['isShared'] =
                                              !contentMockData[index]
                                                  ['isShared'];
                                        });
                                      },
                                      shareFunc: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          isDismissible: true,
                                          useRootNavigator: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) =>
                                              const ShareWidget(
                                            shareLabel: 'Share Post',
                                            shareTitle: 'Samantha\'s Post',
                                            shareImage:
                                                'assets/images/doc/main-model.png',
                                            shareURL:
                                                'Vmodel.app/post/samantha-post',
                                          ),
                                        );
                                      },
                                      sendFunc: () {
                                        showModalBottomSheet(
                                          useSafeArea: true,
                                          isScrollControlled: false,
                                          isDismissible: true,
                                          useRootNavigator: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => Container(
                                              constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .85,
                                                // minHeight: MediaQuery.of(context).size.height * .10,
                                              ),
                                              child: const SendWidget()),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              check == false
                                  ? const SizedBox()
                                  : BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5.0, sigmaY: 5.0),
                                      child: Container(
                                        color: Colors.black.withOpacity(0.3),
                                      )),
                              _topButtons(context),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
    );
  }

  Widget _topButtons(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return SafeArea(
          child: Padding(
            // padding: const EdgeInsets.fromLTRB(10, 25, 15, 20),
            padding: const EdgeInsets.fromLTRB(0, 05, 8, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          // navigateToRoute(context, FeedMainUI());
                          ref
                              .read(dashTabProvider.notifier)
                              .switchAndShowMainFeedPage();
                        },
                        icon: RenderSvg(
                          svgPath: VIcons.verticalPostIcon,
                          color: VmodelColors.white,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        !searching
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    searching = true;
                                    check = true;
                                  });
                                },
                                padding: const EdgeInsets.only(right: 0),
                                icon: RenderSvg(
                                  svgPath: VIcons.searchIcon,
                                  svgHeight: 24,
                                  svgWidth: 24,
                                  color: VmodelColors.white,
                                ),
                              )
                            // GestureDetector(
                            //     onTap: () => setState(() {
                            //       searching = true;
                            //       check = true;
                            //     }),
                            //     child: const Icon(
                            //       Icons.search,
                            //       size: 35,
                            //       color: Color.fromRGBO(
                            //           255, 255, 255, 0.8),
                            //     ),
                            //   )
                            : Flexible(
                                child: SearchBox(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      text = value;
                                    });
                                  },
                                  suffixIcon: text.isEmpty
                                      ? IconButton(
                                          onPressed: () {},
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          icon: RenderSvg(
                                            svgPath: VIcons.searchIcon,
                                            svgHeight: 24,
                                            svgWidth: 24,
                                            color: VmodelColors.white,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _searchController.clear();
                                              setState(() {
                                                text = "";
                                                searching = false;
                                                check = false;
                                              });
                                            },
                                            child: Container(
                                              height: 18,
                                              width: 18,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.8),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: VmodelColors.black,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        const ContentPopMenu(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                searching
                    ? text.isEmpty
                        ? const PopularSearch()
                        : text.toLowerCase() == "content"
                            ? const CurrentSearch()
                            : const NoSearchResultFound()
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
      // child: ,
    );
  }
}
