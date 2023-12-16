import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/job_service_section_container.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../shared/picture_styles/rounded_square_avatar.dart';
import '../../../shared/popup_dialogs/response_dialogue.dart';
import '../../dashboard/discover/models/mock_data.dart';
import '../../dashboard/feed/model/feed_model.dart';
import '../controller/provider/board_posts_controller.dart';
import '../controller/provider/current_selected_board_provider.dart';
import '../controller/provider/recently_viewed_boards_controller.dart';
import '../controller/provider/saved_jobs_proiver.dart';
import '../controller/provider/saved_provider.dart';
import '../controller/provider/user_boards_controller.dart';
import '../model/recently_viewed_board_model.dart';
import '../model/user_post_board_model.dart';
import 'explore_v2.dart';
import '../../dashboard/feed/widgets/comment/create_new_board_dialogue.dart';
import '../widgets/text_overlayed_image.dart';
import 'boards_search.dart';
import 'recently_viewed.dart';
import 'saved_services.dart';
import 'saved_services_wrapper.dart';
import 'user_created_boards.dart';

class BoardsHomePageV3 extends ConsumerStatefulWidget {
  const BoardsHomePageV3({super.key});
  static const routeName = 'boards';

  @override
  ConsumerState<BoardsHomePageV3> createState() => _BoardsHomePageV3State();
}

