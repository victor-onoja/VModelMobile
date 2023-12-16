import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/repository/feed_repository.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../../../../dashboard/feed/model/feed_model.dart';
import '../repository/recommended_posts_repo.dart';

// final isFeedEndReachedProvider = StateProvider((ref) => false);

// final isPinchToZoomProvider = StateProvider((ref) => false);

// final isProViewProvider = StateProvider((ref) {
//   return false;
//   // return isDefaultViewSlides;
// });

final mlFeedProvider =
    AsyncNotifierProvider.autoDispose<MLFeedNotifier, List<FeedPostSetModel>?>(
        MLFeedNotifier.new);

class MLFeedNotifier extends AutoDisposeAsyncNotifier<List<FeedPostSetModel>?> {
  // FeedNotifier() : super();
  RecommendedRepository? _repository;
  List<FeedPostSetModel>? feeds;
  final defaultCount = 20;
  int currentPage = 1;
  int feedTotalItems = 0;

  @override
  Future<List<FeedPostSetModel>?> build() async {
    _repository = RecommendedRepository.instance;
    state = const AsyncLoading();
    // final feedResponse = await _repository!.getFeedStream(pageCount: );
    // return feedResponse.fold((left) {
    //   print(
    //       "8888888888888 () error in build ${left.message} ${StackTrace.current}");
    //   // return AsyncError(left.message, StackTrace.current);
    //   return null;
    // }, (right) {
    //   try {
    //     final res = right;
    //     print('################## %%%% $res');

    //     final newState = res.map((e) => FeedPostSetModel.fromMap(e));
    //     feeds.addAll(newState);
    //     print("++++++++++++++++++++++++++++++++\n $newState \n");
    //     return feeds;
    //   } catch (e) {
    //     print("AAAAAAA error parsing json response $e ${StackTrace.current}");
    //     return null;
    //   }
    // });
    await fetchMoreFeedData(page: currentPage);

    return state.value;
  }

  Future<void> fetchMoreFeedData({required int page}) async {
    dev.log("[55] b4 $defaultCount $feedTotalItems");
    final feedResponse = await _repository!.getFeedStream();

    return feedResponse.fold((left) {
      print(
          "8888888888888 () error in build ${left.message} ${StackTrace.current}");
      // return AsyncError(left.message, StackTrace.current);
      feeds = null;
    }, (right) {
      try {
        // feedTotalItems = right['allPostsTotalNumber'] ?? 0;
        final res = right['recommendForUser'] as List;
        print('################## %%%% $right');

        dev.log("[55] try $defaultCount $feedTotalItems");
        final newState = res.map((e) => FeedPostSetModel.fromMap(e));
        // feeds?.addAll(newState);

        // state = AsyncData()[...state, ...newState];
        final currentState = state.valueOrNull ?? [];
        if (page == 1) {
          state = AsyncData(newState.toList());
        } else {
          if (currentState.isNotEmpty &&
              newState.any((element) => currentState.last.id == element.id)) {
            return;
          }
          state = AsyncData([...currentState, ...newState]);
        }
        currentPage = page;
        print("++++++++++++++++++++++++++++++++\n $newState \n");
        // return feeds;
      } catch (e, sta) {
        print("AAAAAAA error parsing json response $e ${sta}");
        feeds = null;
        // return null;
      }
    });
  }

  // Future<void> fetchMoreHandler(int index) async {
  Future<void> fetchMoreHandler() async {
    // final itemPositon = index + 1;
    // print("[55]  index is $index postion is $itemPositon");
    // final requestMore = itemPositon % defaultCount == 0 && itemPositon != 0;
    // // print(
    // //     "[55]  index: $index, postion: $itemPositon, requestMore $requestMore");
    // final pageToRequest = (itemPositon ~/ defaultCount);
    // // final pageToRequest = currentPage + 1;
    // // final canLoadMore = requestMore && pageToRequest + 1 >= currentPage;
    final canLoadMore = (state.valueOrNull?.length ?? 0) < feedTotalItems;
    // final canLoadMore = pageToRequest >= currentPage;
    // print(
    //     "[55]  page: $pageToRequest, canLoad: $canLoadMore, requestMore $requestMore");
    // ref.read(isFeedEndReachedProvider.notifier).state = !canLoadMore;

    // print(
    //     "[55]fetching more for page ${pageToRequest + 1} , requestMORAE IS $requestMore can load mre $canLoadMore index is $index");
    dev.log("[55]  Fetching page:${currentPage + 1} no bounce");
    if (canLoadMore) {
      await fetchMoreFeedData(page: currentPage + 1);
      // ref.read(isFeedEndReachedProvider.notifier).state =
      //     itemPositon < feedTotalItems;
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < feedTotalItems;
  }
}
