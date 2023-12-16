import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dashboard/feed/model/feed_model.dart';
import 'posts_with_no_thumbnail_repository.dart';

final postsWithoutThumbnailProvider = AsyncNotifierProvider<
    PostsWithoutThumbnailNotifier,
    List<FeedPostSetModel>?>(PostsWithoutThumbnailNotifier.new);

class PostsWithoutThumbnailNotifier
    extends AsyncNotifier<List<FeedPostSetModel>?> {
  // FeedNotifier() : super();
  PostsWithoutThumbnailRepository? _repository;
  List<FeedPostSetModel>? feeds;
  final defaultCount = 50;
  int currentPage = 1;
  int totalPosts = 0;

  @override
  Future<List<FeedPostSetModel>?> build() async {
    _repository = PostsWithoutThumbnailRepository.instance;
    state = const AsyncLoading();
    await fetchMoreFeedData(page: currentPage);

    return state.value;
  }

  int get totalPostCount {
    return totalPosts;
  }

  Future<void> fetchMoreFeedData({required int page}) async {
    final feedResponse = await _repository!
        .getPostsWithoutThumbnails(pageNumber: page, pageCount: defaultCount);
    return feedResponse.fold((left) {
      print(
          "8888888888888 () error in build ${left.message} ${StackTrace.current}");
      // return AsyncError(left.message, StackTrace.current);
      feeds = null;
    }, (right) {
      try {
        totalPosts = right['postsWithPhotosWithoutThumbnailTotalNumber'] ?? 0;
        final res = right['postsWithPhotosWithoutThumbnail'] as List;
        print('################## %%%% $res');

        final newState =
            res.map((e) => FeedPostSetModel.fromPostWithoutThumbnail(e));
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

  void removePostWithThumbnail(int postId) {
    final currentState = state.valueOrNull ?? [];
    final newState = [
      for (var post in currentState)
        if (post.id != postId) post,
    ];
    totalPosts = totalPosts - (defaultCount - newState.length);
    if (newState.isEmpty) {
      ref.invalidateSelf();
      return;
    }
    state = AsyncData(newState);
  }
}
