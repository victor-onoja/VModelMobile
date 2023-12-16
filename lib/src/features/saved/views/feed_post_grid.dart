import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:animations/animations.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/res/icons.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../shared/empty_page/empty_page.dart';

import '../../../shared/picture_styles/pick_image_widget.dart';
import '../../dashboard/feed/model/feed_model.dart';
import '../../dashboard/new_profile/widgets/gallery_album_tile.dart';
import '../controller/provider/user_boards_controller.dart';
import 'saved_list_view.dart';

class ExplorePostGrid extends ConsumerStatefulWidget {
  const ExplorePostGrid({
    super.key,
    required this.albumID,
    required this.userProfilePictureUrl,
    required this.userProfileThumbnailUrl,
    required this.username,
    required this.isSaved,
    // required this.photos,
    this.boardId,
    required this.posts,
    this.isCurrentUser = false,
    // this.onSetCover,
  });

  final String albumID;
  final bool isSaved;
  final String userProfilePictureUrl;
  final String userProfileThumbnailUrl;
  final String username;
  final bool isCurrentUser;
  // final List<AlbumPostSetModel> photos;
  final int? boardId;
  final List<FeedPostSetModel> posts;
  // final Future<bool> Function()? onSetCover;

  @override
  ConsumerState<ExplorePostGrid> createState() => _ExplorePostGridState();
}

class _ExplorePostGridState extends ConsumerState<ExplorePostGrid> {
  final homeCtrl = Get.put<HomeController>(HomeController());

  // @override
  // void initState() {
  // final photoSet = ref.watch(postSetProvider(widget.albumID));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.posts.isEmpty
          ? const EmptyPage(
              svgPath: VIcons.gridIcon,
              svgSize: 30,

              // title: "No posts yet",
              subtitle: 'Upload media to see content here.')
          : NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification? overscroll) {
                overscroll!
                    .disallowIndicator(); //Don't show scroll splash/ripple effect
                return true;
              },
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: UploadAspectRatio.portrait.ratio,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: widget.posts.length,
                  itemBuilder: (context, index) {
                    final item = widget.posts[index];
                    cachePath(item.photos.first.url);
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
                        return SavedListView(
                          // isSaved: widget.isSaved,
                          // items: e.photos,
                          // isCurrentUser: widget.isCurrentUser,
                          // postTime: widget.gallery,
                          // galleryId: widget.albumID,
                          posts: widget.posts,
                          galleryName: "Generic name",
                          username: widget.username,
                          profilePictureUrl: widget.userProfilePictureUrl,
                          profileThumbnailUrl: widget.userProfileThumbnailUrl,
                          tappedIndex: index,
                        );
                      },
                    );
                  }),
            ),
    );
  }
}
