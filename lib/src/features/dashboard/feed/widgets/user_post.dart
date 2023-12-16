import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/checkConnection.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/create_posts/models/photo_post_model.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/dashboard/feed/model/feed_model.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/media_options_functionality_widget.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/other_user_media_option_functionality.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/post_comment.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/user_tag_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/shared/popup_dialogs/response_dialogue.dart';

import '../../../../core/utils/enum/discover_search_tabs_enum.dart';
import '../../../settings/views/booking_settings/models/service_package_model.dart';
import '../../discover/controllers/composite_search_controller.dart';
import '../../discover/controllers/hash_tag_search_controller.dart';
import '../../discover/views/discover_user_search.dart/views/dis_search_main_screen.dart';
import 'add_to_boards_sheet_v2.dart';
import 'comment/model/comment_ui_model_temp.dart';
import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/utils/costants.dart';
import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../res/typography/textstyle.dart';
import '../../../../shared/carousel_indicators.dart';
import '../../../../shared/cupertino_modal_pop_up/cupertino_action_sheet.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../shared/username_verification.dart';
import '../../../../vmodel.dart';
import '../../../create_posts/views/edit_post.dart';
import '../../new_profile/other_user_profile/other_user_profile.dart';
import '../controller/feed_controller.dart';
import '../controller/new_feed_provider.dart';
import '../controller/post_comments_controller.dart';
import '../data/field_mock_data.dart';
import 'coment_tile_widget.dart';
import 'feed_carousel.dart';
import 'feed_row_icons.dart';
import 'post_service_banner.dart';
import 'readmore_feed_caption.dart';
import 'send.dart';
import 'share.dart';

