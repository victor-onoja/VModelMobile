import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedNavigationDepthProvider =
    NotifierProvider.autoDispose<FeedNavigationDepthNotifier, int>(
        FeedNavigationDepthNotifier.new);

class FeedNavigationDepthNotifier extends AutoDisposeNotifier<int> {
  @override
  build() {
    return 0;
  }

  increment() {
    state += 1;
  }

  decrement() {
    if (state == 0) return;
    state -= 1;
  }
}
