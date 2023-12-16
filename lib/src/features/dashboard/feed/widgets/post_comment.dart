import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/coment_tile_widget.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/comment_post.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/notifications/widgets/date_time_extension.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import 'comment/model/comment_ui_model_temp.dart';
import '../../../../res/res.dart';
import '../../../../vmodel.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../controller/post_comment_replies_controller.dart';
import '../controller/post_comments_controller.dart';
import 'comment/comment_input_field.dart';
import 'readmore_feed_caption.dart';

class PostComments extends ConsumerStatefulWidget {
  PostComments({
    super.key,
    required this.postId,
    required this.postUsername,
    this.postCaption,
    required this.date,
    required this.postData,
    this.showReplyIcon = true,
    // required this.onLike,
    // required this.onSave,
    // required this.onUsernameTap,
    // required this.onTaggedUserTap,
    // required this.postOnUsernameTap,
    // required this.postOnTaggedUserTap,
  });
  // final Future<bool> Function() onLike;
  // final Future<bool> Function() onSave;
  // final ValueChanged<String> onTaggedUserTap;
  // final VoidCallback onUsernameTap;
  final bool showReplyIcon;
  final int postId;
  final String postUsername;
  final String? postCaption;
  final DateTime? date;
  final CommentModelForUI postData;

  @override
  ConsumerState<PostComments> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends ConsumerState<PostComments> {
  // final String postUsername;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final _showLoader = ValueNotifier(false);

  final _commentTextEditing = TextEditingController();
  final _replyTextEditing = TextEditingController();
  final tempCaption =
      "Unleash your style with our revolutionary photographer @testuser. Elevate your fashion game like never before. Use our product today and get the best out of premium #FashionForward #Fashion";
  final mockCommentMessage =
      "Assign Welcome to Gboard clipboard, @smitham any text you copy will be saved here. Touch and hold a clip to pin it . Unpinned clips will be deleted after 1 hour. Welcome to Gboard clipboard, any text you copy will be saved here.";

  final List<String> predefinedEmojis = [
    " 👏 ",
    " ❤️ ",
    " 🙌 ",
    " 😍 ",
    " 🤩 ",
    " 💯 ",
    " 🎉 ",
    " 🥰 ",
    // " 🙏 ",
    " ✅ ",
  ];
  ScrollController _scrollController = ScrollController();
  final homeCtrl = Get.put<HomeController>(HomeController());
  final _debounce = Debounce();
  late final FocusNode commentFieldNode;
  late final Random random;
  bool showSendButton = false;
  String commentator = "";

  bool _isReply = false;
  bool _showSendButton = false;
  int commentId = 0;
  int rootCommentId = 0;
  @override
  initState() {
    super.initState();
    random = Random();
    commentFieldNode = FocusNode();
    _commentTextEditing.addListener(_textChanged);
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref
              .read(postCommentsProvider(widget.postId).notifier)
              .fetchMoreData(widget.postId);
        });
      }
    });
  }

  void _textChanged() {
    setState(() {
      showSendButton = _commentTextEditing.text.isNotEmpty;
      print(showSendButton);
    });
  }

  @override
  dispose() {
    commentFieldNode.dispose();
    _scrollController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  // final rand = Random();
  @override
  Widget build(BuildContext context) {
    // print("sjioejwf${widget.postId}");
    final comments = ref.watch(postCommentsProvider(widget.postId));
    final userState = ref.watch(appUserProvider);
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final user = userState.valueOrNull;
    return Scaffold(
      appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(), appbarTitle: "Comment"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommentPost(
              postId: widget.postData.postId,
              username: widget.postUsername,
              postTime: widget.postData.postTime,
              isLiked: widget.postData.isPostLiked,
              likesCount: widget.postData.likesCount,
              isSaved: widget.postData.isPostSaved,
              aspectRatio: widget.postData.aspectRatio,
              homeCtrl: homeCtrl,
              imageList: widget.postData.imageList,
              userTagList: widget.postData.userTagList,
              smallImageAsset: '${widget.postData.smallImageAsset}',
              smallImageThumbnail: '${widget.postData.smallImageThumbnail}',

              isVerified: widget.postData.isVerified,
              blueTickVerified: widget.postData.blueTickVerified,

              isOwnPost: currentUser?.username == widget.postData.isOwnPost,
              // onTaggedUserTap: (va){},
              caption: widget.postData.caption,
            ),
            comments.when(
              data: (data) {
                if (data.isNotEmpty)
                  return RefreshIndicator.adaptive(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      HapticFeedback.lightImpact();
                      await ref.refresh(postCommentsProvider(widget.postId));
                    },
                    child: SlidableAutoCloseBehavior(
                      closeWhenOpened: true,
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: data.length + 2,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          // print(data[index].comment!.isEmpty);
                          if (index == 0)
                            // Show comments as the first item
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: CaptionText(
                                username: widget.postUsername, // postUsername,
                                onUsernameTap: () {}, // postOnUsernameTap,
                                onMentionedUsernameTap: (val) {
                                  navigateToRoute(
                                    context,
                                    OtherProfileRouter(username: val),
                                  );
                                }, // postOnTaggedUserTap,
                                // text: '${widget.imageList.first.description}',
                                text: widget.postCaption ?? '',
                              ),
                            );

                          if (index == 1)
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.length} Comments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.color
                                              ?.withOpacity(0.5),
                                          fontSize: 8.sp,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  Text(
                                    widget.date!.timeAgo(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.color
                                              ?.withOpacity(0.5),
                                          fontSize: 8.sp,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            );

                          // return Container(
                          //     height: 100,
                          //     width: double.maxFinite,
                          //     color: Colors.amber);
                          return CommentTile(
                            indentLevel: 0,
                            showReplyIcon: widget.showReplyIcon,
                            // replies: data[index - 2].replyParent ?? [],
                            //Todo [comment] fix
                            replies: [],
                            // onReplyWithIdTap: (ReplyParent reply) {
                            onReplyWithIdTap: (reply) {
                              commentFieldNode.requestFocus();
                              _isReply = true;
                              commentId = reply.idToInt;
                              rootCommentId =
                                  reply.rootParent?.idToInt ?? reply.idToInt;
                              commentator = reply.user!.username;
                              print(commentId);
                              setState(() {});
                            },
                            commentModel: data[index - 2],
                            replyTo: ([2, 5].contains(index - 2))
                                ? null
                                : data[index - 2].user!.username,
                            onReplyTap: () {
                              commentFieldNode.requestFocus();
                              _isReply = true;
                              commentId = data[index - 2].idToInt;
                              rootCommentId =
                                  data[index - 2].rootParent?.idToInt ??
                                      data[index - 2].idToInt;
                              commentator = data[index - 2].user!.username;
                              print(commentId);
                              setState(() {});
                            },
                            posterImage: data[index - 2].user!.thumbnailUrl,
                            commentator: data[index - 2].user!.username,
                          );
                        },
                        //  CommentEndWidget(widget.postId),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 4);
                        },
                      ),
                    ),
                  );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 15),
                      child: CaptionText(
                        username: widget.postUsername, // postUsername,
                        onUsernameTap: () {}, // postOnUsernameTap,
                        onMentionedUsernameTap: (val) {
                          navigateToRoute(
                            context,
                            OtherProfileRouter(username: val),
                          );
                        }, // postOnTaggedUserTap,
                        // text: '${widget.imageList.first.description}',
                        text: widget.postCaption ?? '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${data.length} Comments',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.color
                                      ?.withOpacity(0.5),
                                  fontSize: 8.sp,
                                  // fontWeight: FontWeight.w400,
                                ),
                          ),
                          Text(
                            widget.date!.getSimpleDate(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.color
                                      ?.withOpacity(0.5),
                                  fontSize: 8.sp,
                                  // fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpacing(50),
                    Center(child: Text("No comments")),
                  ],
                );
              },
              error: (error, stack) => Container(
                alignment: Alignment.center,
                child: Text(error.toString()),
              ),
              loading: () =>
                  Container(child: CircularProgressIndicator.adaptive()),
            ),
            addVerticalSpacing(200)
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addHorizontalSpacing(16),
              ProfilePicture(
                url: user!.profilePictureUrl,
                headshotThumbnail: user.thumbnailUrl,
                size: 40,
              ),
              addHorizontalSpacing(16),
              Expanded(
                child: VWidgetsCommentFieldNormal(
                  showSendButton: showSendButton,
                  controller:
                      _isReply ? _replyTextEditing : _commentTextEditing,
                  handleDoneButtonPress: !_showSendButton
                      ? () {}
                      : () async {
                          if (!_isReply) {
                            print(widget.postId);
                            if (_commentTextEditing.text.isEmpty) {
                              return;
                            }
                            FocusScope.of(context).unfocus();

                            setState(() {
                              _showLoader.value = true;
                            });
                            await ref
                                .read(postCommentsProvider(widget.postId)
                                    .notifier)
                                .savePostComments(
                                  postId: widget.postId,
                                  comment: _commentTextEditing.text.trim(),
                                );
                            _commentTextEditing.clear();
                            setState(() {
                              _showLoader.value = false;
                            });
                          } else {
                            print(commentId);
                            if (_replyTextEditing.text.isEmpty) {
                              return;
                            }
                            FocusScope.of(context).unfocus();

                            setState(() {
                              _showLoader.value = true;
                            });
                            await ref
                                .read(
                                    // postCommentsProvider(widget.postId)
                                    // commentRepliesProvider(widget.postId)
                                    commentRepliesProvider(rootCommentId)
                                        .notifier)
                                .replyComment(
                                  commentId: widget.postId,
                                  reply: _replyTextEditing.text.trim(),
                                );
                            _replyTextEditing.clear();
                            _showLoader.value = false;
                            _isReply = false;
                            // await _refreshIndicatorKey.currentState?.show();

                            setState(() {});
                          }
                        },
                  focusNode: commentFieldNode,
                  labelText: null,
                  hintText: _isReply ? "Reply" : 'Write a comment',
                  // controller: locController,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    if (value!.isNotEmpty) {
                      _showSendButton = true;
                    } else {
                      _showSendButton = false;
                    }
                    if (mounted) setState(() {});
                  },
                ),
              ),
              if (_showLoader.value) addHorizontalSpacing(10),
              ValueListenableBuilder(
                valueListenable: _showLoader,
                builder: (context, value, child) {
                  if (value) {
                    return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  if (_showSendButton)
                    return AnimatedContainer(
                      width: _showSendButton ? 60 : 0,
                      height: _showSendButton ? 30 : 0,
                      duration: Duration(milliseconds: 150),
                      padding: _showSendButton
                          ? EdgeInsets.fromLTRB(5, 0, 0, 0)
                          : EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: !_showSendButton
                            ? null
                            : () async {
                                if (!_isReply) {
                                  print(widget.postId);
                                  if (_commentTextEditing.text.isEmpty) {
                                    return;
                                  }
                                  FocusScope.of(context).unfocus();

                                  setState(() {
                                    _showLoader.value = true;
                                  });
                                  await ref
                                      .read(postCommentsProvider(widget.postId)
                                          .notifier)
                                      .savePostComments(
                                        postId: widget.postId,
                                        comment:
                                            _commentTextEditing.text.trim(),
                                      );
                                  _commentTextEditing.clear();
                                  setState(() {
                                    _showSendButton = false;
                                    _showLoader.value = false;
                                  });
                                } else {
                                  print(commentId);
                                  if (_replyTextEditing.text.isEmpty) {
                                    return;
                                  }
                                  FocusScope.of(context).unfocus();

                                  setState(() {
                                    _showLoader.value = true;
                                  });
                                  await ref
                                      .read(
                                          commentRepliesProvider(rootCommentId)
                                              .notifier)
                                      .replyComment(
                                        commentId: commentId,
                                        reply: _replyTextEditing.text.trim(),
                                      );
                                  _replyTextEditing.clear();
                                  _showLoader.value = false;
                                  _isReply = false;
                                  _showSendButton = false;

                                  setState(() {});
                                }
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                "Send",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  return SizedBox(width: 5);
                },
              ),
              addHorizontalSpacing(5),
            ],
          ),
          addVerticalSpacing(24),
        ],
      ),
    );
  }
}



