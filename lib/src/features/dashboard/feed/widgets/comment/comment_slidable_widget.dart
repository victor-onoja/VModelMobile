import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../res/res.dart';
import '../../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../../../shared/bottom_sheets/tile.dart';
import '../../../../../shared/buttons/text_button.dart';
import '../../../../../vmodel.dart';
import '../../controller/post_comments_controller.dart';
import '../../model/post_comment_model_temp.dart';

class CommentSlidable extends ConsumerStatefulWidget {
  const CommentSlidable({
    super.key,
    required this.isPostReply,
    required this.postId,
    required this.rootCommentId,
    required this.commentId,
    required this.keyString,
    required this.commentedBy,
    required this.child,
    required this.onReply,
    required this.commentModel,
    required this.showReply,
  });

  final bool isPostReply;
  final bool showReply;

  final int postId;
  final int commentId;
  final int? rootCommentId;
  final String keyString;
  final String commentedBy;
  final Widget child;
  final NewPostCommentsModel commentModel;
  final Function(NewPostCommentsModel reply) onReply;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommentSlidableState();
}

class _CommentSlidableState extends ConsumerState<CommentSlidable> {
  final ValueNotifier<bool> _showLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final currentUsername = ref.watch(appUserProvider).valueOrNull?.username;
    final isCurrentUserComment = '$currentUsername' == widget.commentedBy;
    return Slidable(
      groupTag: VMString.commentSlidableGroupTag,
      enabled: widget.showReply || isCurrentUserComment,
      key: Key(widget.keyString),
      endActionPane: ActionPane(
        extentRatio: widget.showReply && isCurrentUserComment ? 0.5 : 0.25,
        motion: const StretchMotion(),
        // dragDismissible: index != index,
        children: [
          if (widget.showReply)
            SlidableAction(
              onPressed: (context) {
                widget.onReply(widget.commentModel);
              },
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 186, 186, 187),
              label: 'Reply',
            ),
          if (isCurrentUserComment)
            SlidableAction(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
              onPressed: (context) {
                // ref.read()
                _showDeleteConfirmation();
              },
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              label: 'Delete',
            ),
        ],
      ),
      child: widget.child,
    );
  }

  void _showDeleteConfirmation() {
    showModalBottomSheet<Widget>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: VWidgetsConfirmationBottomSheet(
              title: "Are you sure you want to delete comment?",
              actions: [
                ValueListenableBuilder(
                    valueListenable: _showLoading,
                    builder: (context, value, _) {
                      return VWidgetsTextButton(
                        text: 'Delete',
                        showLoadingIndicator: value,
                        onPressed: () async {
                          _showLoading.value = true;
                          await ref
                              .read(
                                  postCommentsProvider(widget.postId).notifier)
                              .deleteComment(
                                  commentId: widget.commentId,
                                  rootCommentId: widget.rootCommentId);
                          _showLoading.value = false;
                          if (context.mounted) {
                            goBack(context);
                          }
                        },
                      );
                    }),
                // if (!showLoader)
                const Divider(
                  thickness: 0.5,
                ),
                // Connect
                // if (!showLoader)
                VWidgetsBottomSheetTile(
                    onTap: () {
                      if (context.mounted) {
                        goBack(context);
                      }
                    },
                    message: 'Cancel')
              ],
            ),
          );
        });
      },
    );
  }
}
