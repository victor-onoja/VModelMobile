// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'user_post_board_model.dart';

class RecentlyViewedBoard {
  final int id;
  final UserPostBoard postBoard;
  final DateTime dateViewed;

  RecentlyViewedBoard({
    required this.id,
    required this.postBoard,
    required this.dateViewed,
  });

  RecentlyViewedBoard copyWith({
    int? id,
    UserPostBoard? postBoard,
    DateTime? dateViewed,
  }) {
    return RecentlyViewedBoard(
      id: id ?? this.id,
      postBoard: postBoard ?? this.postBoard,
      dateViewed: dateViewed ?? this.dateViewed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'postBoard': postBoard.toMap(),
      'dateViewed': dateViewed.toUtc(),
    };
  }

  factory RecentlyViewedBoard.fromMap(Map<String, dynamic> map) {
    return RecentlyViewedBoard(
      id: int.parse(map['id'] as String),
      postBoard:
          UserPostBoard.fromMap(map['postBoard'] as Map<String, dynamic>),
      dateViewed: DateTime.parse(map['dateViewed'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentlyViewedBoard.fromJson(String source) =>
      RecentlyViewedBoard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RecentlyViewedBoard(id: $id, postBoard: $postBoard, dateViewed: $dateViewed)';

  @override
  bool operator ==(covariant RecentlyViewedBoard other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.postBoard == postBoard &&
        other.dateViewed == dateViewed;
  }

  @override
  int get hashCode => id.hashCode ^ postBoard.hashCode ^ dateViewed.hashCode;
}
