import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:animations/animations.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/res/icons.dart';

import '../../../../../../core/utils/debounce.dart';
import '../../../../../../shared/empty_page/empty_page.dart';
import '../../../../../saved/views/saved_list_view.dart';
import '../../../../feed/model/feed_model.dart';
import '../../../../new_profile/widgets/gallery_album_tile.dart';
import '../../../controllers/hash_tag_search_controller.dart';
import '../../../controllers/indexed_feed_posts_controller.dart';
import 'hashtag_feed.dart';

class HashtagSearchGridPage extends ConsumerStatefulWidget {
  const HashtagSearchGridPage({
    super.key,
    // required this.albumID,
    // required this.userProfilePictureUrl,
    // required this.userProfileThumbnailUrl,
    // required this.username,
    // required this.isSaved,
    // required this.photos,
    // this.boardId,
    // required this.posts,
    required this.title,
    this.isCurrentUser = false,
    // this.onSetCover,
  });

  // final String albumID;
  // final bool isSaved;
  // final String userProfilePictureUrl;
  // final String userProfileThumbnailUrl;
  // final String username;
  final bool isCurrentUser;
  final String title;
  // final List<AlbumPostSetModel> photos;
  // final int? boardId;
  // final AsyncValue<List<FeedPostSetModel>> posts;
  // final Future<bool> Function()? onSetCover;

  @override
  ConsumerState<HashtagSearchGridPage> createState() =>
      _HashtagSearchGridPageState();
}

class _HashtagSearchGridPageState extends ConsumerState<HashtagSearchGridPage> {
  final homeCtrl = Get.put<HomeController>(HomeController());
  final _scrollController = ScrollController();
  late final Debounce _debounce;
  int _tappedIndex = 0;

  @override
  void initState() {
    super.initState();
    // final photoSet = ref.watch(postSetProvider(widget.albumID));
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    // final photoSet = ref.watch(postSetProvider(widget.albumID));
    _debounce.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(tappedPostIndexProvider);
    // return Scaffold(
    //   body:
    return ref
        .watch(indexedFeedPostsProvider(IndexedFeedType.hashtag))
        .maybeWhen(
          data: (values) {
            return values.isEmpty
                ? const EmptyPage(
                    svgPath: VIcons.gridIcon,
                    svgSize: 30,
                    subtitle: 'No content found')
                : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification? overscroll) {
                      overscroll!
                          .disallowIndicator(); //Don't show scroll splash/ripple effect
                      return true;
                    },
                    child: GridView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        padding: EdgeInsets.only(bottom: 250),
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: UploadAspectRatio.portrait.ratio,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                        ),
                        itemCount: values.length,
                        itemBuilder: (context, index) {
                          final item = values[index];
                          // cachePath(item.photos.first.url);
                          return OpenContainer(
                            closedShape: const RoundedRectangleBorder(),
                            closedBuilder:
                                (BuildContext context, void Function() action) {
                              return GalleryAlbumTile(
                                postId: '${item.id}',
                                photos: item.photos,
                                isCurrentUser: widget.isCurrentUser,
                                onLongPress: () {
                                  print("onTile");
                                },
                              );
                            },
                            openBuilder: (BuildContext context,
                                void Function({Object? returnValue}) action) {
                              _tappedIndex = index;
                              return HashtagListView(
                                // isSaved: widget.isSaved,
                                // items: e.photos,
                                // isCurrentUser: widget.isCurrentUser,
                                // postTime: widget.gallery,
                                // galleryId: widget.albumID,
                                // posts: widget.posts,
                                galleryName: widget.title,
                                username: '',
                                profilePictureUrl: '',
                                profileThumbnailUrl: '',
                                tappedIndex: _tappedIndex,
                                onRefresh: () async {
                                  // index = 0;
                                  _tappedIndex = 0;
                                  ref.invalidate(tappedPostIndexProvider);
                                  setState(() {});
                                  await ref.refresh(hashTagProvider.future);
                                },
                              );
                            },
                          );
                        }),
                  );
          },
          orElse: () => SizedBox.shrink(),
        );

    // widget.posts.isEmpty
    //     ? const EmptyPage(
    //         svgPath: VIcons.gridIcon,
    //         svgSize: 30,
    //         subtitle: 'No content found')
    //     : NotificationListener<OverscrollIndicatorNotification>(
    //         onNotification: (OverscrollIndicatorNotification? overscroll) {
    //           overscroll!
    //               .disallowIndicator(); //Don't show scroll splash/ripple effect
    //           return true;
    //         },
    //         child: GridView.builder(
    //             controller: _scrollController,
    //             padding: EdgeInsets.only(bottom: 250),
    //             physics: BouncingScrollPhysics(),
    //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 3,
    //               childAspectRatio: UploadAspectRatio.portrait.ratio,
    //               crossAxisSpacing: 1,
    //               mainAxisSpacing: 1,
    //             ),
    //             itemCount: widget.posts.length,
    //             itemBuilder: (context, index) {
    //               final item = widget.posts[index];
    //               // cachePath(item.photos.first.url);
    //               return OpenContainer(
    //                 closedShape: const RoundedRectangleBorder(),
    //                 closedBuilder:
    //                     (BuildContext context, void Function() action) {
    //                   return GalleryAlbumTile(
    //                     postId: '${item.id}',
    //                     photos: item.photos,
    //                     isCurrentUser: widget.isCurrentUser,
    //                     onLongPress: () {
    //                       print("onTile");
    //                     },
    //                   );
    //                 },
    //                 openBuilder: (BuildContext context,
    //                     void Function({Object? returnValue}) action) {
    //                   return SavedListView(
    //                     // isSaved: widget.isSaved,
    //                     // items: e.photos,
    //                     // isCurrentUser: widget.isCurrentUser,
    //                     // postTime: widget.gallery,
    //                     // galleryId: widget.albumID,
    //                     posts: widget.posts,
    //                     galleryName: widget.title,
    //                     username: '',
    //                     profilePictureUrl: '',
    //                     profileThumbnailUrl: '',
    //                     tappedIndex: index,
    //                   );
    //                 },
    //               );
    //             }),
    //       ),
    // );
  }

  void _scrollListener() {
    print("[jiww0] scroll listener triggered");
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // _isLoadMore = true;
      print("[jiww0] scroll listener fetch more...");
      _debounce(() {
        ref.read(hashTagProvider.notifier).fetchMoreHandler();
      });

      // if (_isLoadMore) {
      //   _pageCount++;
      // }
      setState(() {});
    }
  }
}
