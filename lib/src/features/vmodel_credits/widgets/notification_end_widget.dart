import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/feed_end.dart';
import 'package:vmodel/src/res/gap.dart';

import '../../notifications/controller/provider/notification_provider.dart';

class NotificationEndWidget extends ConsumerWidget {
  const NotificationEndWidget({super.key, 
    required this.message
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showServicesEnd = ref.watch(getNotifications.notifier).canLoadMore();
    return Container(
      child: !showServicesEnd
          ?  FeedEndWidget(
              mainText: message,
              hideIcon: true,
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
