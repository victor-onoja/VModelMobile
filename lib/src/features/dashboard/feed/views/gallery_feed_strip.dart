import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/new_profile/model/gallery_model.dart';
import 'package:vmodel/src/res/res.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../shared/loader/full_screen_dialog_loader.dart';
import '../../../../vmodel.dart';
import '../../../create_posts/models/post_set_model.dart';
import '../../new_profile/controller/gallery_controller.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../controller/feed_controller.dart';
import '../controller/feed_strip_depth.dart';
import '../controller/new_feed_provider.dart';
import '../widgets/feed_end.dart';
import '../widgets/user_post.dart';

class GotoIndexFeed extends ConsumerStatefulWidget {
  const GotoIndexFeed({
    Key? key,
    required this.data,
    required this.index,
    this.navigationDepth = 0,
    required this.username,
    required this.profilePictureUrl,
    required this.profileThumbnailUrl,
    // required this.postTime,
  }) : super(key: key);

  final int index;
  final int navigationDepth;
  final String username;
  final String profilePictureUrl;
  final String profileThumbnailUrl;
  final GalleryModel data;
  // final String postTime;

  @override
  ConsumerState<GotoIndexFeed> createState() => _MyFeedState();
}

class _MyFeedState extends ConsumerState<GotoIndexFeed> {
  List<AlbumPostSetModel> top = [];
  List<AlbumPostSetModel> bottom = [];
  //Todo remove dependency on getx
  final homeCtrl = Get.put<HomeController>(HomeController());
  final GlobalKey<SliverAnimatedListState> _topListKey =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<SliverAnimatedListState> _bottomListKey =
      GlobalKey<SliverAnimatedListState>();
  final List<int> _bottomRemovedIndices = [];

  @override
  void initState() {
    super.initState();
    top = widget.data.postSets.sublist(0, widget.index);
    bottom =
        widget.data.postSets.sublist(widget.index, widget.data.postSets.length);

    // bottom = widget.data!['bottom'];
    top = top.reversed.toList();
    print(
        '=======Total ${widget.data.postSets.length}, index: ${widget.index}, top: ${top.length}, bottom: ${bottom.length}');
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(appUserProvider);
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final navDepth = ref.watch(feedNavigationDepthProvider);
    final isPinchToZoom = ref.watch(isPinchToZoomProvider);

    const Key centerKey = ValueKey('second-sliver-list');
    return SafeArea(
      child: CustomScrollView(
        physics: isPinchToZoom
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
        // center: _bottomListKey,
        anchor: top.isEmpty ? 0 : 0.07,
        center: centerKey,
        slivers: <Widget>[
          // _listWidget(centerKey, currentUser),
          if (top.isNotEmpty) _sliverList(top, null, currentUser, navDepth),
          _sliverList(bottom, centerKey, currentUser, navDepth),
          SliverToBoxAdapter(
              child: FeedEndWidget(
            mainText: currentUser?.username == widget.username
                ? VMString.currentUserFeedEndMainText
                : VMString.otherUserFeedEndMainText,
            subText: currentUser?.username == widget.username
                ? VMString.currentUserFeedEndSubText
                : null,
          )),
        ],
      ),
    );
  }

  SliverList _sliverList(List<AlbumPostSetModel> items, Key? centerKey,
      VAppUser? currentUser, int depth) {
    return SliverList(
      key: centerKey,
      delegate: SliverChildBuilderDelegate(childCount: items.length,
          (BuildContext context, int index) {
        // print("[hero] ${items[index].photos.first.id}");
        return UserPost(
            // postData: items[index],
            date: items[index].createdAt,
            isOwnPost: currentUser?.username == widget.username,
            username: widget.username,
            isVerified: items[index].user.isVerified,
            blueTickVerified: items[index].user.blueTickVerified,
            // displayName: '${items[index].user.displayName}',
            caption: items[index].caption ?? '',
            homeCtrl: homeCtrl,
            postTime: items[index].createdAt.getSimpleDate(),
            aspectRatio: items[index].aspectRatio,
            imageList: items[index].photos,
            postLocation: items[index].locationInfo,
            //! Dummy userTagList
            userTagList: items[index].tagged,
            postId: items[index].id,
            smallImageAsset: widget.profilePictureUrl,
            smallImageThumbnail: widget.profilePictureUrl,
            isLiked: items[index].userLiked,
            likesCount: items[index].likes,
            isSaved: items[index].userSaved,
            service: items[index].service,
            onLike: () async {
              final success = await ref
                  .read(galleryProvider(widget.username).notifier)
                  .onLikePost(
                      galleryId: widget.data.id, postId: items[index].id);
              return success;
            },
            onSave: () async {
              final success = await ref
                  .read(galleryProvider(currentUser?.username == widget.username
                          ? null
                          : widget.username)
                      .notifier)
                  .onSavePost(
                      galleryId: widget.data.id,
                      postId: items[index].id,
                      currentValue: items[index].userSaved);

              if (success) {
                items[index] =
                    items[index].copyWith(userSaved: !items[index].userSaved);
              }
              return success;
            },
            onUsernameTap: () {
              // ref.read(showCurrentUserProfileFeedProvider.notifier).state =
              //     false;
              _onFeaturedUserTap(widget.username, depth: depth);
            },
            onTaggedUserTap: (value) => _onFeaturedUserTap(value, depth: depth),
            onDeletePost: () async {
              // int indexOfItem = items.indexOf(items[index]);
              // _bottomRemovedIndices.add(index);
              print(
                  '[${items.length}]DEleting item at index: $index indx at items: $index');
              // return;
              VLoader.changeLoadingState(true);
              final isSuccess = await ref
                  .read(galleryProvider(null).notifier)
                  .deletePost(postId: items[index].id);
              VLoader.changeLoadingState(false);
              if (isSuccess && context.mounted) {
                items.removeAt(index);
                goBack(context);
                setState(() {});
              }
            });

        // return Container(
        //   alignment: Alignment.center,
        //   color: bottom[index].color,
        //   height: 250,
        //   child: Text('Bottom Item: ${bottom[index].index}'),
        // );
      }),
    );
  }

