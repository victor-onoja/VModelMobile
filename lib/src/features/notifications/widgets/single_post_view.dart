import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/gallery_feed_view_image_widget.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/user_post.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../dashboard/feed/controller/new_feed_provider.dart';
import '../../dashboard/feed/model/feed_model.dart';

class SinglePostView extends ConsumerStatefulWidget {
  final bool isCurrentUser;
  final FeedPostSetModel postSet;

  const SinglePostView({
    super.key,
    required this.isCurrentUser,
    required this.postSet,
  });

  @override
  ConsumerState<SinglePostView> createState() => _SinglePostViewState();
}

class _SinglePostViewState extends ConsumerState<SinglePostView> {
  final homeCtrl = Get.put<HomeController>(HomeController());
  bool isPictureView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: 'Post',
        // leadingWidth: 40,
        leadingIcon: const VWidgetsBackButton(),
        trailingIcon: [
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    isPictureView = !isPictureView;
                    setState(() {});
                  },
                  child: isPictureView
                      ? const RenderSvg(
                          svgPath: VIcons.videoFilmIcon,
                        )
                      : RenderSvg(
                          svgPath: VIcons.videoFilmIcon,
                          color:
                              VmodelColors.disabledButonColor.withOpacity(0.15),
                        ),
                ),
                addHorizontalSpacing(2),
              ],
            ),
          )
        ],
      ),
      body: isPictureView
          ? SafeArea(
              child: SingleChildScrollView(
              child: PictureOnlyPost(
                // isSaved: false,
                aspectRatio: widget.postSet.aspectRatio,
                imageList: widget.postSet.photos,
              ),
            ))
          : SafeArea(
              child: SingleChildScrollView(
              child: UserPost(
                postData: widget.postSet,
                username: widget.postSet.postedBy.username,
                caption: widget.postSet.caption ?? '',
                // displayName: widget.postSet.postedBy.displayName,
                isVerified: widget.postSet.postedBy.isVerified,
                blueTickVerified: widget.postSet.postedBy.blueTickVerified,
                homeCtrl: homeCtrl,
                aspectRatio: widget.postSet.aspectRatio,
                imageList: widget.postSet.photos,
                smallImageAsset:
                    widget.postSet.postedBy.profilePictureUrl ?? '',
                smallImageThumbnail: widget.postSet.postedBy.thumbnailUrl ?? '',
                isLiked: widget.postSet.userLiked,
                isSaved: widget.postSet.userSaved,
                service: widget.postSet.service,
                onLike: () async {
                  final result = await ref
                      .read(mainFeedProvider.notifier)
                      .onLikePost(postId: widget.postSet.id);

                  return result;
                },
                onSave: () async {
                  return await ref.read(mainFeedProvider.notifier).onSavePost(
                      postId: widget.postSet.id,
                      currentValue: widget.postSet.userSaved);
                },
                onUsernameTap: () {
                  goBack(context);
                },
                isOwnPost: false,
                onTaggedUserTap: (String value) {},
                postTime: widget.postSet.createdAt.getSimpleDate(),
                userTagList: widget.postSet.taggedUsers,
              ),
            )),
    );
  }
}
