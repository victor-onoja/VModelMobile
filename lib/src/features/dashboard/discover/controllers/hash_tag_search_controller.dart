import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/discover/repository/hash_tags_repo.dart';

import '../../../../core/utils/enum/discover_search_tabs_enum.dart';
import '../../feed/model/feed_model.dart';
import 'composite_search_controller.dart';

final hashTagSearchProvider = StateProvider.autoDispose<String?>((ref) {
  final value = ref.watch(compositeSearchProvider);
  if (value.activeTab == DiscoverSearchTab.hashtags) {
    log('Hastag provider update');
    return value.query;
  }
  log('No hastag provider update');
  return '';
});

final userBoardsTotalNumberProvider = StateProvider<int>((ref) => 0);

final hashTagProvider = AsyncNotifierProvider.autoDispose<HashTagController,
    List<FeedPostSetModel>>(HashTagController.new);

class HashTagController
    extends AutoDisposeAsyncNotifier<List<FeedPostSetModel>> {
  final repo = HashTagSearchRepository.instance;
  int _totalDataCount = 0;
  int _currentPage = 1;
  int _pageCount = 3 * 6;

  @override
  Future<List<FeedPostSetModel>> build() async {
    // state = AsyncLoading();
    _currentPage = 1;
    return await getPostsByHashtag(pageNumber: _currentPage);
  }

  Future<List<FeedPostSetModel>> getPostsByHashtag({
    required int pageNumber,
    bool isUpdateState = false,
  }) async {
    final searchTerm = ref.watch(hashTagSearchProvider);
    final response = await repo.hashTagSearch(
        pageNumber: pageNumber, pageCount: _pageCount, search: searchTerm);

    print("[jiww0] hastags pg: ${pageNumber}, append: $isUpdateState");

    return response.fold((left) {
      print("left ${left.message}");

      return [];
    }, (right) {
      _totalDataCount = right['postHashtagSearchTotalNumber'] as int;
      final List posts = right['postHashtagSearch'];
      if (posts.isNotEmpty && !isUpdateState) {
        final newState = posts.map((e) => FeedPostSetModel.fromMap(e)).toList();
        return newState;
      } else if (posts.isNotEmpty && isUpdateState) {
        final newState = posts.map((e) => FeedPostSetModel.fromMap(e)).toList();
        final currentState = state.valueOrNull ?? [];

        state = AsyncData([...currentState, ...newState]);
        _currentPage = pageNumber;
      }
      return [];
    });
  }

  Future<void> fetchMoreHandler() async {
    final currentItemsLength = state.valueOrNull?.length;
    final canLoadMore = (currentItemsLength ?? 0) < _totalDataCount;
    // print(
    //     '[ssk] ($currentItemsLength) Can load $canLoadMore Toatal itesm are $_totalDataCount');

    if (canLoadMore) {
      await getPostsByHashtag(
          pageNumber: _currentPage + 1, isUpdateState: true);
    }
  }

  bool get canLoadMore => (state.valueOrNull?.length ?? 0) < _totalDataCount;
}
