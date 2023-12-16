import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/network/urls.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/data/field_mock_data.dart';
import 'package:vmodel/src/features/dashboard/feed/views/feed_explore.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/user_post.dart';
import 'package:vmodel/src/features/saved/views/saved_posts_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/shimmer/feedShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../controller/feed_provider.dart';

class FeedHomeUI extends ConsumerWidget {
  final homeCtrl = Get.put<HomeController>(HomeController());
  FeedHomeUI({
    Key? key,
  }) : super(key: key);

  bool isLoading = VUrls.shouldLoadSomefeatures;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(feedProvider);
    final fProvider = ref.watch(feedProvider.notifier);
    final currentUser = ref.watch(appUserProvider).valueOrNull;

    List postImages = [
      feedImagesList2,
      feedImagesList1,
      feedImagesList3,
      feedImagesList4,
      feedImagesList5,
      feedImagesList6,
      feedImagesList7,
      feedImagesList8,
      feedImagesList9,
      feedImagesList10,
      feedImagesList11,
      feedImagesList12,
      feedImagesList13,
      feedImagesList14,
      feedImagesList15,
      feedImagesList16,
      feedImagesList17,
      feedImagesList18,
      feedImagesList19,
      feedImagesList20,
    ];

    Future<void> reloadData() async {}

    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: fProvider.isFeed ? "Feederos" : "Explore",
        appBarHeight: 50,
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
          SizedBox(
            // height: 30,
            width: 80,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                navigateToRoute(context, const SavedView());
              },
              icon: const RenderSvg(
                svgPath: VIcons.unsavedPostsIcon,
              ),
            ),
          ),
        ],
      ),

      // commit

      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () {HapticFeedback.lightImpact();
            return reloadData();
          },
          child: isLoading == true
              ? const FeedShimmerPage(
                  shouldHaveAppBar: false,
                )
              : Column(children: [
                  (fProvider.isFeed)
                      ? Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.only(bottom: 20),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => UserPost(
                                    // date: ,
                                    isOwnPost: currentUser?.username ==
                                        feedNames[index],
                                    postTime: "Date",
                                    caption: "",
                                    //! Dummy userTagList
                                    userTagList: const [],
                                    // userTagList: [
                                    //    VWidgetsUserTag(
                                    //           profilePictureUrl:
                                    //               "https://images.unsplash.com/photo-1604514628550-37477afdf4e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3327&q=80",
                                    //           onTapProfile: () {}),
                                    //       VWidgetsUserTag(
                                    //           profilePictureUrl:
                                    //               "https://images.unsplash.com/photo-1556347961-f9521a88cb8a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                                    //           onTapProfile: () {}),
                                    //       VWidgetsUserTag(
                                    //           profilePictureUrl:
                                    //               "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                                    //           onTapProfile: () {}),
                                    //       VWidgetsUserTag(
                                    //           profilePictureUrl:
                                    //               "https://images.unsplash.com/photo-1536924430914-91f9e2041b83?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1288&q=80",
                                    //           onTapProfile: () {}),
                                    //       VWidgetsUserTag(
                                    //           profilePictureUrl:
                                    //               "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
                                    //           onTapProfile: () {}),
                                    // ],
                                    isSaved: false,
                                    isVerified: false,
                                    blueTickVerified: false,
                                    username: feedNames[index],
                                    // displayName: feedNames[index],
                                    homeCtrl: homeCtrl,
                                    aspectRatio: UploadAspectRatio
                                        .square, // Todo: Fix this hardcoded value
                                    imageList: postImages[index],
                                    smallImageAsset: postImages[index][0],
                                    smallImageThumbnail: postImages[index][0],
                                    onLike: () async {
                                      return false;
                                    },
                                    onSave: () async {
                                      return false;
                                    },
                                    onUsernameTap: () {},
                                    onTaggedUserTap: (value) {
                                      VWidgetShowResponse.showToast(
                                        ResponseEnum.sucesss,
                                        message: '#1Tagged user $value tapped',
                                      );
                                    },
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 24,
                                  ),
                              itemCount: postImages.length),
                        )
                      : const FeedExplore(
                          issearching: false,
                        ),
                ]),
        ),
      ),
    );
  }
}
