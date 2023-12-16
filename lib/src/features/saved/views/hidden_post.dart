import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/user_post.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/features/saved/controller/provider/saved_provider.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/shared/shimmer/feedShimmerPage.dart';

import '../../../shared/buttons/normal_back_button.dart';

class HiddenPosts extends ConsumerStatefulWidget {
  const HiddenPosts({super.key});

  @override
  ConsumerState<HiddenPosts> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<HiddenPosts> {
  final homeCtrl = Get.put<HomeController>(HomeController());
  @override
  Widget build(BuildContext context) {
    final hiddenPost = ref.watch(getHiddenPostProvider);
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    return Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          appbarTitle: "Hidden Posts",
        ),
        body: hiddenPost.when(
          data: (data) {
            if (data!.isNotEmpty) {
              return CustomScrollView(slivers: [
                SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserPost(
                              postData: data[index],
                              date: data[index].createdAt,
                              key: ValueKey(data[index].id),
                              index: index,
                              isOwnPost: true,
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
                              imageList: data[index].photos,
                              service: data[index].service,
                              smallImageAsset:
                                  '${data[index].postedBy.profilePictureUrl}',
                              smallImageThumbnail:
                                  '${data[index].postedBy.thumbnailUrl}',
                              onLike: () async {
                                final result = await ref
                                    .read(mainFeedProvider.notifier)
                                    .onLikePost(postId: data[index].id);

                                return result;
                              },
                              onSave: () async {
                                return await ref
                                    .read(mainFeedProvider.notifier)
                                    .onSavePost(
                                        postId: data[index].id,
                                        currentValue: data[index].userSaved);
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
                                }
                              },
                              onTaggedUserTap: (value) {
                                if (value == currentUser?.username) {
                                  ref
                                      .read(dashTabProvider.notifier)
                                      .changeIndexState(3);
                                } else {
                                  navigateToRoute(context,
                                      OtherProfileRouter(username: value));
                                }
                              },
                              onDeletePost: () async {
                                VLoader.changeLoadingState(true);
                                final isSuccess = await ref
                                    .read(mainFeedProvider.notifier)
                                    .deletePost(postId: data[index].id);
                                VLoader.changeLoadingState(false);
                                if (isSuccess && context.mounted) {
                                  // data.removeAt(index);

                                  goBack(context);
                                  // setState(() {});
                                }
                              }),
                        ],
                      );
                    }),
              ]);
            } else {
              return Center(
                child: Text("No hidden post"),
              );
            }
          },
          error: (error, stack) {
            print("$error $stack");
            return CustomErrorDialogWithScaffold(
              title: "Hidden Posts",
              onTryAgain: () async => await ref.refresh(getHiddenPostProvider),
            );
          },
          loading: () => FeedShimmerPage(shouldHaveAppBar: false),
        ));
  }
}
