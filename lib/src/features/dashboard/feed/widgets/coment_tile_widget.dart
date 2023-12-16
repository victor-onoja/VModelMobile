import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/comment_message.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/reply_tile_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../new_profile/other_user_profile/other_user_profile.dart';
import '../../new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../model/post_comment_model_temp.dart';
import 'comment/comment_slidable_widget.dart';

class CommentTile extends ConsumerStatefulWidget {
  const CommentTile({
    super.key,
    required this.commentModel,
    this.indentLevel = 0,
    required this.showReplyIcon, // = true,
    this.replyTo,
    this.posterImage,
    this.commentator,
    required this.replies,
    required this.onReplyTap,
    required this.onReplyWithIdTap,
  });

  final int indentLevel;
  final bool showReplyIcon;
  // final String comment;
  final NewPostCommentsModel commentModel;
  final String? replyTo;
  final VoidCallback? onReplyTap;
  final String? posterImage;
  final String? commentator;
  // final Function(ReplyParent reply) onReplyWithIdTap;
  // final Function(PostCommentsModel reply) onReplyWithIdTap;
  final Function(NewPostCommentsModel reply) onReplyWithIdTap;

  // final List<ReplyParent> replies;
  final List<NewPostCommentsModel> replies;

  @override
  ConsumerState<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends ConsumerState<CommentTile> {
  final int maxIndentLevel = 1;
  final double indentWidth = 16;
  final double imageSize = 30;

  bool isMessageCollapsed = true;
  double get replyIndicatorIndent =>
      min(widget.indentLevel, maxIndentLevel) * indentWidth + imageSize + 4;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.commentator);
    // final TextStyle baseStyle =
    //     Theme.of(context).textTheme.displaySmall!.copyWith(
    //           // color: VmodelColors.text,
    //           fontSize: 10.sp,
    //           fontWeight: FontWeight.w500,
    //         );
    final TextStyle? replyIndicatorStyle = Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(
            fontSize: 8.sp,
            color: Theme.of(context)
                .textTheme
                .displaySmall
                ?.color
                ?.withOpacity(0.5));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (widget.indentLevel > 0)
        //   Flexible(
        //     child: Row(
        //       children: [
        //         addHorizontalSpacing(replyIndicatorIndent),
        //         RichText(
        //           text: TextSpan(
        //             style: replyIndicatorStyle,
        //             // fontWeight: FontWeight.w600,

