import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_provider.dart';
import 'package:vmodel/src/features/saved/views/saved_user_post.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_history_main.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class SavedGalleryFeedViewHomepage extends ConsumerStatefulWidget {
  final List postId;
  final List username;
  final bool isLiked;
  final bool isSaved;
  final List aspectRatio;
  final int feedlength;
  final List profilePictureUrl;
  // final List imageList;
  final List imageList;
  final List smallImageAsset;

  const SavedGalleryFeedViewHomepage(
      {Key? key,
      required this.username,
      required this.postId,
      this.isLiked = false,
      required this.isSaved,
      required this.aspectRatio,
      required this.imageList,
      required this.feedlength,
      required this.profilePictureUrl,
      required this.smallImageAsset})
      : super(key: key);

  @override
  ConsumerState<SavedGalleryFeedViewHomepage> createState() =>
      _SavedGalleryFeedViewHomepageState();
}

class _SavedGalleryFeedViewHomepageState
    extends ConsumerState<SavedGalleryFeedViewHomepage> {
  final homeCtrl = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    ref.watch(feedProvider);
    final fProvider = ref.watch(feedProvider.notifier);
    final isPictureOnlyView = ref.watch(isPictureViewProvider);

    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Feed",
        leadingWidth: 150,
        leadingIcon: Padding(
          padding: const EdgeInsets.only(top: 0, left: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  fProvider.isFeedPage();
                },
                child: RenderSvg(
                  svgPath: VIcons.verticalPostIcon,
                  color: fProvider.isFeed
                      ? null
                      : VmodelColors.disabledButonColor.withOpacity(0.15),
                ),
              ),
              addHorizontalSpacing(15),
              GestureDetector(
                onTap: () {
                  fProvider.isFeedPage();
                },
                child: SvgPicture.asset(
                  VIcons.horizontalPostIcon,
                  color: fProvider.isFeed
                      ? VmodelColors.disabledButonColor.withOpacity(0.15)
                      : null,
                ),
              ),
            ],
          ),
        ),
        trailingIcon: [
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // fProvider.isPictureViewState();
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
                          color:
                              VmodelColors.disabledButonColor.withOpacity(0.15),
                        ),
                ),
                addHorizontalSpacing(15),
                GestureDetector(
                  onTap: () {
                    navigateToRoute(context, const NotificationMain());
                  },
                  child: const RenderSvg(
                    svgPath: VIcons.notification,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body:
          // fProvider.isPictureView
          //     ? galleries.maybeWhen(
          //         data: (data) {
          //           final value = data
          //               .firstWhere((element) => element.id == widget.galleryId);
          //           return SafeArea(
          //             child: ListView.separated(
          //               padding: const EdgeInsets.only(bottom: 20),
          //               physics: const BouncingScrollPhysics(),
          //               itemCount: value.post.length,
          //               itemBuilder: (context, index) {
          //                 return PictureOnlyPost(
          //                   isSaved: widget.isSaved,
          //                   aspectRatio: value.post[index].aspectRatio,
          //                   imageList: value.post[index].photos,
          //                   // homeCtrl: homeCtrl,
          //                 );
          //               },
          //               separatorBuilder: (context, index) {
          //                 return const SizedBox.shrink();
          //               },
          //             ),
          //           );
          //         },
          //         orElse: () => const Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       )
          //     :
          SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const BouncingScrollPhysics(),
          itemCount: widget.feedlength,
          itemBuilder: (context, index) {
            var aspectRatioString = widget.aspectRatio[index];
            UploadAspectRatio aspectRatio = aspectRatioString == 'pro'
                ? UploadAspectRatio.pro
                : aspectRatioString == 'square'
                    ? UploadAspectRatio.square
                    : aspectRatioString == 'wide'
                        ? UploadAspectRatio.wide
                        : UploadAspectRatio.portrait;
            return SavedUserPost(
              username: widget.username[index],
              homeCtrl: homeCtrl,
              isSaved: widget.isSaved,
              aspectRatio: aspectRatio,
              imageList: widget.imageList[index],
              smallImageAsset: widget.profilePictureUrl[index] ??
                  widget.imageList[index].first['imageLink'],
              smallImageAssetThumbnail: widget.profilePictureUrl[index] ??
                  widget.imageList[index].first['imageLink'],
              postId: int.parse(widget.postId[index]),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
