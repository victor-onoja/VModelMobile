import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../res/icons.dart';
import '../../../../../res/res.dart';
import '../../../../../shared/rend_paint/render_svg.dart';
import '../../../../../shared/username_verification.dart';
import '../../../../../vmodel.dart';
import '../../../new_profile/other_user_profile/other_user_profile.dart';
import '../../../new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../../model/post_comment_model_temp.dart';
import '../comment_message.dart';
import 'comment_child_widget_painter.dart';

class NewCommentReplyTile extends ConsumerStatefulWidget {
  const NewCommentReplyTile({
    super.key,
    required this.commentModel,
    required this.onReplyTap,
    this.indentLevel = 1,
    required this.showReplyIcon, // = true,
  });
  final int indentLevel;
  final bool showReplyIcon;
  final NewPostCommentsModel commentModel;
  final Function(NewPostCommentsModel reply) onReplyTap;

  @override
  ConsumerState<NewCommentReplyTile> createState() =>
      _NewCommentReplyTileState();
}

class _NewCommentReplyTileState extends ConsumerState<NewCommentReplyTile> {
  bool isMessageCollapsed = true;
  final int maxIndentLevel = 1;
  final double indentWidth = 16;
  final double imageSize = 30;

  // double get replyIndicatorIndent {
  //   print('[jxoo1] ${widget.indentLevel}');
  //   return min(widget.indentLevel, maxIndentLevel) * indentWidth +
  //       imageSize +
  //       4;
  // }

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = ref
        .read(appUserProvider.notifier)
        .isCurrentUser("${widget.commentModel.user?.username}");
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
      children: [
        addVerticalSpacing(4),
        Container(
          padding: EdgeInsets.only(
              left: min(widget.indentLevel, maxIndentLevel) * indentWidth),
          // left: 50,
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
                      url:
                          "${widget.commentModel.parent!.user?.profilePictureUrl}",
                      headshotThumbnail:
                          widget.commentModel.parent!.user?.thumbnailUrl,
                      displayName:
                          widget.commentModel.parent!.user?.displayName,
                      size: 20,
                    ),
                    addHorizontalSpacing(4),
                    Flexible(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: replyIndicatorStyle,
                          children: [
                            // TextSpan(
                            //   text:
                            //       "${widget.commentModel.parent!.user?.username}",
                            //   style: replyIndicatorStyle?.copyWith(
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            WidgetSpan(
                              child: VerifiedUsernameWidget(
                                rowMainAxisSize: MainAxisSize.min,
                                iconSize: 8,
                                spaceSeparatorWidth: 2,
                                username:
                                    "${widget.commentModel.parent!.user?.username}",
                                // displayName:
                                //     "${widget.commentModel.parent!.user?.displayN}",
                                textStyle: replyIndicatorStyle?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                isVerified: widget
                                    .commentModel.parent!.user?.isVerified,
                                blueTickVerified: widget.commentModel.parent!
                                    .user?.blueTickVerified,
                              ),
                            ),
                            // TextSpan(
                            //   text: 'In reply to 2 ',
                            // ),
                            TextSpan(
                              text: " ${widget.commentModel.parent!.comment}",
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
        ),
        Row(
          crossAxisAlignment: isMessageCollapsed
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            addHorizontalSpacing(
              min(widget.indentLevel, maxIndentLevel) * indentWidth,
            ),
            ProfilePicture(
              url: widget.commentModel.user!.thumbnailUrl ?? "",
              headshotThumbnail: widget.commentModel.user!.thumbnailUrl ?? "",
              displayName: widget.commentModel.parent!.user?.displayName,
              size: imageSize,
            ),
            addHorizontalSpacing(4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: CommentMessage(
                    username: widget.commentModel.user!.username,
                    text: widget.commentModel.comment,
                    isVerified: widget.commentModel.user?.isVerified ?? false,
                    blueTickVerified:
                        widget.commentModel.user?.blueTickVerified ?? false,
                    onUsernameTap: () {
                      if (!isCurrentUser)
                        navigateToRoute(
                            context,
                            OtherUserProfile(
                                username: widget.commentModel.user!.username));
                    },
                    onMentionedUsernameTap: (value) {},
                    isMessageCollapsed: (value) {
                      print('[wxwx] onread more tap $value');
                      isMessageCollapsed = value;
                      setState(() {});
                    },
                  )),
                ],
              ),
            ),
            // if (widget.showReplyIcon)
            //   GestureDetector(
            //     onTap: () {
            //       print("object");
            //       //[important] Todo reply fix
            //       widget.onReplyTap(widget.commentModel);
            //     },
            //     child: Container(
            //         color: Colors.transparent,
            //         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            //         child: RenderSvgWithoutColor(
            //           svgPath: VIcons.commentReply,
            //           svgHeight: 20,
            //           svgWidth: 20,
            //         )

            //         // Text(
            //         //   'Reply3',
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
      ],
    );
  }
}