class UserPost extends ConsumerStatefulWidget {
  const UserPost({
    Key? key,
    required this.username,
    // required this.displayName,
    this.postId = -1,
    this.isLiked = false,
    this.isSaved = false,
    this.likesCount = 0,
    this.index = 0,
    required this.postTime,
    required this.aspectRatio,
    required this.homeCtrl,
    required this.imageList,
    required this.userTagList,
    required this.smallImageAsset,
    required this.smallImageThumbnail,
    required this.onLike,
    required this.onSave,
    required this.isVerified,
    required this.blueTickVerified,
    required this.onUsernameTap,
    required this.isOwnPost,
    required this.onTaggedUserTap,
    this.postData,
    required this.caption,
    this.postLocation,
    this.onDeletePost,
    this.date,
    this.service,
  }) : super(key: key);
  final DateTime? date;
  final int postId;
  final int index;
  final String username;
  final FeedPostSetModel? postData;
  // final String displayName;
  final int likesCount;
  final bool isLiked;
  final bool isOwnPost;
  final bool isSaved;
  final bool isVerified;
  final bool blueTickVerified;
  final UploadAspectRatio aspectRatio;
  final HomeController homeCtrl;
  // final List imageList;
  final List imageList;
  //!DUmmy list creadted for usertag
  final List<VAppUser> userTagList;
  final String smallImageAsset;
  final String smallImageThumbnail;
  final String caption;
  final Future<bool> Function() onLike;
  final Future<bool> Function() onSave;
  final VoidCallback onUsernameTap;
  final String postTime;
  final String? postLocation;
  final ValueChanged<String> onTaggedUserTap;
  final VoidCallback? onDeletePost;
  final ServicePackageModel? service;

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends ConsumerState<UserPost> {
  final controller = PageController(keepPage: true);
  final showLoader = ValueNotifier(false);
  bool readMore = false;
  void showMore() {
    setState(() {
      readMore = !readMore;
    });
  }

  bool isPostLiked = false;
  void _toggleLike({bool callSetState = true}) {
    isPostLiked = !isPostLiked;
    isPostLiked ? ++_likeCount : --_likeCount;
    if (callSetState) {
      setState(() {});
    }
  }

  bool isPostSaved = false;
  Future<void> savePost() async {
    final connected = await checkConnection();

    if (connected) {
      HapticFeedback.lightImpact();

      if (isPostSaved) {
        final result = await ref
            .read(mainFeedProvider.notifier)
            .onSavePost(postId: widget.postId, currentValue: isPostSaved);
        if (result && context.mounted) {
          responseDialog(context, "Removed from boards");
          _toggleSaveState(newState: result ? !isPostSaved : isPostSaved);
        }
        // _toggleSaveState();
      } else {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return AddToBoardsSheetV2(
              postId: widget.postId,
              currentSavedValue: isPostSaved,
              onSaveToggle: (value) {
                _toggleSaveState(newState: value);
              },
              // saveBool: saveBool,
              // savePost: () {
              //   savePost();
              // },
              // showLoader: showLoader,
            );
          },
        );
      }
      /*
      responseDialog(
          context, isPostSaved ? "Removed from boards" : "Saved to boards");
      _toggleSaveState();
      final result = await ref
          .read(mainFeedProvider.notifier)
          .onSavePost(postId: widget.postId, currentValue: !isPostSaved);
      if (!result) {
        _toggleSaveState();
      }
      ref.read(showSavedProvider.notifier).state =
          !ref.read(showSavedProvider.notifier).state;
    */
    } else {
      responseDialog(context, "No connection", body: "Try again");

      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pop(context);
    }
  }

  void _toggleSaveState({bool? newState}) {
    setState(() {
      isPostSaved = newState ?? !isPostSaved;
    });
  }

  bool isUserTagPressed = false;

  void isUserTagPressedToggle() {
    HapticFeedback.lightImpact();
    setState(() {
      isUserTagPressed = !isUserTagPressed;
    });
  }

  int tapCount = 0;

  int currentIndex = 0;
  int _likeCount = 0;
  bool _isExpanded = false;
  int lastTap = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    isPostLiked = widget.isLiked;
    isPostSaved = widget.isSaved;
    _likeCount = widget.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    //! Below Scaffold is temporarily added on to column for testing purpose
    final poastComments = ref.watch(postCommentsProvider(widget.postId));
    final commentData = CommentModelForUI(
      postId: widget.postId,
      username: widget.username,
      postTime: widget.postTime,
      aspectRatio: widget.aspectRatio,
      imageList: widget.imageList as List<PhotoPostModel>,
      userTagList: widget.userTagList,
      smallImageAsset: '${widget.smallImageAsset}',
      smallImageThumbnail: '${widget.smallImageThumbnail}',
      isVerified: widget.isVerified,
      blueTickVerified: widget.blueTickVerified,
      isPostLiked: widget.isLiked,
      likesCount: widget.likesCount,
      isPostSaved: widget.isSaved,
      isOwnPost: false,
      caption: widget.caption ?? "",
    );

    final postUsernameStyle =
        Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 10,
            right: 0,
            bottom: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: widget.onUsernameTap,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // UserSmallImage(imageUrl: widget.smallImageAsset),
                      ProfilePicture(
                        url: widget.smallImageAsset,
                        headshotThumbnail: widget.smallImageThumbnail,
                        size: 35,
                        showBorder: false,
                      ),
                      addHorizontalSpacing(8),

                      Flexible(
                        child: Visibility(
                          visible: widget.postLocation == null ||
                              widget.postLocation!.isEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  //                 VerifiedUsernameWidget(
                                  //                     username: widget.username),
                                  VerifiedUsernameWidget(
                                    username: widget.username,
                                    // displayName: '${user?.displayName}',
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          // color: Theme.of(context).primaryColor.withOpacity(1),
                                        ),
                                    isVerified: widget.isVerified,
                                    blueTickVerified: widget.blueTickVerified,
                                  ),
                                ],
                              ),
                              // Text(
                              //   widget.username,
                              //   textAlign: TextAlign.center,
                              //   style: _postUsernameStyle,
                              // ),
                              addVerticalSpacing(2),
                              Text(
                                '${widget.postLocation}' ?? '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 13,
                                        color: Theme.of(context).primaryColor
                                        // .withOpacity(0.5),
                                        ),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // VerifiedUsernameWidget(username: widget.username),

                              VerifiedUsernameWidget(
                                username: widget.username,
                                // displayName: '${user?.displayName}',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      // color: Theme.of(context).primaryColor.withOpacity(1),
                                    ),
                                isVerified: widget.isVerified,
                                blueTickVerified: widget.blueTickVerified,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // _modalBuilder(context, widget.username);
                  if (widget.isOwnPost) {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                              // height: 400,
                              constraints: BoxConstraints(
                                minHeight: 200,
                              ),
                              padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                bottom: VConstants.bottomPaddingForBottomSheets,
                              ),
                              decoration: BoxDecoration(
                                // color: VmodelColors.appBarBackgroundColor,
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13),
                                ),
                              ),
                              child: VWidgetsPostMediaOptionsFunctionality(
                                postId: widget.postId,
                                postItemsLength: widget.imageList.length,
                                onDeletePost: widget.onDeletePost,
                                onEditPost: () {
                                  goBack(context);
                                  navigateToRoute(
                                      context,
                                      EditPostPage(
                                          postId: widget.postId,
                                          images: widget.imageList,
                                          caption: widget.caption,
                                          locationName: widget.postLocation,
                                          featuredUsers: widget.userTagList));
                                },
                              ));
                        });
                  } else {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            // height: 350,
                            constraints: BoxConstraints(
                              minHeight: 350,
                            ),
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                              bottom: VConstants.bottomPaddingForBottomSheets,
                            ),
                            decoration: BoxDecoration(
                              // color: VmodelColors.appBarBackgroundColor,
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                            ),
                            child:
                                VWidgetsOtherUserPostMediaOptionsFunctionality(
                              username: widget.username,
                              postId: widget.postId,
                              currentSavedValue: isPostSaved,
                              onSavedResult: (value) {},
                            ),
                          );
                        });
                  }
                },
                icon: const RenderSvg(
                  svgPath: VIcons.threeDotsIconVertical,
                  svgWidth: 14,
                  svgHeight: 14,
                ),
              ),
            ],
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final currentUser = ref.watch(appUserProvider).valueOrNull;

            final isServiceVisible = ref.watch(isServiceVisibleProvider);

            final isServiceVisibleNotifier =
                ref.read(isServiceVisibleProvider.notifier);

            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Stack(
                  children: [
                    RawGestureDetector(
                      gestures: {
                        SerialTapGestureRecognizer:
                            GestureRecognizerFactoryWithHandlers<
                                    SerialTapGestureRecognizer>(
                                () => SerialTapGestureRecognizer(),
                                (SerialTapGestureRecognizer instance) {
                          print('[x202] ');
                          instance.onSerialTapDown =
                              (SerialTapDownDetails details) async {
                            tapCount = details.count;

                            if (details.count == 3) {
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return AddToBoardsSheetV2(
                                    postId: widget.postId,
                                    currentSavedValue: isPostSaved,
                                    onSaveToggle: (value) {
                                      _toggleSaveState(newState: value);
                                    },
                                  );
                                },
                              );
                              savePost();

                              widget.onSave().then((success) {
                                //Undo like if it wasn't successfull
                                if (!success) {
                                  savePost();
                                }
                              });
                              // ref
                              //     .read(Saved.savepostProvider)
                              //     .savePost(widget.postId, saveBool)
                              //     .then((value) {
                              //   value.fold((left) {
                              //     savePost();
                              //   }, (right) {});
                              // });
                            } else if (details.count == 2) {
                              Future.delayed(const Duration(milliseconds: 150),
                                  () async {
                                if (tapCount == 2) {
                                  HapticFeedback.lightImpact();

                                  _toggleLike();
                                  widget.onLike().then((success) {
                                    //Undo like if it wasn't successfull
                                    if (!success) {
                                      _toggleLike();
                                    }
                                  });
                                }
                              });
                            }
                          };
                        })
                      },
                      child: FeedCarousel(
                        aspectRatio: widget.aspectRatio,
                        imageList: widget.imageList,
                        onPageChanged: (value, reason) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                        onTapImage: () {},
                      ),
                    ),
                    if (widget.service != null) ...[
                      if (isServiceVisible)
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 10,
                          child: PostServiceBookNowBanner(
                            service: widget.service!,
                          ),
                        ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              isServiceVisibleNotifier
                                  .setServiceVisible(!isServiceVisible);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: RenderSvg(
                                svgPath: VIcons.shopIcon,
                                svgHeight: 25,
                                svgWidth: 25,
                                color: VmodelColors.appBarBackgroundColor
                                    .withOpacity(0.7),
                              ),
                            ),
                          )),
                    ]
                  ],
                ),
                if (widget.userTagList.isNotEmpty)
                  Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          isUserTagPressedToggle();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: RenderSvg(
                            svgPath: VIcons.userTagIcon,
                            svgHeight: 28,
                            svgWidth: 28,
                            color: VmodelColors.appBarBackgroundColor,
                          ),
                        ),
                      )),
                if (isUserTagPressed)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 3),
                        decoration: BoxDecoration(
                          color: VmodelColors.white.withOpacity(0.7),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widget.userTagList.map(
                              (e) {
                                return VWidgetsUserTag(
                                    profilePictureUrl: e.profilePictureUrl,
                                    onTapProfile: () =>
                                        widget.onTaggedUserTap(e.username));
                              },
                            ).toList()),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        if (_likeCount > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(children: [
              Text('${_likeCount.pluralize('Like', pluralString: 'Likes')}')
            ]),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 3, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return FeedFirstRowIcons(
                  // isOwnPost:widget.isOwnPost,
                  postData: commentData,
                  postUsername: widget.username,
                  date: widget.date,
                  postCaption: widget.caption,
                  postId: widget.postId,
                  imageList: imagesList,
                  onLongPressed: () async {},
                  savedBool: isPostSaved,
                  saved: () async {
                    await savePost();
                  },
                  like: () {
                    print('[@@ like in UserPost');
                    HapticFeedback.lightImpact();
                    _toggleLike(callSetState: false);
                    widget.onLike().then((success) {
                      if (!success) {
                        _toggleLike();
                      }
                    });
                  },
                  likeCount: _likeCount,
                  likedBool: isPostLiked,
                );
              })),

              if (widget.imageList.length == 1)
                Expanded(child: addHorizontalSpacing(4)),

              if (widget.imageList.length > 1)
                Flexible(
                  child:
                      // ShaderMask(
                      //   shaderCallback: (rect) {
                      //     return LinearGradient(
                      //       begin: Alignment.centerLeft,
                      //       end: Alignment.centerRight,
                      //       colors: <Color>[
                      //         Theme.of(context).primaryColor,
                      //         Colors.transparent,
                      //         Colors.transparent,
                      //         Theme.of(context).primaryColor,
                      //       ],
                      //       stops: [0.0, 1.0, 0.0, 1.0],
                      //     ).createShader(
                      //         Rect.fromLTRB(0, 0, rect.width, rect.height));
                      //   },
                      //   blendMode: BlendMode.dstOut,
                      //   child:

                      VWidgetsCarouselIndicator(
                          currentIndex: currentIndex,
                          totalIndicators: widget.imageList.length,
                          height: 4.5,
                          width: 4.5,
                          radius: 8,
                          spacing: 7),
                  // ListView.builder(
                  //     itemCount: imagesList.length,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return GestureDetector(
                  //         child: Container(
                  //           width: 5.92,
                  //           height: 5.95,
                  //           margin: const EdgeInsets.symmetric(
                  //               vertical: 3.0, horizontal: 2.525),
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Theme.of(context)
                  //                 .primaryColor
                  //                 .withOpacity(
                  //                     currentIndex == index ? 1 : 0.2),
                  //           ),
                  //         ),
                  //       );
                  //     })
                  // ),
                ),

              //! NEw code Testing

              // PageView(
              //   controller: controller,
              //   children: [
              //  SmoothPageIndicator(
              //     controller: controller,
              //     count: widget.imageList.length,
              //     effect:  ScrollingDotsEffect(
              //       activeStrokeWidth: 2.6,
              //       activeDotScale: 0.4,
              //       radius: 8,
              //       spacing: 6,
              //       dotColor: VmodelColors.white.withOpacity(0.4),
              //       activeDotColor: VmodelColors.primaryColor,
              //     ),
              //   ),

              //   ],
              // ),

              // Expanded(child: addHorizontalSpacing(4)),
              FeedSecondRowIcons(
                send: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .85,
                          // minHeight: MediaQuery.of(context).size.height * .10,
                        ),
                        child: const SendWidget()),
                  );
                },
                shareFunction: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ShareWidget(
                      shareLabel: 'Share Post',
                      shareTitle: 'Samantha\'s Post',
                      shareImage: 'assets/images/doc/main-model.png',
                      shareURL: 'Vmodel.app/post/samantha-post',
                    ),
                  );
                },
                // saveAmount: "",
              )
            ],
          ),
        ),

        addVerticalSpacing(10),
        Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.caption.isNotEmpty)
                  // _formatCaption('${widget.imageList.first.description}'),
                  CaptionText(
                    onHashTag: (value) {
                      ref.read(showRecentViewProvider.notifier).state = true;
                      ref.read(searchTabProvider.notifier).state =
                          DiscoverSearchTab.hashtags.index;

                      ref.read(dashTabProvider.notifier).changeIndexState(1);
                      ref
                          .read(dashTabProvider.notifier)
                          .colorsChangeBackGround(1);
                      ref.watch(compositeSearchProvider.notifier).updateState(
                          query: value, activeTab: DiscoverSearchTab.hashtags);
                      // ref.read(hashTagSearchProvider.notifier).state = value;
                    },
                    username: widget.username,
                    onUsernameTap: widget.onUsernameTap,
                    onMentionedUsernameTap: widget.onTaggedUserTap,
                    // text: '${widget.imageList.first.description}',
                    text: widget.caption,
                  ),
                addVerticalSpacing(4),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       '${widget.postTime}',
                //       style: Theme.of(context).textTheme.displaySmall!.copyWith(
                //             fontSize: 10.sp,
                //             color:
                //                 Theme.of(context).primaryColor.withOpacity(0.3),
                //             // color: Theme.of(context).colorScheme.onSecondary
                //             // .withOpacity(0.5),
                //           ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '${poastComments.valueOrNull?.length ?? 0} Comments',
                      '${widget.postTime}',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 10.sp,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            // color: Theme.of(context).colorScheme.onSecondary
                            // .withOpacity(0.5),
                          ),
                    ),
                    if (poastComments.valueOrNull?.isNotEmpty ?? false)
                      GestureDetector(
                        onTap: () {
                          navigateToRoute(
                            context,
                            PostComments(
                              postId: widget.postId ?? -1,
                              postUsername: widget.postData!.postedBy.username,
                              date: widget.date,
                              postData: commentData,
                            ),
                            useMaterial: true,
                          );
                        },
                        child: Text(
                          '${poastComments.valueOrNull?.length.toInt().pluralize("Comment")}',
                          // '${widget.index + 1}-- ${widget.postTime}',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 10.sp,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3),
                                // color: Theme.of(context).colorScheme.onSecondary
                                // .withOpacity(0.5),
                              ),
                        ),
                      ),
                  ],
                ),
                addVerticalSpacing(16),
              ],
            ),
            // child: Text('slfjajfjdsajj'),
          ),
        ),

        poastComments.maybeWhen(
            data: (data) {
              // if (data.isEmpty) return Text('Definitely no data');
              if (data.isEmpty) return SizedBox.shrink();
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  // itemCount: data.length > 1 ? 3 : 1,
                  itemCount: data.length > 1 ? 2 : data.length,

                  itemBuilder: (context, index) {
                    return CommentTile(
                      indentLevel: 0,
                      showReplyIcon: false,
                      // replies: data[index].replyParent ?? [],
                      //Todo [comment] fix
                      replies: [],
                      // onReplyWithIdTap: (ReplyParent reply) {
                      onReplyWithIdTap: (reply) {},
                      commentModel: data[index],
                      replyTo: ([2, 5].contains(0))
                          ? null
                          : data[index].user!.username ?? "",
                      onReplyTap: () {},
                      posterImage: data[index].user!.thumbnailUrl,
                      commentator: data[index].user!.username,
                    );
                  },
                ),
              );
            },
            orElse: () => SizedBox.shrink()),

        addVerticalSpacing(16),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 18),
        //   child: ReadMoreText(
        //       'My first shoot with Jd Official. I’m so excited for the future to come! I never actually believed I would be picked when I applied, but I got in! I’m sooooooooo happy!',
        //       trimLines: 2,
        //       // colorClickableText: Colors.pink,
        //       trimMode: TrimMode.Line,
        //       trimCollapsedText: 'more',
        //       trimExpandedText: '',
        //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //           color: VmodelColors.text,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 14),
        //       lessStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
        //           color: VmodelColors.text2,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 14),
        //       moreStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
        //           color: VmodelColors.text2,
        //           fontWeight: FontWeight.w500,
        //           fontSize: 14)),
        // ),
      ],
    );
  }

  void _modalBuilder(BuildContext context, String text) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              // title: Text(''),
              // message: Text(''),
              actions: <Widget>[
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                      color: VmodelColors.white,
                      text: 'Edit',
                      onPressed: () {
                        popSheet(context);
                        _showActionSheet(context, "Samanths");
                      }),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Share',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Save',
                  onPressed: () async {
                    await savePost();
                  },
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Send',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Copy Link',
                ),
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                    color: VmodelColors.white,
                    text: 'Archive',
                  ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Add to favourites',
                ),
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                    color: VmodelColors.white,
                    text: 'Make portfolio main photo',
                  ),
                if (text == "Samanthas")
                  VCupertinoActionSheet(
                    color: VmodelColors.white,
                    text: 'Delete photo',
                    style: VmodelTypography2.kTitleRedStyle,
                  ),
              ],

              cancelButton: const VCupertinoActionSheet(
                text: 'Cancel',
              ),
            ));
  }

  void _showActionSheet(BuildContext context, String text) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <Widget>[
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'follow user',
                  onPressed: () {
                    popSheet(context);
                    _showActionSheet2(context);
                  },
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Share',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Save',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Send',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Message model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Book model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Report photo',
                  style: VmodelTypography2.kTitleRedStyle,
                ),
              ],
              cancelButton: const VCupertinoActionSheet(
                text: 'Cancel',
              ),
            ));
  }

  void _showActionSheet2(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: <Widget>[
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'unfollow user',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Share',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Save',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Send',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Message model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Book model',
                ),
                VCupertinoActionSheet(
                  color: VmodelColors.white,
                  text: 'Report photo',
                  style: VmodelTypography2.kTitleRedStyle,
                ),
              ],
              cancelButton: const VCupertinoActionSheet(
                text: 'cancel',
              ),
            ));
  }

  Widget _formatCaption(String caption) {
    if (caption.isEmpty) {
      return const SizedBox.shrink();
    }

    final tokens = caption.split(' ');

    final children = <InlineSpan>[
      TextSpan(
        recognizer: TapGestureRecognizer()..onTap = widget.onUsernameTap,
        text: "${widget.username} ",
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: VmodelColors.text,
              fontWeight: FontWeight.w600,
            ),
      ),
    ];
    final parent = AutoSizeText.rich(
      TextSpan(children: children),
      overflow: TextOverflow.visible,
      // maxLines: 3,
      maxLines: _isExpanded ? null : 3,

      // overflowReplacement: Text('hello'),
    );
    for (String token in tokens) {
      if (token.startsWith('@')) {
        final mentionedUsername = token.substring(1);
        //blue it
        children.add(
          TextSpan(
            text: "$mentionedUsername ",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigateToRoute(
                    context, OtherUserProfile(username: mentionedUsername));
              },
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: VmodelColors.text2,
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      } else if (token.startsWith('*')) {
        String textToBold = token.replaceAll('*', '');

        children.add(
          TextSpan(
            text: "$textToBold ",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // navigateToRoute(
                //     context, OtherUserProfile(username: mentionedUsername));
              },
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  // color: VmodelColors.text2,
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      } else {
        children.add(
          TextSpan(
            text: "$token ",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: VmodelColors.text,
                  fontWeight: FontWeight.w500,
                ),
          ),
        );
      }
    }

    // children.insert(0,
    //
    //   TextSpan(
    //     text: _isExpanded ? ' Less ' : "..more ",
    //     recognizer: TapGestureRecognizer()..onTap = () {
    //       setState(() {
    //         _isExpanded = !_isExpanded;
    //       });
    //   },
    //     style: Theme.of(context).textTheme.displaySmall!.copyWith(
    //       color: VmodelColors.text,
    //       fontWeight: FontWeight.w600,
    //     ),
    //   )
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        parent,
        if (caption.length > 148)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _isExpanded == false ? '...more' : 'Less',
                style: const TextStyle(
                  fontSize: 12,
                ),
                maxLines: 1,
              ),
            ),
          ),
      ],
    );

    // return
    //   ExpandableText(maxLines: 4, text: caption);
  }
}

// Future<dynamic> responseDialoge(BuildContext context, String title,
//     {String? body}) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15.0))),
//         title: Center(
//           child: Text(
//             title,
//             style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: Theme.of(context).primaryColor,
//                 ),
//           ),
//         ),
//         content: body == null
//             ? null
//             : Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Text(
//                       body,
//                       style:
//                           Theme.of(context).textTheme.displayMedium!.copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                     ),
//                   ),
//                 ],
//               ),
//       );
//     },
//   );
// }
