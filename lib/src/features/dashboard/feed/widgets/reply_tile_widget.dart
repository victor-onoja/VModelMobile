import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/features/dashboard/feed/model/post_comments_model.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../controller/post_comment_replies_controller.dart';
import '../model/post_comment_model_temp.dart';
import 'comment/comment_child_widget_painter.dart';
import 'comment/complete_comment_reply_widget.dart';
import 'comment/comment_slidable_widget.dart';

class ReplyTile extends ConsumerStatefulWidget {
  const ReplyTile({
    super.key,
    // required this.comment,
    this.indentLevel = 0,
    required this.showReplyIcon, // = true,
    this.replyTo,
    required this.rootCommentId,
    required this.onReplyTap,
    this.posterImage,
    // this.commentator,
    required this.replies,
  });

  final bool showReplyIcon;
  final int indentLevel;
  // final String postId;
  final String? replyTo;
  // final Function(ReplyParent reply) onReplyTap;
  // final Function(PostCommentsModel reply) onReplyTap;
  final Function(NewPostCommentsModel reply) onReplyTap;
  final String? posterImage;
  final int rootCommentId;
  // final String? commentator;

  // final List<ReplyParent> replies;
  final List<PostCommentsModel> replies;

  @override
  ConsumerState<ReplyTile> createState() => _ReplyTileState();
}

class _ReplyTileState extends ConsumerState<ReplyTile> {
  final int maxIndentLevel = 1;
  final double indentWidth = 16;
  final double imageSize = 30;
  bool showAll = false;

  bool isMessageCollapsed = true;
  double get replyIndicatorIndent {
    return min(widget.indentLevel, maxIndentLevel) * indentWidth +
        imageSize +
        4;
  }

  @override
  Widget build(BuildContext context) {
    final newReplies = ref.watch(commentRepliesProvider(widget.rootCommentId));
    final commentRepliesTotalNumber =
        ref.watch(commentRepliesTotalProvider(widget.rootCommentId));

    // final TextStyle baseStyle =
    //     Theme.of(context).textTheme.displaySmall!.copyWith(
    //           // color: VmodelColors.text,
    //           fontSize: 10.sp,
    //           fontWeight: FontWeight.w500,
    //         );
    // final replies = ref.watch(replyProvider(widget.commentId));
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

    return newReplies.maybeWhen(
      data: (data) {
        //If child comments are less than 3 show all else make provision
        // to whow 'view more replies' text widget
        final sooso = data.length < 3 ? data.length : (data.length + 1);
        if (data.isEmpty) return SizedBox.shrink();
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.showReplyIcon ? sooso : 1,
          itemBuilder: ((context, index) {
            final isAllRepliesFetched =
                data.length == commentRepliesTotalNumber;

            if (index == data.length) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(commentRepliesProvider(widget.rootCommentId)
                              .notifier)
                          .fetchMoreData();
                    },
                    child: Container(
                      child: Text(
                        isAllRepliesFetched
                            // ? 'View less'
                            ? ''
                            // : 'View ${commentRepliesTotalNumber} replies',
                            : 'View more replies',
                        // '${widget.index + 1}-- ${widget.postTime}',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 10.sp,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  // color: Theme.of(context).colorScheme.onSecondary
                                  // .withOpacity(0.5),
                                ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return CommentSlidable(
              isPostReply: true,
              keyString: 'item-$index',
              postId: data[index].postId!,
              rootCommentId: data[index].rootParent?.idToInt,
              commentId: data[index].idToInt,
              commentedBy: data[index].user!.username,
              commentModel: data[index],
              onReply: widget.onReplyTap,
              showReply: widget.showReplyIcon,
              child: Container(
                // decoration: BoxDecoration(
                //   color: Colors.pink,
                //   border: Border.symmetric(
                //     horizontal: BorderSide(color: Colors.white),
                //   ),
                // ),
                child: NewCommentReplyTile(
                  showReplyIcon: widget.showReplyIcon,
                  commentModel: data[index],
                  onReplyTap: widget.onReplyTap,
                ),
              ),
            );
          }),
        );
      },
      orElse: () => Text('No data for new replies'),
    );
  }