  SliverAnimatedList _listWidget(
      Key centerKey, VAppUser? currentUser, int depth) {
    return SliverAnimatedList(
      // key: _bottomListKey,
      key: centerKey,
      initialItemCount: bottom.length,
      itemBuilder: (context, index, animation) {
        print('[${bottom.length}] bottom builder index: $index');
        final itemIndex = index;
        // if (_bottomRemovedIndices.contains(index)) {
        //   return SizedBox.shrink();
        // }
        return SizeTransition(
          sizeFactor: animation,
          child: UserPost(
            date: bottom[index].createdAt,
            key: ValueKey(bottom[index].id),
            isOwnPost: currentUser?.username == widget.username,
            // displayName: '${widget.username} UPdate thisss!',
            username: widget.username,
            isVerified: bottom[index].user.isVerified,
            blueTickVerified: bottom[index].user.blueTickVerified,
            caption: bottom[index].caption ?? '',
            postTime: bottom[index].createdAt.getSimpleDate(),
            homeCtrl: homeCtrl,
            aspectRatio: bottom[index].aspectRatio,
            imageList: bottom[index].photos,
            postLocation: bottom[index].locationInfo,
            postId: bottom[index].id,
            userTagList: bottom[index].tagged,
            smallImageAsset: widget.profilePictureUrl,
            smallImageThumbnail: widget.profileThumbnailUrl,
            isLiked: bottom[index].userLiked,
            isSaved: bottom[index].userSaved,
            service: bottom[index].service,
            onLike: () async {
              final success = await ref
                  .read(galleryProvider(widget.username).notifier)
                  .onLikePost(
                      galleryId: widget.data.id, postId: bottom[index].id);
              return success;
            },
            onSave: () async {
              return await ref
                  .read(galleryProvider(widget.username).notifier)
                  .onSavePost(
                      galleryId: widget.data.id,
                      postId: bottom[index].id,
                      currentValue: bottom[index].userSaved);
            },
            onUsernameTap: () =>
                _onFeaturedUserTap(widget.username, depth: depth),
            onTaggedUserTap: (value) => _onFeaturedUserTap(value, depth: depth),
            onDeletePost: () async {
              int indexOfItem = bottom.indexOf(bottom[index]);
              _bottomRemovedIndices.add(index);
              print(
                  '[${bottom.length}]DEleting item at index: $itemIndex indx at bottom: $indexOfItem');
              // return;
              VLoader.changeLoadingState(true);
              final isSuccess = await ref
                  .read(galleryProvider(null).notifier)
                  .deletePost(postId: bottom[index].id);
              VLoader.changeLoadingState(false);
              if (isSuccess && context.mounted) {
                bottom.removeAt(index);
                goBack(context);
                setState(() {});
                // bottom.removeAt(index);
                // _bottomListKey.currentState!.removeItem(
                //   index,
                //   (context, animation) => SizeTransition(
                //       sizeFactor: animation,
                //       child: SizeTransition(
                //         sizeFactor: animation,
                //         child: UserPost(
                //           key: ValueKey(bottom[index].id),
                //           isOwnPost:
                //               currentUser?.username == widget.username,
                //           username: widget.username,
                //           postTime:
                //               bottom[index].createdAt.getSimpleDate(),
                //           homeCtrl: homeCtrl,
                //           aspectRatio: bottom[index].aspectRatio,
                //           imageList: bottom[index].photos,
                //           postLocation: bottom[index].locationInfo,
                //           postId: bottom[index].id,
                //           userTagList: bottom[index].tagged,
                //           smallImageAsset: widget.profilePictureUrl,
                //           isLiked: bottom[index].userLiked,
                //           isSaved: bottom[index].userSaved,
                //           onLike: () async {
                //             return false;
                //           },
                //           onUsernameTap: () {},
                //           onTaggedUserTap: _onFeaturedUserTap,
                //         ),
                //       )),
                // );
              }
            },
          ),
        );
      },
    );
  }

  void _onFeaturedUserTap(String username, {required int depth}) {
    if (widget.username == username && depth == 0) {
      ref.read(showCurrentUserProfileFeedProvider.notifier).state = false;
    } else if (widget.username == username && depth > 0) {
      goBack(context);
    } else {
      ref.read(feedNavigationDepthProvider.notifier).increment();
      navigateToRoute(context, OtherProfileRouter(username: username));
    }
  }
}
