import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/user_post.dart';
import 'package:vmodel/src/features/saved/controller/provider/saved_provider.dart';
import 'package:vmodel/src/features/saved/views/hidden_post.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/shimmer/feedShimmerPage.dart';
import '../../dashboard/new_profile/views/other_profile_router.dart';

class SavedView extends ConsumerStatefulWidget {
  const SavedView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SavedView> createState() => _ProfileMainViewState();
}

class _ProfileMainViewState extends ConsumerState<SavedView>
    with SingleTickerProviderStateMixin {
  final homeCtrl = Get.put<HomeController>(HomeController());

  @override
  void initState() {
    TabController(length: postCategories.length, vsync: this);

    super.initState();
  }

  final postCategories = [
    'Models',
    'Photographers',
    'Pets',
    'Commercial',
  ];
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final savedPost = ref.watch(getsavedPostProvider);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          appbarTitle: "Saved Posts",
          trailingIcon: [
            IconButton(
              onPressed: () {
                navigateToRoute(context, const HiddenPosts());
              },
              icon: SvgPicture.asset(VIcons.archiveIcon,
                  color: Theme.of(context).iconTheme.color),
            ),

            // const RenderSvg(
            //   svgPath: VIcons.addCircle,
            //   color: VmodelColors.primaryColor,))
          ],
        ),
        body: savedPost.when(
          data: (data) {
            if (data!.isNotEmpty) {
              return CustomScrollView(
                slivers: [
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
                                service: data[index].service,
                                postLocation: data[index]
                                    .locationInfo, //! Dummy userTagList
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
                                  // int indexOfItem = items.indexOf(items[index]);
                                  // _bottomRemovedIndices.add(index);
                                  // return;
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
                ],
              );
            } else {
              return Center(
                child: Text("You have not saved a post"),
              );
            }
          },
          error: (error, stack) {
            return CustomErrorDialogWithScaffold(
              title: "Saved Posts",
              onTryAgain: () async => await ref.refresh(getsavedPostProvider),
            );
          },
          loading: () => FeedShimmerPage(shouldHaveAppBar: false),
        ));

    // savedPosts.when(
    //     data: (Either<CustomException, List<dynamic>> data) {
    //   return data.fold((p0) => const SizedBox.shrink(), (datum) {
    //     return galleryView(datum);
    //   });
    // }, loading: () {
    //   return const ConnectionShimmerPage();
    // }, error: (Object error, StackTrace stackTrace) {
    //   return Text(stackTrace.toString());
    // }));
  }

  // Future<void> reloadData() async {}

  // DefaultTabController galleryView(List<dynamic> p0) {
  //   final savedPosts = ref.watch(getSavedPosts);
  //   final savedPostsCategory = ref.watch(getsavedPostsCategories);
  //   return DefaultTabController(
  //       length: p0.length,
  //       child: Container());
  // }

  // Widget _buildGridView(
  //   BuildContext context,
  //   List categoryData,
  // ) {
  //   // final futureWatch = ref.watch(savePostProvider);
  //   final savedPosts = ref.watch(getSavedPosts);
  //   final value = ref.watch(getsavedPostsCategories);
  //   return RefreshIndicator.adaptive(
  //       onRefresh: () => ref.refresh(getSavedPosts.future),
  //       child: savedPosts.when(
  //           data: (Either<CustomException, List<dynamic>> data) {
  //         return data.fold((p0) => const SizedBox.shrink(), (datum) {
  //           return value.when(
  //               data: (Either<CustomException, List<dynamic>> data) {
  //             return data.fold((p0) => const SizedBox.shrink(), (p0) {
  //               return GridView.builder(
  //                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //                     mainAxisExtent: 202,
  //                     maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
  //                     crossAxisSpacing: 1,
  //                     mainAxisSpacing: 2,
  //                   ),
  //                   itemCount: categoryData.length,
  //                   itemBuilder: (BuildContext ctx, index) {
  //                     var savePosts = datum[index];
  //                     List photos = savePosts['post']['photos'];
  //                     if (savePosts['postCategory'] == categoryData[index]) {
  //                       print(categoryData[index]);
  //                       return GestureDetector(
  //                         onTap: () {
  //                           navigateToRoute(
  //                               context,
  //                               SavedGalleryFeedViewHomepage(
  //                                   username: datum
  //                                       .map((e) =>
  //                                           e['post']['user']['username'])
  //                                       .toList(),
  //                                   postId: datum.map((e) => e['id']).toList(),
  //                                   // aspectRatio: UploadAspectRatio.savedPosts['post']['aspectRatio'],
  //                                   isSaved: true,
  //                                   imageList: datum
  //                                       .map((e) => e['post']['photos'])
  //                                       .toList(),
  //                                   feedlength: datum.length,
  //                                   profilePictureUrl: datum
  //                                       .map((e) => e['post']['user']
  //                                           ['profilePictureUrl'])
  //                                       .toList(),
  //                                   aspectRatio: datum
  //                                       .map((e) => e['post']['aspectRatio'])
  //                                       .toList(),
  //                                   smallImageAsset: datum
  //                                       .map((e) => e['post']['user']
  //                                           ['profilePictureUrl'])
  //                                       .toList()));
  //                         },
  //                         child: SizedBox(
  //                           child: Image.network(photos.first['itemLink'],
  //                               fit: BoxFit.cover),
  //                         ),
  //                       );
  //                     }
  //                     return null;
  //                   });
  //             });
  //           }, error: (Object error, StackTrace stackTrace) {
  //             return const SizedBox.shrink();
  //           }, loading: () {
  //             return const SizedBox.shrink();
  //           });
  //         });
  //       }, loading: () {
  //         return const ConnectionShimmerPage();
  //       }, error: (Object error, StackTrace stackTrace) {
  //         return Text(stackTrace.toString());
  //       }));
  // }
}
