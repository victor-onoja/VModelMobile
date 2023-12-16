import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/empty_page/empty_page.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/shared/shimmer/feedShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../shared/appbar/appbar.dart';
import '../../../../dashboard/dash/controller.dart';
import '../../../../dashboard/feed/controller/feed_controller.dart';
import '../../../../dashboard/feed/controller/new_feed_provider.dart';
import '../../../../dashboard/feed/views/feed_bottom_widget.dart';
import '../../../../dashboard/feed/widgets/gallery_feed_view_image_widget.dart';
import '../../../../dashboard/feed/widgets/user_post.dart';
import '../../../../dashboard/new_profile/views/other_profile_router.dart';
import '../controllers/ml_posts_controller.dart';

final statefulWidgetProvider = Provider<RecommendedFeed>((ref) {
  // Create and return an instance of your StatefulWidget class.
  return RecommendedFeed();
});

class RecommendedFeed extends ConsumerStatefulWidget {
  const RecommendedFeed({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecommendedFeedState();
}

class _RecommendedFeedState extends ConsumerState<RecommendedFeed> {
  // RecommendedFeed({super.key});
  final homeCtrl = Get.put<HomeController>(HomeController());
  final _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        ref.read(mlFeedProvider.notifier).fetchMoreHandler();
      }
    });
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void myFunction() {
    _scrollController.animateTo(
      0.0, // Scroll to the top (position 0.0)
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the curve as needed
    );
  }

  @override
  Widget build(BuildContext context) {
    final futureWatch = ref.watch(mlFeedProvider);
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final isProView = ref.watch(isProViewProvider);
    final isPinchToZoom = ref.watch(isPinchToZoomProvider);

    return Scaffold(
      body: futureWatch.when(data: (data) {
        // if (data != null) {
        //   return Text(data['posts']['data'][0]['data']);
        // }
        return RefreshIndicator.adaptive(onRefresh: () async {
          HapticFeedback.lightImpact();
          ref.invalidate(mlFeedProvider);
        }, child: LayoutBuilder(builder: (context, constraint) {
          if (data == null) {
            return const FeedShimmerPage(
              shouldHaveAppBar: false,
            );
          }
          if (data.isEmpty) {
            return EmptyPage(
              svgPath: VIcons.documentLike,
              svgSize: 30,
              // title: 'No Posts Yet',
              subtitle: 'Network with others to see content here.',
            );
          }

          return SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics: isPinchToZoom
                  ? const NeverScrollableScrollPhysics()
                  // : const BouncingScrollPhysics(),
                  : const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
              slivers: [
                if (isProView)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: data.length, (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(data[index].userSaved);
                            },
                            child: PictureOnlyPost(
                              aspectRatio: data[index].aspectRatio,
                              imageList: data[index].photos,
                              // isSaved: data[index].userSaved,
                              // homeCtrl: homeCtrl,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                if (!isProView)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: data.length, (context, index) {
                      // ref.read(mlFeedProvider.notifier).fetchMoreHandler(index);

                      return Column(
                        children: [
                          UserPost(
                              postData: data[index],
                              date: data[index].createdAt,
                              key: ValueKey(data[index].id),
                              index: index,
                              isOwnPost: currentUser?.username ==
                                  data[index].postedBy.username,
                              postId: data[index].id,
                              postTime: data[index]
                                  .createdAt
                                  .getSimpleDate(), //"Date",
                              username: data[index].postedBy.username,
                              isVerified: data[index].postedBy.isVerified,
                              blueTickVerified:
                                  data[index].postedBy.blueTickVerified,
                              caption: data[index].caption ?? '',
                              // displayName: data[index].postedBy.displayName,
                              homeCtrl: homeCtrl,
                              userTagList: data[index].taggedUsers,
                              likesCount: data[index].likes,
                              isLiked: data[index].userLiked,
                              isSaved: data[index].userSaved,
                              aspectRatio: data[index].aspectRatio,
                              postLocation: data[index].locationInfo,
                              service: data[index].service,
                              //! Dummy userTagList
                              //  userTagList: [
                              //        VWidgetsUserTag(
                              //               profilePictureUrl:
                              //                   "https://images.unsplash.com/photo-1604514628550-37477afdf4e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3327&q=80",
                              //               onTapProfile: () {}),
                              //           VWidgetsUserTag(
                              //               profilePictureUrl:
                              //                   "https://images.unsplash.com/photo-1556347961-f9521a88cb8a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                              //               onTapProfile: () {}),
                              //           VWidgetsUserTag(
                              //               profilePictureUrl:
                              //                   "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                              //               onTapProfile: () {}),
                              //           VWidgetsUserTag(
                              //               profilePictureUrl:
                              //                   "https://images.unsplash.com/photo-1536924430914-91f9e2041b83?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1288&q=80",
                              //               onTapProfile: () {}),
                              //           VWidgetsUserTag(
                              //               profilePictureUrl:
                              //                   "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                              //               onTapProfile: () {}),
                              //     ],
                              imageList: data[index].photos,
                              smallImageAsset:
                                  '${data[index].postedBy.profilePictureUrl}',
                              smallImageThumbnail:
                                  '${data[index].postedBy.thumbnailUrl}',
                              onLike: () async {
                                return false;
                              },
                              onSave: () async {
                                return false;
                              },
                              onUsernameTap: () {
                                final posterUsername =
                                    data[index].postedBy.username;
                                if (posterUsername ==
                                    '${currentUser?.username}') {
                                  ref
                                      .read(dashTabProvider.notifier)
                                      .changeIndexState(3);
                                } else {
                                  navigateToRoute(
                                      context,
                                      OtherProfileRouter(
                                          username: posterUsername));
                                  // if (data[index].postedBy.isBusinessAccount ??
                                  //     false) {
                                  //   navigateToRoute(
                                  //       context,
                                  //       RemoteBusinessProfileBaseScreen(
                                  //           username: posterUsername));
                                  // } else {
                                  //   navigateToRoute(
                                  //       context,
                                  //       OtherUserProfile(
                                  //         username: data[index].postedBy.username,
                                  //       ));
                                  // }
                                }
                              },
                              onTaggedUserTap: (value) {
                                navigateToRoute(context,
                                    OtherProfileRouter(username: value));
                              },
                              onDeletePost: () async {}),
                        ],
                      );
                    }),
                  ),
                SliverToBoxAdapter(child: FeedAfterWidget(canLoadMore: false)),
              ],
            ),
          );
        }));

//if post list is empty
      }, error: (error, trace) {
        return CustomErrorDialogWithScaffold(
          onTryAgain: () => ref.refresh(mlFeedProvider),
          title: "Feed",
        );
      }, loading: () {
        return const FeedShimmerPage(
          shouldHaveAppBar: false,
        );
      }),
    );
  }
}
