import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/res/res.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/utils/debounce.dart';
import '../../../../../../shared/loader/full_screen_dialog_loader.dart';
import '../../../../../../vmodel.dart';
import '../../../../feed/controller/feed_controller.dart';
import '../../../../feed/controller/new_feed_provider.dart';
import '../../../../feed/model/feed_model.dart';
import '../../../../feed/views/feed_bottom_widget.dart';
import '../../../../feed/widgets/feed_end.dart';
import '../../../../feed/widgets/user_post.dart';
import '../../../../new_profile/views/other_profile_router.dart';
import '../../../controllers/hash_tag_search_controller.dart';
import '../../../controllers/indexed_feed_posts_controller.dart';

class HashtagIndexFeed extends ConsumerStatefulWidget {
  const HashtagIndexFeed({
    Key? key,
    // required this.data,
    required this.index,
    this.navigationDepth = 0,
    required this.username,
    required this.profilePictureUrl,
    required this.profileThumbnailUrl,
    required this.indexedFeedType,
    required this.onLoadMore,
    required this.canLoadMore,
    // required this.postTime,
  }) : super(key: key);

  final int index;
  final int navigationDepth;
  final String username;
  final String profilePictureUrl;
  final String profileThumbnailUrl;
  final IndexedFeedType indexedFeedType;

  // final AsyncValue<List<FeedPostSetModel>> data;
  final VoidCallback onLoadMore;
  final bool canLoadMore;
  // final String postTime;

  @override
  ConsumerState<HashtagIndexFeed> createState() => _MyFeedState();
}

class _MyFeedState extends ConsumerState<HashtagIndexFeed> {
  // List<FeedPostSetModel> top = [];
  // List<FeedPostSetModel> bottom = [];
  //Todo remove dependency on getx
  final homeCtrl = Get.put<HomeController>(HomeController());
  final GlobalKey<SliverAnimatedListState> _topListKey =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<SliverAnimatedListState> _bottomListKey =
      GlobalKey<SliverAnimatedListState>();
  final List<int> _bottomRemovedIndices = [];
  final _scrollController = ScrollController();
  final Debounce _debounce = Debounce();

  @override
  void initState() {
    super.initState();
    // top = widget.data.value!.sublist(0, widget.index);
    // bottom =
    // widget.data.value!.sublist(widget.index, widget.data.value!.length);

    // bottom = widget.data!['bottom'];
    // top = top.reversed.toList();
    // print(
    //     '=======Total ${widget.data.value!.length}, index: ${widget.index}, top: ${top.length}, bottom: ${bottom.length}');
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        // ref.read(mainFeedProvider.notifier).fetchMoreHandler();
        _debounce(() {
          widget.onLoadMore();
        });
      }
    });
  }

  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('<<<<<<<<<<<<<<<<<<<<<<<<<< indexed feed widget.index ${widget.index}');
    // final user = ref.watch(appUserProvider);

    final tappedIndex = ref.watch(tappedPostIndexProvider);
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final isPinchToZoom = ref.watch(isPinchToZoomProvider);
    final indexedPosts =
        ref.watch(indexedFeedPostsProvider(IndexedFeedType.hashtag));
    const Key centerKey = ValueKey('second-sliver-list');
    return SafeArea(
      child: indexedPosts.maybeWhen(
        data: (values) {
          var top = values.sublist(0, tappedIndex);
          final bottom = values.sublist(tappedIndex, values.length);
          top = top.reversed.toList();

          return CustomScrollView(
            controller: _scrollController,
            physics: isPinchToZoom
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
            // center: _bottomListKey,
            anchor: top.isEmpty ? 0 : 0.07,
            center: centerKey,
            slivers: <Widget>[
              // _listWidget(centerKey, currentUser),
              if (top.isNotEmpty) _sliverList(top, null, currentUser),
              _sliverList(bottom, centerKey, currentUser),
              SliverToBoxAdapter(
                child: FeedAfterWidget(canLoadMore: widget.canLoadMore),

                //     FeedEndWidget(
                //   mainText: currentUser?.username == widget.username
                //       ? VMString.currentUserFeedEndMainText
                //       : VMString.otherUserFeedEndMainText,
                //   subText: currentUser?.username == widget.username
                //       ? VMString.currentUserFeedEndSubText
                //       : null,
                // ),
              ),
            ],
          );
        },
        orElse: () => Center(
          child: Text('Erroe'),
        ),
      ),
    );
  }

  SliverList _sliverList(
      List<FeedPostSetModel> items, Key? centerKey, VAppUser? currentUser) {
    return SliverList(
      key: centerKey,
      delegate: SliverChildBuilderDelegate(childCount: items.length,
          (BuildContext context, int index) {
        // print("[hero] ${items[index].photos.first.id}");
        return UserPost(
            // postData: items[index],
            date: items[index].createdAt,
            isOwnPost: currentUser?.username == widget.username,
            username: items[index].postedBy.username,
            isVerified: items[index].postedBy.isVerified,
            blueTickVerified: items[index].postedBy.blueTickVerified,
            // displayName: '${items[index].user.displayName}',
            caption: items[index].caption ?? '',
            homeCtrl: homeCtrl,
            postTime: items[index].createdAt.getSimpleDate(),
            aspectRatio: items[index].aspectRatio,
            imageList: items[index].photos,
            postLocation: items[index].locationInfo,
            //! Dummy userTagList
            userTagList: items[index].taggedUsers,
            postId: items[index].id,
            smallImageAsset: '${items[index].postedBy.profilePictureUrl}',
            smallImageThumbnail: '${items[index].postedBy.thumbnailUrl}',
            isLiked: items[index].userLiked,
            isSaved: items[index].userSaved,
            service: items[index].service,
            onLike: () async {
              // final success = await ref
              //     .read(galleryProvider(widget.username).notifier)
              //     .onLikePost(
              //         galleryId: widget.data.id, postId: items[index].id);
              // return success;
              return false;
            },
            onSave: () async {
              // final success = await ref
              //     .read(galleryProvider(currentUser?.username == widget.username
              //             ? null
              //             : widget.username)
              //         .notifier)
              //     .onSavePost(
              //         galleryId: widget.data.id,
              //         postId: items[index].id,
              //         currentValue: items[index].userSaved);

              // if (success) {
              //   items[index] =
              //       items[index].copyWith(userSaved: !items[index].userSaved);
              // }
              // return success;
              return false;
            },
            onUsernameTap: () {
              // ref.read(showCurrentUserProfileFeedProvider.notifier).state =
              //     false;
              _onFeaturedUserTap(items[index].postedBy.username);
            },
            onTaggedUserTap: (value) => _onFeaturedUserTap(value),
            onDeletePost: () async {
              // int indexOfItem = items.indexOf(items[index]);
              // _bottomRemovedIndices.add(index);
              print(
                  '[${items.length}]DEleting item at index: $index indx at items: $index');
              // return;
              VLoader.changeLoadingState(true);
              final isSuccess = false;
              // final isSuccess = await ref
              //     .read(galleryProvider(null).notifier)
              //     .deletePost(postId: items[index].id);
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

  void _onFeaturedUserTap(String username) {
    // if (widget.username == username) {
    //   // ref.read(showCurrentUserProfileFeedProvider.notifier).state = false;
    // } else if (widget.username == username) {
    //   goBack(context);
    // } else {
    //   navigateToRoute(context, OtherProfileRouter(username: username));
    // }
    navigateToRoute(context, OtherProfileRouter(username: username));
  }
}