class _BoardsHomePageV3State extends ConsumerState<BoardsHomePageV3>
    with TickerProviderStateMixin {
  late final TabController tabController;
  final tabTitles = ['Posts', 'Jobs', 'Services'];
  final mockImages = [
    'assets/images/photographers/photography.png',
    'assets/images/photographers/contents_creation.png',
    'assets/images/photographers/photography.png',
    'assets/images/photographers/contents_creation.png',
  ];

  final postCardsTitle = [
    'Photography',
    'Content Creation',
    'Photography',
    'Content Creation',
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final allPosts = ref.watch(getsavedPostProvider);
    final hiddenPosts = ref.watch(getHiddenPostProvider);
    final userCreatedBoards = ref.watch(userPostBoardsProvider);
    final pinnedBoards = ref.watch(pinnedBoardsProvider);
    final recentlyViewedBoards = ref.watch(recentlyViewedBoardsProvider);

    final savedServices = ref.watch(savedServicesProvider);
    final selectedBoard = ref.watch(currentSelectedBoardProvider);

    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Boards",
        trailingIcon: [],
        appBarHeight: 108,
        customBottom: PreferredSize(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  child: GestureDetector(
                    onTap: () {
                      navigateToRoute(context, BoardsSearchPage());
                    },
                    child: Container(
                      height: 5.h,
                      width: 100.0.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          addHorizontalSpacing(8),
                          Text(
                            'Search...',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    fontSize: 11.sp,
                                    overflow: TextOverflow.clip),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(16)),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await ref.refresh(getsavedPostProvider.future);
          await ref.refresh(getHiddenPostProvider.future);
          await ref.refresh(userPostBoardsProvider.future);
          await ref.refresh(recentlyViewedBoardsProvider.future);
          await ref.refresh(savedServicesProvider.future);
          ref.invalidate(currentSelectedBoardProvider);
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // addVerticalSpacing(12),
              recentlyViewedBoards.when(data: (values) {
                return HorizontalRecentlyViewedImages<String>(
                    title: 'Recently viewed',
                    itemSize: UploadAspectRatio.portrait.sizeFromX(45),
                    items: values
                        .map((e) => '${e.postBoard.coverImageUrl}')
                        .toList(),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          // widget.onTap(widget.items[index].username);

                          ref
                              .read(currentSelectedBoardProvider.notifier)
                              .setOrUpdateBoard(
                                SelectedBoard(
                                  board: values[index].postBoard,
                                  source: SelectedBoardSource.recent,
                                ),
                              );

                          navigateToRoute(
                              context,
                              ExploreV2(
                                title: values[index].postBoard.title,
                                providerType: BoardProvider.userCreated,
                                // userPostBoard: values[index].postBoard,
                              ));
                        },
                        child: RoundedSquareAvatar(
                            url: values[index].postBoard.coverImageUrl,
                            thumbnail: '',
                            radius: 8,
                            size: UploadAspectRatio.portrait.sizeFromX(45),
                            errorWidget: ColoredBox(
                              color:
                                  VmodelColors.jobDetailGrey.withOpacity(0.3),
                            )),
                      );
                    }),
                    onTap: (username) {},
                    onViewAllTap: () {
                      // navigateToRoute(context, RecentlyViewedAll(mockImages)),
                    });
              }, error: (error, stackTrace) {
                print('[cn7i $error $stackTrace');
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                      child: Text('Error fetching recently viewed board')),
                );
              }, loading: () {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionContainer(
                        width: 51.w,
                        height:
                            UploadAspectRatio.portrait.yDimensionFromX(55.w),
                        topRadius: 16,
                        bottomRadius: 16,
                        color: VmodelColors.jobDetailGrey.withOpacity(0.5),
                        child: TextOverlayedImage(
                          imageUrl:
                              '${firstPostThumbnailOrNull(allPosts.valueOrNull)}',
                          title: 'All Posts',
                          // imageProvider: AssetImage(mockImages.first),
                          gradientStops: [0.8, 1],
                          onTap: () {
                            navigateToRoute(
                                context,
                                ExploreV2(
                                  title: 'All Posts',
                                  providerType: BoardProvider.allPosts,
                                ));
                            // navigateToRoute(context, BoardsHomePage());
                          },
                          onLongPress: () {},
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: addHorizontalSpacing(26)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SectionContainer(
                        color: VmodelColors.jobDetailGrey.withOpacity(0.5),
                        width: 34.w,
                        height:
                            UploadAspectRatio.portrait.yDimensionFromX(34.w),
                        topRadius: 10,
                        bottomRadius: 10,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            pinnedBoards.maybeWhen(data: (items) {
                              if (items.isEmpty) return SizedBox.shrink();
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(
                                          currentSelectedBoardProvider.notifier)
                                      .setOrUpdateBoard(
                                        SelectedBoard(
                                          board: items.first,
                                          source:
                                              SelectedBoardSource.userCreatd,
                                        ),
                                      );
                                  navigateToRoute(
                                      context,
                                      ExploreV2(
                                        title: '${items.first.title}',
                                        providerType: BoardProvider.userCreated,
                                      ));
                                },
                                child: RoundedSquareAvatar(
                                  url: '${items.first.coverImageUrl}',
                                  thumbnail: '',
                                  size: UploadAspectRatio.portrait
                                      .sizeFromX(34.w),
                                  // imageWidget: Image.asset(
                                  //   mockImages.last,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              );
                            }, orElse: () {
                              return SizedBox.shrink();
                            }),
                            Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100)),
                                  padding: EdgeInsets.all(4),
                                  child: RenderSvg(
                                    svgPath: VIcons.pushPin,
                                    color: Colors.white,
                                    svgWidth: 14,
                                    svgHeight: 14,
                                  ),
                                )
                                // Icon(
                                //   VIcons.pushPin,
                                //   color: Colors.white,
                                // ),
                                ),
                          ],
                        ),
                      ),
                      addVerticalSpacing(2.h),
                      // SectionContainer(
                      //   color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                      //   width: 34.w,
                      //   height: 10.h,
                      //   topRadius: 10,
                      //   bottomRadius: 10,
                      //   child: InkResponse(
                      //     highlightShape: BoxShape.rectangle,
                      //     borderRadius: BorderRadius.circular(10),
                      //     onTap: () {
                      //       // print('[x2j] w: ${1.w} h:${1.h}');
                      //       showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return CreateNewBoardDialog(
                      //               buttonText: "Create",
                      //               controller: TextEditingController(),
                      //               onSave: (boardTitle) async {
                      //                 final success = await ref
                      //                     .read(userPostBoardsProvider.notifier)
                      //                     .createPostBoard(boardTitle);
                      //                 if (success && mounted) {
                      //                   goBack(context);
                      //                   responseDialog(context, "Board created");
                      //                 }
                      //               },
                      //             );
                      //           });
                      //     },
                      //     child: Icon(
                      //       Icons.add,
                      //       size: 30,
                      //       color: Colors.grey.shade400,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              addVerticalSpacing(16),
              userCreatedBoards.when(data: (items) {
                if (items.isEmpty) return SizedBox.shrink();
                return UserCreatedBoardsWidget(
                  boards: items,
                  itemSize: UploadAspectRatio.portrait.sizeFromX(43.w),
                  scrollBack: () {
                    // Scrollable.ensureVisible(key1.currentContext!);
                  },
                  // key: key1,
                  mockImages: userTypesMockImages,
                );
              }, error: (error, stackTrace) {
                return Text('Error');
              }, loading: () {
                return CircularProgressIndicator.adaptive();
              }),
              addVerticalSpacing(16),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                runSpacing: 16,
                children: [
                  // defaultBoard(title: "Job Boards", assetPath: mockImages.first),
                  // addHorizontalSpacing(24),

                  savedServices.when(
                    data: (values) {
                      if (values == null || values.isEmpty)
                        return SizedBox.shrink();
                      final banners = values.first.banner;
                      String coverImage = '';
                      if (banners.isNotEmpty) {
                        coverImage = banners.first.thumbnail ?? '';
                      }
                      return defaultBoard(
                        title: "Service Boards",
                        thumbnail: coverImage,
                        assetPath: mockImages[1],
                        onTap: () {
                          navigateToRoute(context, SavedServicesWrapper());
                        },
                      );
                    },
                    error: (err, stackTrace) {
                      return SizedBox.shrink();
                    },
                    loading: () {
                      return defaultBoard(
                        title: "Service Boards",
                        thumbnail: '',
                        assetPath: mockImages[1],
                        onTap: () {},
                      );
                    },
                  ),

                  hiddenPosts.when(
                    data: (values) {
                      if (values == null || values.isEmpty)
                        return SizedBox.shrink();

                      return defaultBoard(
                        title: "Hidden Boards",
                        thumbnail: '${firstPostThumbnailOrNull(values)}',
                        assetPath: mockImages.first,
                        onTap: () {
                          navigateToRoute(
                              context,
                              ExploreV2(
                                title: 'Hidden Posts',
                                providerType: BoardProvider.hidden,
                              ));
                        },
                      );
                    },
                    error: (err, stackTrace) {
                      return SizedBox.shrink();
                    },
                    loading: () {
                      return defaultBoard(
                        title: "Hidden Boards",
                        thumbnail: '',
                        assetPath: mockImages[1],
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
              addVerticalSpacing(55)
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultBoard({
    required String title,
    required String thumbnail,
    required String assetPath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: context.textTheme.displayMedium!.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          addVerticalSpacing(10),
          RoundedSquareAvatar(
            url: thumbnail,
            thumbnail: thumbnail,
            size: UploadAspectRatio.portrait.sizeFromX(43.w),
            errorWidget: ColoredBox(
              color: VmodelColors.jobDetailGrey.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
