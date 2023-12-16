import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/feed/repository/feed_repository.dart';
import '../../model/recently_viewed_board_model.dart';
import '../../model/user_post_board_model.dart';
import '../repository/user_boards_repo.dart';

final recentlyViewedBoardsProvider = AsyncNotifierProvider.autoDispose<
    RecentlyViewedBoardsNotifier,
    List<RecentlyViewedBoard>>(RecentlyViewedBoardsNotifier.new);

class RecentlyViewedBoardsNotifier
    extends AutoDisposeAsyncNotifier<List<RecentlyViewedBoard>> {
  final repo = UserPostBoardRepo.instance;
  @override
  Future<List<RecentlyViewedBoard>> build() async {
    // state = AsyncLoading();
    return await getRecentlyViewedBoards();
  }

  Future<List<RecentlyViewedBoard>> getRecentlyViewedBoards() async {
    final response = await repo.getRecentlyViewedBoards();

    return response.fold((left) {
      print("[cn7i left ${left.message}");

      return [];
    }, (right) {
      print("[cn7i $right");
      if (right.isNotEmpty) {
        return right.map<RecentlyViewedBoard>((e) {
          return RecentlyViewedBoard.fromMap(e);
        }).toList();
      }
      return [];
    });
  }

  void updateItemState(UserPostBoard board) {
    log('ypdating recent board item state with $board');
    final currentState = state.valueOrNull ?? [];
    state = AsyncData([
      for (var item in currentState)
        if (item.postBoard.id == board.id)
          item.copyWith(postBoard: board)
        else
          item,
    ]);
  }
}