  Widget repliedCommentWidget(
    TextStyle? replyIndicatorStyle,
    NewPostCommentsModel? parent,
  ) {
    if (parent == null) return SizedBox.shrink();
    return Container(
      padding: EdgeInsets.only(
          left: min(widget.indentLevel, maxIndentLevel) * indentWidth),
      // width: 80.w,
      height: 20,
      child: MyCommentChildWidget(
        isLast: false,
        // avatarRoot: Size(0, 0),
        avatarRoot: Size.fromRadius(9),
        replyToContent: PreferredSize(
            preferredSize: Size.fromRadius(9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfilePicture(
                  url: "${parent.user?.profilePictureUrl}",
                  headshotThumbnail: parent.user?.thumbnailUrl,
                  size: 20,
                ),
                Flexible(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: replyIndicatorStyle,
                      children: [
                        TextSpan(
                          text: "${parent.user?.username}",
                          style: replyIndicatorStyle?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // TextSpan(
                        //   text: 'In reply to 2 ',
                        // ),
                        TextSpan(
                          text: " ${parent.comment}",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        // replyIcon: GestureDetector(
        //   onTap: () {
        //     print("object");
        //   },
        //   child: Container(
        //       color: Colors.transparent,
        //       padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        //       child: RenderSvgWithoutColor(
        //         svgPath: VIcons.commentReply,
        //         svgHeight: 20,
        //         svgWidth: 20,
        //       )),
        // ),
      ),
    );
  }

  // SingleChildScrollView replyTile(TextStyle? replyIndicatorStyle) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // repliedCommentWidget(replyIndicatorStyle, widget.replies[0].parent),
  //         // Row(
  //         //   children: [
  //         //     addHorizontalSpacing(replyIndicatorIndent),
  //         //     Container(
  //         //       padding: EdgeInsets.symmetric(horizontal: 4),
  //         //       decoration: BoxDecoration(
  //         //         color: Colors.grey.shade300,
  //         //         borderRadius: BorderRadius.circular(7),
  //         //       ),
  //         //       child: Row(
  //         //         children: [
  //         //           ProfilePicture(
  //         //             url: VMString.testImageUrl,
  //         //             headshotThumbnail: VMString.testImageUrl,
  //         //             size: 20,
  //         //           ),
  //         //           RichText(
  //         //             text: TextSpan(
  //         //               style: replyIndicatorStyle,
  //         //               children: [
  //         //                 TextSpan(
  //         //                   text: 'In reply to 3 ',
  //         //                 ),
  //         //                 TextSpan(
  //         //                   text: " ${widget.replyTo}",
  //         //                 ),
  //         //               ],
  //         //             ),
  //         //           ),
  //         //         ],
  //         //       ),
  //         //     ),
  //         //   ],
  //         // ),
  //         Row(
  //           crossAxisAlignment: isMessageCollapsed
  //               ? CrossAxisAlignment.center
  //               : CrossAxisAlignment.start,
  //           children: [
  //             addHorizontalSpacing(
  //                 min(widget.indentLevel, maxIndentLevel) * indentWidth),
  //             ProfilePicture(
  //               url: widget.replies[0].user!.thumbnailUrl ?? "",
  //               headshotThumbnail: widget.replies[0].user!.thumbnailUrl ?? "",
  //               size: imageSize,
  //             ),
  //             addHorizontalSpacing(4),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Flexible(
  //                       child: CommentMessage(
  //                     // isVerified: widget.replies[0].user ?? false,
  //                     // blueTickVerified:
  //                     //     widget.commentModel.user?.blueTickVerified ?? false,
  //                     username: widget.replies[0].user!.username ?? "",
  //                     text: widget.replies[0].comment ?? "",
  //                     onUsernameTap: () {},
  //                     onMentionedUsernameTap: (value) {},
  //                     isMessageCollapsed: (value) {
  //                       print('[wxwx] onread more tap $value');
  //                       isMessageCollapsed = value;
  //                       setState(() {});
  //                     },
  //                   )),
  //                 ],
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 print("object");
  //                 //[important] Todo reply fix
  //                 // widget.onReplyTap(widget.replies[0]);
  //               },
  //               child: Container(
  //                   color: Colors.transparent,
  //                   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
  //                   child: RenderSvgWithoutColor(
  //                     svgPath: VIcons.commentReply,
  //                     svgHeight: 20,
  //                     svgWidth: 20,
  //                   )

  //                   // Text(
  //                   //   'Reply3',
  //                   //   style: Theme.of(context).textTheme.displaySmall!.copyWith(
  //                   //         // color: VmodelColors.text,
  //                   //         fontSize: 8.sp,
  //                   //         fontWeight: FontWeight.w400,
  //                   //       ),
  //                   // ),
  //                   ),
  //             )
  //           ],
  //         ),
  //         if (widget.replies.length > 1) ...[
  //           addVerticalSpacing(20),
  //           Row(
  //             children: [
  //               addHorizontalSpacing(20),
  //               GestureDetector(
  //                 onTap: () => setState(() => showAll = !showAll),
  //                 child: Text(
  //                   "Show ${widget.replies.length - 1} repl${(widget.replies.length - 1) == 1 ? "y" : "ies"}",
  //                   style: Theme.of(context).textTheme.displaySmall?.copyWith(
  //                         fontSize: 12,
  //                       ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           addVerticalSpacing(10),
  //         ],
  //       ],
  //     ),
  //   );
  // }
}
