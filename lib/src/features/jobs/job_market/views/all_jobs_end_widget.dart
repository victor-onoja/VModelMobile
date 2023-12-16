import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/all_jobs_controller.dart';

import '../../../../res/gap.dart';
import '../../../../vmodel.dart';
import '../../../dashboard/feed/widgets/feed_end.dart';

class AllJobsEndWidget extends ConsumerWidget {
  const AllJobsEndWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAllJobsEndWidget =
        ref.watch(allJobsProvider.notifier).canLoadMore();
    return SliverToBoxAdapter(
      child: !showAllJobsEndWidget
          ? const FeedEndWidget(
              mainText: 'Looks like you have caught up with everything',
              subText: "Refresh to see any new jobs",
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
