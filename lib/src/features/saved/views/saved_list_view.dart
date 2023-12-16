import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/gallery_feed_view_image_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/gallery_controller.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/controller/app_user_controller.dart';
import '../../dashboard/feed/model/feed_model.dart';
import '../../dashboard/feed/widgets/feed_end.dart';
import 'saved_list_view_widget.dart';

class SavedListView extends ConsumerStatefulWidget {
  // final bool isCurrentUser;
  final String galleryName;
  final String username;
  // final bool isSaved;
  final String profilePictureUrl;
  final String profileThumbnailUrl;
  final int tappedIndex;
  // final String postTime;
  final List<FeedPostSetModel> posts;

  const SavedListView({
    super.key,
    // required this.isCurrentUser,
    required this.posts,
    required this.galleryName,
    // required this.isSaved,
    required this.username,
    required this.profilePictureUrl,
    required this.profileThumbnailUrl,
    required this.tappedIndex,
    // required this.postTime,
  });

  @override
  ConsumerState<SavedListView> createState() => _SavedListViewState();
}

class _SavedListViewState extends ConsumerState<SavedListView> {
  final homeCtrl = Get.put<HomeController>(HomeController());
  // late final String? galleryUsername;
  bool isCurrentUser = false;

  @override
  void initState() {
    // galleryUsername = isCurrentUser ? null : widget.username;
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    // final galleries = ref.watch(filteredGalleryListProvider(requestUsername));
    // ref.watch(feedProvider);
    // final fProvider = ref.watch(feedProvider.notifier);
    final isPictureOnlyView = ref.watch(isPictureViewProvider);

    // final setups = ref.watch(selectedGalleryPostIndexProvider);
    print('the indesx is ------))))))) ${widget.tappedIndex}');

    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: widget.galleryName,
        // leadingWidth: 150,
        leadingIcon: VWidgetsBackButton(
          onTap: () {
            if (isCurrentUser) {
              ref.read(showCurrentUserProfileFeedProvider.notifier).state =
                  false;

              //Temporal
              goBack(context);
            } else {
              goBack(context);
            }
          },
        ),
        trailingIcon: [
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // fProvider.isPictureViewState();
                    HapticFeedback.lightImpact();
                    ref.read(isPictureViewProvider.notifier).state =
                        !isPictureOnlyView;
                  },
                  // child: fProvider.isPictureView
                  child: isPictureOnlyView
                      ? const RenderSvg(
                          svgPath: VIcons.videoFilmIcon,
                        )
                      : RenderSvg(
                          svgPath: VIcons.videoFilmIcon,
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withOpacity(0.5),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(galleryProvider(requestUsername));
        },
        child: isPictureOnlyView
            ? ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: widget.posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.posts.length) {
                    return FeedEndWidget(
                      mainText:
                          //  currentUser?.username == widget.username
                          isCurrentUser
                              ? VMString.currentUserFeedEndMainText
                              : VMString.otherUserFeedEndMainText,
                      subText: isCurrentUser
                          ? VMString.currentUserFeedEndSubText
                          : null,
                    );
                  }
                  return PictureOnlyPost(
                    // isSaved: widget.isSaved,
                    aspectRatio: widget.posts[index].aspectRatio,
                    imageList: widget.posts[index].photos,

                    // homeCtrl: homeCtrl,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
              )
            : SavedGotoIndexFeed(
                data: widget.posts,
                index: widget.tappedIndex,
                username: widget.username,
                profilePictureUrl: widget.profilePictureUrl,
                profileThumbnailUrl: widget.profileThumbnailUrl,
                // postTime: widget.postTime,
              ),
      ),
    );
  }
}

                    // return EmptyPage(
                    //   svgPath: VIcons.documentLike,
                    //   svgSize: 30,
                    //   subtitle: 'Upload to this gallery to see content here.',
                    // );