        //             children: [
        //               TextSpan(
        //                 text: 'In reply to ',
        //                 // style:
        //                 //     Theme.of(context).textTheme.displaySmall!.copyWith(
        //                 //           // color: VmodelColors.text,
        //                 //           fontSize: 10.sp,
        //                 //           fontWeight: FontWeight.w400,
        //                 //         ),
        //               ),
        //               TextSpan(
        //                 text: " ${widget.replyTo}",
        //                 // recognizer: TapGestureRecognizer()
        //                 //   ..onTap = () {
        //                 //     // navigateToRoute(
        //                 //     //     context, OtherUserProfile(username: mentionedUsername));
        //                 //   },
        //                 // style:
        //                 //     Theme.of(context).textTheme.displaySmall?.copyWith(
        //                 //           fontSize: 10.sp,
        //                 //           color: Theme.of(context)
        //                 //               .textTheme
        //                 //               .displaySmall
        //                 //               ?.color
        //                 //               ?.withOpacity(0.5),
        //                 //           // fontWeight: FontWeight.w600,
        //                 //         ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        Flexible(
            child: CommentSlidable(
                isPostReply: false,
                postId: widget.commentModel.postId!,
                rootCommentId: widget.commentModel.rootParent?.idToInt,
                commentId: widget.commentModel.idToInt,
                keyString: 'item-${widget.commentModel.idToInt}',
                commentedBy: '${widget.commentator}',
                commentModel: widget.commentModel,
                showReply: widget.showReplyIcon,
                onReply: (comment) {
                  widget.onReplyWithIdTap(comment);
                  // widget.onReplyTap?.call();
                },
                child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    crossAxisAlignment: isMessageCollapsed
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      addHorizontalSpacing(
                          min(widget.indentLevel, maxIndentLevel) *
                              indentWidth),
                      ProfilePicture(
                        url: widget.posterImage ?? "",
                        headshotThumbnail: widget.posterImage ?? "",
                        displayName: widget.commentator,
                        size: imageSize,
                      ),
                      addHorizontalSpacing(4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // addVerticalSpacing(2),
                            Flexible(
                                child: CommentMessage(
                              username: widget.commentator!,
                              text: widget.commentModel.comment,
                              isVerified:
                                  widget.commentModel.user?.isVerified ?? false,
                              blueTickVerified:
                                  widget.commentModel.user?.blueTickVerified ??
                                      false,
                              onUsernameTap: () {
                                if (!isCurrentUser)
                                  navigateToRoute(
                                      context,
                                      OtherUserProfile(
                                          username: widget.commentator!));
                              },
                              onMentionedUsernameTap: (value) {
                                navigateToRoute(context,
                                    OtherProfileRouter(username: value));
                              },
                              isMessageCollapsed: (value) {
                                print('[wxwx] onread more tap $value');
                                isMessageCollapsed = value;
                                setState(() {});
                              },
                            )),

                            // Flexible(
                            //   child: RichText(
                            //     text: TextSpan(
                            //       children: [
                            //         TextSpan(
                            //           text: "username ",
                            //           recognizer: TapGestureRecognizer()
                            //             ..onTap = () {
                            //               // navigateToRoute(
                            //               //     context, OtherUserProfile(username: mentionedUsername));
                            //             },
                            //           style: baseStyle.copyWith(
                            //             fontSize: 10.sp,
                            //             fontWeight: FontWeight.w600,
                            //           ),
                            //         ),
                            //         TextSpan(
                            //           text: comment,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .displaySmall!
                            //               .copyWith(
                            //                 // color: VmodelColors.text,
                            //                 fontSize: 10.sp,
                            //                 fontWeight: FontWeight.w400,
                            //               ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      addHorizontalSpacing(4),
                      // if (widget.showReplyIcon)
                      //   GestureDetector(
                      //     onTap: () {
                      //       widget.onReplyTap?.call();
                      //     },
                      //     child: Container(
                      //         color: Colors.transparent,
                      //         // color: Colors.blue,
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: 4, vertical: 1),
                      //         child: RenderSvgWithoutColor(
                      //           svgPath: VIcons.commentReply,
                      //           svgHeight: 20,
                      //           svgWidth: 20,
                      //         )

                      //         //  Text(
                      //         //   'Reply1',
                      //         //   style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      //         //         // color: VmodelColors.text,
                      //         //         fontSize: 8.sp,
                      //         //         fontWeight: FontWeight.w400,
                      //         //       ),
                      //         // ),
                      //         ),
                      //   )
                    ],
                  ),
                ))),
        Container(
          // color: Colors.amber,
          child: Flexible(
            child: ReplyTile(
              // replies: widget.replies,
              //Todo [comment] fix
              showReplyIcon: widget.showReplyIcon,
              rootCommentId: widget.commentModel.idToInt,
              replies: [],
              indentLevel: 1,
              // comment: "niwefiowhioen",
              replyTo: widget.commentator,
              // onReplyTap: (ReplyParent reply) {
              onReplyTap: (NewPostCommentsModel reply) {
                widget.onReplyWithIdTap(reply);
              },
              posterImage: "thumbnailUrl",
              // commentator: "username",
            ),
          ),
        ),
        // Flexible(
        //   child: ReplyTile(
        //     replies: widget.replies,

        //     indentLevel: 2,
        //     comment: "niwefiowhioen",
        //     replyTo: widget.commentator,
        //     onReplyTap: (id) {
        //       // commentFieldNode.requestFocus();
        //     },
        //     posterImage: "thumbnailUrl",
        //     commentator: "username",
        //   ),
        // ),
      ],
    );
  }
}
