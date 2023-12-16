import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/post_comments_controller.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/feed_end.dart';
import 'package:vmodel/src/res/gap.dart';

class CommentEndWidget extends ConsumerWidget {
  const CommentEndWidget(this.postId, {super.key});
 final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showServicesEnd =
        ref.watch(postCommentsProvider(postId).notifier).canLoadMore();
    return SliverToBoxAdapter(
      child: !showServicesEnd
          ? const FeedEndWidget(
              mainText: 'Looks like you have caught up with everything',
              // subText: "Refresh to see any new services",
            )
          : Column(
              children: [
                const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2)),
                addVerticalSpacing(8),
                Text(
                  'Loading more...',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
    );
  }
}
