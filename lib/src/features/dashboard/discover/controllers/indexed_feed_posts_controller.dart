import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/model/feed_model.dart';

import 'hash_tag_search_controller.dart';

enum IndexedFeedType { saved, hashtag }

final tappedPostIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

final indexedFeedPostsProvider = Provider.autoDispose
    .family<AsyncValue<List<FeedPostSetModel>>, IndexedFeedType>((ref, arg) {
  switch (arg) {
    case IndexedFeedType.saved:
      return AsyncData([]);
    case IndexedFeedType.hashtag:
      // return AsyncData([]);
      return ref.watch(hashTagProvider);
    default:
      return AsyncData([]);
  }
});
