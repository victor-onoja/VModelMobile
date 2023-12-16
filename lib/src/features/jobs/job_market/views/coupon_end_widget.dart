import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/gap.dart';
import '../../../../vmodel.dart';
import '../../../dashboard/feed/widgets/feed_end.dart';
import '../controller/coupons_controller.dart';

class CouponsEndWidget extends ConsumerWidget {
  const CouponsEndWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showCouponEndWidget =
        ref.watch(allCouponsProvider.notifier).canLoadMore();
    return SliverToBoxAdapter(
      child: !showCouponEndWidget
          ? const FeedEndWidget(
              mainText: 'Looks like you have caught up with everything',
              subText: "Refresh to see any new coupon",
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
