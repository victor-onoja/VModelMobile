import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/dashboard/discover/repository/hash_tags_repo.dart';

final recentHashTagsProvider =
    AsyncNotifierProvider.autoDispose<RecentHashTagController, List<String>>(
        RecentHashTagController.new);

class RecentHashTagController extends AutoDisposeAsyncNotifier<List<String>> {
  final repo = HashTagSearchRepository.instance;
  // int _totalDataCount = 0;
  // int _currentPage = 1;
  // int _pageCount = 3 * 6;

  @override
  Future<List<String>> build() async {
    // state = AsyncLoading();
    // _currentPage = 1;
    return await getPostsByHashtag();
  }

  Future<List<String>> getPostsByHashtag() async {
    final response = await repo.recentHashTags();

    return response.fold((left) {
      print("left ${left.message}");

      return [];
    }, (right) {
      log("hashtags right ${right}");

      final List items =
          right['recentlyViewedHashtags']['recentlyViewedHashTags'];

      final newState = [
        for (String tag in items)
          if (!tag.isEmptyOrNull) tag,
      ];

      log("\n newShashtags  ${newState}");
      return newState;
    });
  }

  // Future<void> fetchMoreHandler() async {
  //   final currentItemsLength = state.valueOrNull?.length;
  //   final canLoadMore = (currentItemsLength ?? 0) < _totalDataCount;
  //   // print(
  //   //     '[ssk] ($currentItemsLength) Can load $canLoadMore Toatal itesm are $_totalDataCount');

  //   if (canLoadMore) {
  //     await getPostsByHashtag(
  //         pageNumber: _currentPage + 1, isUpdateState: true);
  //   }
  // }

  // bool get canLoadMore => (state.valueOrNull?.length ?? 0) < _totalDataCount;
}
