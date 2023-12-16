import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/saved/views/saved_picture_only.dart';
import 'package:vmodel/src/features/saved/views/saved_user_post.dart';
import 'package:vmodel/src/vmodel.dart';

final getAllFeedPostStream = FutureProvider<dynamic>((ref) async {
  final feedWatch = ref.watch(feedProvider);

  // return feedWatch.getAllFeedPosts();
  await Future.delayed(const Duration(milliseconds: 800));
  return;
});

class SavedFeedHomeView extends ConsumerWidget {
  SavedFeedHomeView(
      {Key? key,
      required this.username,
      required this.postId,
      this.isLiked = false,
      required this.isSaved,
      this.likesCount = 0,
      this.aspectRatio = UploadAspectRatio.square,
      required this.imageList,
      required this.feedlength,
      required this.profilePictureUrl,
      required this.thumbnailUrl,
      required this.smallImageAsset})
      : super(key: key);

  final int postId;
  final String username;
  final int likesCount;
  final bool isLiked;
  final bool isSaved;
  final UploadAspectRatio aspectRatio;
  final int feedlength;
  final String profilePictureUrl;
  final String? thumbnailUrl;
  // final List imageList;
  final List imageList;
  final String smallImageAsset;
  final homeCtrl = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProView = ref.watch(isProViewProvider);
    // if (data != null) {
    //   return Text(data['posts']['data'][0]['data']);
    // }
    return LayoutBuilder(builder: (context, constraint) {
      return isProView
          ? SafeArea(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: feedlength,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: SavedPictureOnlyPost(
                      aspectRatio: aspectRatio,
                      imageList: imageList,
                      isSaved: true,
                      // homeCtrl: homeCtrl,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
              ),
            )
          : SafeArea(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: feedlength,
                itemBuilder: (context, index) {
                  // data[index].ph
                  return SavedUserPost(
                    postId: postId,
                    username: username,
                    homeCtrl: homeCtrl,
                    isLiked: isLiked,
                    isSaved: true,
                    aspectRatio: aspectRatio,
                    imageList: imageList,
                    smallImageAsset: profilePictureUrl,
                    smallImageAssetThumbnail: thumbnailUrl,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
              ),
            );
    });

    //  return     Column(children: [
    //                     (fProvider.isFeed)
    //                         ? Expanded(
    //                             child: ListView.separated(
    //                                 padding: const EdgeInsets.only(bottom: 20),
    //                                 physics: const BouncingScrollPhysics(),
    //                                 itemBuilder: (context, index) => UserPost(
    //                                       username: feedNames[index],
    //                                       homeCtrl: homeCtrl,
    //                                       imageList: postImages[index],
    //                                       smallImageAsset: postImages[index][0],
    //                                     ),
    //                                 separatorBuilder: (context, index) =>
    //                                     const SizedBox(
    //                                       height: 24,
    //                                     ),
    //                                 itemCount: postImages.length),
    //                           )
    //                         : const FeedExplore(),
    //                   ]),

//if post list is empty
  }
}
