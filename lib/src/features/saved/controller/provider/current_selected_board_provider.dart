// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_post_board_model.dart';

final currentSelectedBoardProvider =
    NotifierProvider.autoDispose<CurrentActiveBoardNotifier, SelectedBoard?>(
        CurrentActiveBoardNotifier.new);

class CurrentActiveBoardNotifier extends AutoDisposeNotifier<SelectedBoard?> {
  @override
  build() {
    return null;
  }

  void setOrUpdateBoard(SelectedBoard board) {
    state = board;
  }

  void removeBoard(SelectedBoard board) {
    state = null;
  }

  SelectedBoard? get currentState => state;
}

enum SelectedBoardSource { recent, userCreatd, service, hidden }

class SelectedBoard {
  final UserPostBoard board;
  final SelectedBoardSource source;

  SelectedBoard({
    required this.board,
    required this.source,
  });

  SelectedBoard copyWith({
    UserPostBoard? board,
    SelectedBoardSource? source,
  }) {
    return SelectedBoard(
      board: board ?? this.board,
      source: source ?? this.source,
    );
  }

  @override
  String toString() => 'SelectedBoard(board: $board, source: $source)';

  @override
  bool operator ==(covariant SelectedBoard other) {
    if (identical(this, other)) return true;

    return other.board == board && other.source == source;
  }

  @override
  int get hashCode => board.hashCode ^ source.hashCode;
}
