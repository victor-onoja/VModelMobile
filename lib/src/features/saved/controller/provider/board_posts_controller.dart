import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/feed/model/feed_model.dart';
import '../../../dashboard/feed/repository/feed_repository.dart';
import '../../model/user_post_board_model.dart';
import '../repository/user_boards_repo.dart';

final boardPostsProvider = AsyncNotifierProvider.family
    .autoDispose<UserPostBoardsNotifier, List<FeedPostSetModel>, int>(
        UserPostBoardsNotifier.new);

class UserPostBoardsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<FeedPostSetModel>, int> {
  final repo = UserPostBoardRepo.instance;
  final int _currentPageCount = 12;
  int _currentPageNumber = 1;
  @override
  Future<List<FeedPostSetModel>> build(arg) async {
    // state = AsyncLoading();
    return await getUserSavedBoards(arg);
  }

  Future<List<FeedPostSetModel>> getUserSavedBoards(int boardId) async {
    final response = await repo.getBoardPosts(
      boardId: boardId,
      pageCount: _currentPageCount,
      pageNumber: _currentPageNumber,
    );

    return response.fold((left) {
      print("left ${left.message}");

      return [];
    }, (right) {
      // final List post = right['savedPosts'];
      print("cn7x $right");
      if (right.isNotEmpty) {
        return right.map<FeedPostSetModel>((e) {
          return FeedPostSetModel.fromMap(e);
        }).toList();
      }
      return [];
    });
  }

  Future<bool> onLikePost({required int postId}) async {
    print("AAAAAAA liking post $postId");
    final response = await FeedRepository.instance.likePost(postId);
    return response.fold((left) {
      print(
          "AAAAAAA error parsing json response ${left.message} ${StackTrace.current}");
      return false;
    }, (right) {
      try {
        final bool success = right['success'] as bool;
        final postList = state.value;

        // state = AsyncValue.data([
        //   for (final post in postList!)
        //     if (post.id == postId) post.copyWith(userLiked: success) else post,
        // ]);
        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
      return false;
    });
  }
}
