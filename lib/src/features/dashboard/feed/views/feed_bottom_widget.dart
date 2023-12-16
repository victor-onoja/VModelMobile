import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/gap.dart';
import '../../../../vmodel.dart';
import '../controller/new_feed_provider.dart';
import '../widgets/feed_end.dart';

class FeedAfterWidget extends ConsumerWidget {
  const FeedAfterWidget({
    super.key,
    required this.canLoadMore,
  });

  final bool canLoadMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final showFeedEndWidget =
    //     ref.watch(mainFeedProvider.notifier).canLoadMore();
    return !canLoadMore
        ? const FeedEndWidget(
            mainText: 'Looks like you have caught up with everything',
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
          );
  }
}