////Old Bodyo
/* 

SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommentPost(
              username: widget.postUsername,
              postTime: widget.postData!.createdAt.getSimpleDate(),
              aspectRatio: widget.postData!.aspectRatio,
              homeCtrl: homeCtrl,
              imageList: widget.postData!.photos,
              userTagList: widget.postData!.taggedUsers,
              smallImageAsset: '${widget.postData!.postedBy.profilePictureUrl}',
              smallImageThumbnail: '${widget.postData!.postedBy.thumbnailUrl}',

              isVerified: widget.postData!.postedBy.isVerified,
              blueTickVerified: widget.postData!.postedBy.blueTickVerified,

              isOwnPost:
                  currentUser?.username == widget.postData!.postedBy.username,
              // onTaggedUserTap: (va){},
              caption: widget.postData!.caption ?? "",
            ),
            comments.when(
              data: (data) {
                if (data.isNotEmpty)
                  return RefreshIndicator.adaptive(
                    key: _refreshIndicatorKey,
                    onRefresh: () async =>
                        await ref.refresh(postCommentsProvider(widget.postId)),
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: data.length + 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        // print(data[index].comment!.isEmpty);
                        if (index == 0)
                          // Show comments as the first item
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: CaptionText(
                              username: widget.postUsername, // postUsername,
                              onUsernameTap: () {}, // postOnUsernameTap,
                              onMentionedUsernameTap: (val) {
                                navigateToRoute(
                                  context,
                                  OtherProfileRouter(username: val),
                                );
                              }, // postOnTaggedUserTap,
                              // text: '${widget.imageList.first.description}',
                              text: widget.postCaption ?? '',
                            ),
                          );

                        if (index == 1)
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${data.length} Comments',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.color
                                            ?.withOpacity(0.5),
                                        fontSize: 8.sp,
                                        // fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  widget.date!.timeAgo(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.color
                                            ?.withOpacity(0.5),
                                        fontSize: 8.sp,
                                        // fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          );

                        return CommentTile(
                          indentLevel: 0,
                          showReplyIcon: widget.showReplyIcon,
                          // replies: data[index - 2].replyParent ?? [],
                          //Todo [comment] fix
                          replies: [],
                          // onReplyWithIdTap: (ReplyParent reply) {
                          onReplyWithIdTap: (reply) {
                            print("[x-3b] $reply");
                            commentFieldNode.requestFocus();
                            _isReply = true;
                            commentId = reply.idToInt;
                            rootCommentId =
                                reply.rootParent?.idToInt ?? reply.idToInt;
                            commentator = reply.user!.username!;
                            print(commentId);
                            setState(() {});
                          },
                          commentModel: data[index - 2],
                          replyTo: ([2, 5].contains(index - 2))
                              ? null
                              : data[index - 2].user!.username ?? "",
                          onReplyTap: () {
                            commentFieldNode.requestFocus();
                            _isReply = true;
                            commentId = data[index - 2].idToInt;
                            rootCommentId =
                                data[index - 2].rootParent?.idToInt ??
                                    data[index - 2].idToInt;
                            commentator = data[index - 2].user!.username!;
                            print(commentId);
                            setState(() {});
                          },
                          posterImage: data[index - 2].user!.thumbnailUrl,
                          commentator: data[index - 2].user!.username,
                        );
                      },
                      //  CommentEndWidget(widget.postId),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 4);
                      },
                    ),
                  );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 15),
                      child: CaptionText(
                        username: widget.postUsername, // postUsername,
                        onUsernameTap: () {}, // postOnUsernameTap,
                        onMentionedUsernameTap: (val) {
                          navigateToRoute(
                            context,
                            OtherProfileRouter(username: val),
                          );
                        }, // postOnTaggedUserTap,
                        // text: '${widget.imageList.first.description}',
                        text: widget.postCaption ?? '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${data.length} Comments',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.color
                                      ?.withOpacity(0.5),
                                  fontSize: 8.sp,
                                  // fontWeight: FontWeight.w400,
                                ),
                          ),
                          Text(
                            widget.date!.getSimpleDate(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.color
                                      ?.withOpacity(0.5),
                                  fontSize: 8.sp,
                                  // fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpacing(50),
                    Center(child: Text("No comments")),
                  ],
                );
              },
              error: (error, stack) => Container(
                alignment: Alignment.center,
                child: Text(error.toString()),
              ),
              loading: () =>
                  Container(child: CircularProgressIndicator.adaptive()),
            ),
            addVerticalSpacing(200)
          ],
        ),
      )


 */