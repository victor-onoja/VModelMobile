import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/create_posts/models/post_set_model.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/views/gallery_feed_view_homepage.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../shared/empty_page/empty_page.dart';
import '../../../create_posts/models/photo_post_model.dart';
import '../model/gallery_model.dart';
import 'gallery_album_tile.dart';

class Gallery extends ConsumerStatefulWidget {
  const Gallery({
    super.key,
    required this.albumID,
    required this.userProfilePictureUrl,
    required this.userProfileThumbnailUrl,
    required this.username,
    required this.isSaved,
    required this.photos,
    required this.gallery,
    this.isCurrentUser = false,
  });

  final String albumID;
  final bool isSaved;
  final String userProfilePictureUrl;
  final String userProfileThumbnailUrl;
  final String username;
  final bool isCurrentUser;
  final List<AlbumPostSetModel> photos;
  final GalleryModel gallery;

  @override
  ConsumerState<Gallery> createState() => _GalleryState();
}

class _GalleryState extends ConsumerState<Gallery> {
  final homeCtrl = Get.put<HomeController>(HomeController());

  // @override
  // void initState() {
  // final photoSet = ref.watch(postSetProvider(widget.albumID));
  // }

  @override
  Widget build(BuildContext context) {
    // ;
    return Scaffold(
      body: widget.photos.isEmpty
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: UploadAspectRatio.portrait.ratio,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: widget.gallery.postSets.length,
                  itemBuilder: (context, index) {
                    cachePath(widget.gallery.postSets[index].photos.first.url);
                    return OpenContainer(
                      closedShape: const RoundedRectangleBorder(),
                      closedBuilder:
                          (BuildContext context, void Function() action) {
                        return GalleryAlbumTile(
                          postId: '${widget.gallery.postSets[index].id}',
                          photos: widget.gallery.postSets[index].photos,
                          isCurrentUser: widget.isCurrentUser,
                          onLongPress: () {
                            print("onTile");
                          },
                          // onTap: null,
                          //  () {
                          // ref.read(selectedGalleryPostIndexProvider.notifier).state =
                          //     index;
                          // return GalleryFeedViewHomepage(
                          //     // isSaved: widget.isSaved,
                          //     // items: e.photos,
                          //     isCurrentUser: widget.isCurrentUser,
                          //     // postTime: widget.gallery,
                          //     galleryId: widget.albumID,
                          //     galleryName: widget.gallery.name,
                          //     username: widget.username,
                          //     profilePictureUrl:
                          //         widget.userProfilePictureUrl,
                          //     tappedIndex: index);
                          // },
                        );
                      },
                      openBuilder: (BuildContext context,
                          void Function({Object? returnValue}) action) {
                        return GalleryFeedViewHomepage(
                          // isSaved: widget.isSaved,
                          // items: e.photos,
                          // isCurrentUser: widget.isCurrentUser,
                          // postTime: widget.gallery,
                          galleryId: widget.albumID,
                          galleryName: widget.gallery.name,
                          username: widget.username,
                          profilePictureUrl: widget.userProfilePictureUrl,
                          profileThumbnailUrl: widget.userProfileThumbnailUrl,
                          tappedIndex: index,
                        );
                      },
                    );
                    // return Hero(
                    //   tag: ' ${widget.gallery.postSets[index].photos.first.id}',
                    //   child: GalleryAlbumTile(
                    //     photos: widget.gallery.postSets[index].photos,
                    //     onLongPress: () {},
                    //     onTap: () {
                    //       // ref.read(selectedGalleryPostIndexProvider.notifier).state =
                    //       //     index;
                    //       if (widget.isCurrentUser) {
                    //         ref.read(gallerFeedDataProvider.notifier).state =
                    //             GalleryFeedDataModel(
                    //                 galleryId: widget.albumID,
                    //                 galleryName: widget.gallery.name,
                    //                 selectedIndex: index);
                    //         ref
                    //             .read(
                    //                 showCurrentUserProfileFeedProvider.notifier)
                    //             .state = true;
                    //       } else {
                    //         print(
                    //           '[hero] ${widget.gallery.postSets[index].photos.first.id}',
                    //         );
                    //         Navigator.of(context).push(
                    //           PageRouteBuilder(
                    //             transitionDuration:
                    //                 Duration(milliseconds: 1000),
                    //             pageBuilder: (BuildContext context,
                    //                 Animation<double> animation,
                    //                 Animation<double> secondaryAnimation) {
                    //               return GalleryFeedViewHomepage(
                    //                   // isSaved: widget.isSaved,
                    //                   // items: e.photos,
                    //                   isCurrentUser: widget.isCurrentUser,
                    //                   // postTime: widget.gallery,
                    //                   galleryId: widget.albumID,
                    //                   galleryName: widget.gallery.name,
                    //                   username: widget.username,
                    //                   profilePictureUrl:
                    //                       widget.userProfilePictureUrl,
                    //                   tappedIndex: index);
                    //             },
                    //             transitionsBuilder: (BuildContext context,
                    //                 Animation<double> animation,
                    //                 Animation<double> secondaryAnimation,
                    //                 Widget child) {
                    //               return Align(
                    //                 child: FadeTransition(
                    //                   opacity: animation,
                    //                   child: child,
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         );
                    //         // Navigator.push(
                    //         //   context,
                    //         //   HeroDialogRoute(
                    //         //     builder: (context) {
                    //         //       return GalleryFeedViewHomepage(
                    //         //           // isSaved: widget.isSaved,
                    //         //           // items: e.photos,
                    //         //           isCurrentUser: widget.isCurrentUser,
                    //         //           // postTime: widget.gallery,
                    //         //           galleryId: widget.albumID,
                    //         //           galleryName: widget.gallery.name,
                    //         //           username: widget.username,
                    //         //           profilePictureUrl:
                    //         //               widget.userProfilePictureUrl,
                    //         //           tappedIndex: index);
                    //         //     },
                    //         //     fullscreenDialog: true,
                    //         //   ),
                    //         // );
                    //         // navigateToRoute(
                    //         //     context,
                    //         //     GalleryFeedViewHomepage(
                    //         //         // isSaved: widget.isSaved,
                    //         //         // items: e.photos,
                    //         //         isCurrentUser: widget.isCurrentUser,
                    //         //         // postTime: widget.gallery,
                    //         //         galleryId: widget.albumID,
                    //         //         galleryName: widget.gallery.name,
                    //         //         username: widget.username,
                    //         //         profilePictureUrl:
                    //         //             widget.userProfilePictureUrl,
                    //         //         tappedIndex: index));
                    //       }
                    //     },
                    //   ),
                    // );
                  }),
            ),

      // GridView.count(
      //     crossAxisCount: 3,
      //     childAspectRatio: 0.6,
      //     crossAxisSpacing: 1,
      //     mainAxisSpacing: 1,
      //     // cacheExtent: 2,
      //     // children: imageUrls.map(_createGridTileWidgetOriginal).toList(),
      //     children: widget.photos.map((e) {
      //       // print('Param ${e.url}');
      //       // return _createGridTileWidget(context, e.photos);
      //       return GalleryAlbumTile(
      //         photos: e.photos,
      //         onLongPress: () {},
      //         onTap: () {
      //           // navigateToRoute(
      //           //     context,
      //           //     CurrentUserFeedListview(
      //           //       // items: e.photos,
      //           //       isCurrentUser: widget.isCurrentUser,
      //           //       galleryId: widget.albumID,
      //           //       username: widget.username,
      //           //       profilePictureUrl: widget.userProfilePictureUrl,
      //           //     )
      //           //     // UserPost(
      //           //     //   username: widget.username,
      //           //     //   homeCtrl: homeCtrl,
      //           //     //   imageList: e.photos,
      //           //     //   smallImageAsset: widget.userProfilePictureUrl,
      //           //     // )
      //           //     );
      //           //! Testing new feed view of gallery photos
      //           navigateToRoute(
      //               context,
      //               GalleryFeedViewHomepage(
      //                 isSaved: widget.isSaved,
      //                 // items: e.photos,
      //                 isCurrentUser: widget.isCurrentUser,
      //                 galleryId: widget.albumID,
      //                 username: widget.username,
      //                 profilePictureUrl: widget.userProfilePictureUrl,
      //               ));
      //         },
      //       );
      //     }).toList()
      //     // : imageUrls.map(_createGridTileWidgetOriginal).toList(),
      //     // children: photoSet?.photos
      //     //         .map((e) => _createGridTileWidget(e.url))
      //     //         .toList() ?? [Text('Photo set is null')],
      //     // widget.urls.map(_createGridTileWidgetOriginal).toList(),
      //     ),
    );
  }

  Widget _createGridTileWidget(
          BuildContext context, List<PhotoPostModel> photos) =>
      Builder(
        builder: (context) => GestureDetector(
          onLongPress: () {},
          // child: Image.asset(url, fit: BoxFit.cover),
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  photos.first.url,
                  // fit: BoxFit.cover,
                  // placeholder: (context, url) => Container(
                  //   color: Colors.grey.shade300,
                  // ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: photos.length > 1
                ? const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_album_sharp,
                              color: Colors.white,
                            ),
                          ],
                        )),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      );
}
