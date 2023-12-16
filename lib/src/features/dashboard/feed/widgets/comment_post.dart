import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/checkConnection.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/add_to_boards_sheet.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/media_options_functionality_widget.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/other_user_media_option_functionality.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/saved/views/saved_user_post.dart';
import 'package:vmodel/src/shared/popup_dialogs/response_dialogue.dart';

import 'add_to_boards_sheet_v2.dart';
import 'comment/model/comment_ui_model_temp.dart';
import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/utils/costants.dart';
import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/carousel_indicators.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../shared/username_verification.dart';
import '../../../../vmodel.dart';
import '../../../create_posts/views/edit_post.dart';
import '../controller/feed_controller.dart';
import '../controller/new_feed_provider.dart';
import '../data/field_mock_data.dart';
import 'feed_carousel.dart';
import 'feed_row_icons.dart';
import 'readmore_feed_caption.dart';
import 'send.dart';
import 'share.dart';

class CommentPost extends StatefulWidget {
  const CommentPost({
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
    // required this.onLike,
    // required this.onSave,
    required this.isVerified,
    required this.blueTickVerified,
    // required this.onUsernameTap,
    required this.isOwnPost,
    // required this.onTaggedUserTap,
    required this.caption,
    this.postLocation,
    this.onDeletePost,
    this.postData,
    this.date,
  }) : super(key: key);
  final DateTime? date;
  final int postId;
  final int index;
  final String username;
  // final String displayName;
  final CommentModelForUI? postData;
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
  // final Future<bool> Function() onLike;
  // final Future<bool> Function() onSave;
  // final VoidCallback onUsernameTap;
  final String postTime;
  final String? postLocation;
  // final ValueChanged<String> onTaggedUserTap;
  final VoidCallback? onDeletePost;

  @override
  _CommentPostState createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
  final controller = PageController(keepPage: true);
  final showLoader = ValueNotifier(false);
  bool readMore = false;
  void showMore() {
    setState(() {
      readMore = !readMore;
    });
  }

  bool likeBool = false;
  void likePost() {
    setState(() {
      likeBool = !likeBool;
    });
  }

  bool saveBool = false;
  void savePost() {
    setState(() {
      saveBool = !saveBool;
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
  bool _isExpanded = false;
  int lastTap = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    likeBool = widget.isLiked;
    saveBool = widget.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    //! Below Scaffold is temporarily added on to column for testing purpose

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
                  onTap: () {},
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
                                          fontSize: 10.sp,
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
                                        fontSize: 9.sp,
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
                                      fontSize: 10.sp,
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
                                currentSavedValue: widget.isSaved,
                                onSavedResult: (value) {},
                              ));
                        });
                  }
                },
                icon: const RenderSvg(
                  svgPath: VIcons.threeDotsIconVertical,
                  svgWidth: 4,
                  svgHeight: 4,
                ),
              ),
            ],
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final currentUser = ref.watch(appUserProvider).valueOrNull;
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                RawGestureDetector(
                  gestures: {
                    SerialTapGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<
                                SerialTapGestureRecognizer>(
                            () => SerialTapGestureRecognizer(),
                            (SerialTapGestureRecognizer instance) {
                      instance.onSerialTapDown =
                          (SerialTapDownDetails details) async {
                        tapCount = details.count;

                        if (details.count == 3) {
                          savePost();

                          // widget.onSave().then((success) {
                          //   //Undo like if it wasn't successfull
                          //   if (!success) {
                          //     savePost();
                          //   }
                          // });
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
                              setState(() {
                                likeBool = !likeBool;
                              });
                              // widget.onLike().then((success) {
                              //   //Undo like if it wasn't successfull
                              //   if (!success) {
                              //     setState(() {
                              //       likeBool = !likeBool;
                              //     });
                              //   }
                              // });
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
                    ),
                  ),
              ],
            );
          },
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
                  postData: widget.postData,
                  showCommentIcon: false,
                  postUsername: widget.username,
                  date: widget.date,
                  postCaption: widget.caption,
                  postId: widget.postId,
                  imageList: imagesList,
                  savedBool: saveBool,
                  onLongPressed: () {},
                  saved: () async {
                    if (saveBool) {
                      final result = await ref
                          .read(mainFeedProvider.notifier)
                          .onSavePost(
                              postId: widget.postId, currentValue: saveBool);
                      if (result && context.mounted)
                        responseDialog(context, "Removed from boards");
                    } else {
                      AddToBoardsSheetV2(
                        postId: widget.postId,
                        currentSavedValue: !saveBool,

                        onSaveToggle: (value) {
                          //Todo: Comment Toggle Fix
                        },
                        // saveBool: saveBool,
                        // savePost: () {
                        //   savePost();
                        // },
                        // showLoader: showLoader,
                      );
                    }
                    // HapticFeedback.lightImpact();
                    // final connected = await checkConnection();
                    // if (connected) {
                    //   HapticFeedback.lightImpact();
                    //   responseDialog(context, "Saved to boards");
                    //   savePost();
                    //   final result = await ref
                    //       .read(mainFeedProvider.notifier)
                    //       .onSavePost(
                    //           postId: widget.postId, currentValue: !saveBool);
                    //   if (!result) {
                    //     savePost();
                    //   }
                    //   ref.read(showSavedProvider.notifier).state =
                    //       !ref.read(showSavedProvider.notifier).state;
                    // } else {
                    //   responseDialog(context, "No connection",
                    //       body: "Try again");
                    // }
                    // await Future.delayed(Duration(seconds: 2));
                    // Navigator.pop(context);
                  },
                  like: () async {
                    // HapticFeedback.lightImpact();
                    // ref
                    //     .read(mainFeedProvider.notifier)
                    //     .onLikePost(postId: widget.postId)
                    //     .then((success) {
                    //   if (!success) {
                    //     setState(() {
                    //       likeBool = !likeBool;
                    //     });
                    //   }
                    // });
                    // setState(() {
                    //   likeBool = !likeBool;
                    // });
                  },
                  likeCount: widget.likesCount,
                  likedBool: likeBool,
                );
              })),
              if (widget.imageList.length == 1)
                Expanded(child: addHorizontalSpacing(4)),
              if (widget.imageList.length > 1)
                Flexible(
                  child: VWidgetsCarouselIndicator(
                    currentIndex: currentIndex,
                    totalIndicators: widget.imageList.length,
                    height: 4.5,
                    width: 4.5,
                    radius: 8,
                    spacing: 7,
                  ),
                ),
              FeedSecondRowIcons(
                showCommentIcon: false,
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
                    username: widget.username,
                    onUsernameTap: () {},
                    onMentionedUsernameTap: (val) {},
                    // text: '${widget.imageList.first.description}',
                    text: widget.caption,
                  ),
                addVerticalSpacing(4),
                Text(
                  widget.postTime,
                  // '${widget.index + 1}-- ${widget.postTime}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 10.sp,
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        // color: Theme.of(context).colorScheme.onSecondary
                        // .withOpacity(0.5),
                      ),
                ),
                addVerticalSpacing(16),
              ],
            ),
            // child: Text('slfjajfjdsajj'),
          ),
        ),
      ],
    );
  }
}
