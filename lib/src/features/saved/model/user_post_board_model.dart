// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vmodel/src/vmodel.dart';

import '../../../core/models/app_user.dart';

@immutable
class UserPostBoard {
  final int id;
  final String title;
  final VAppUser user;
  final bool deleted;
  final DateTime createdAt;
  final String? coverImageUrl;
  final int numberOfPosts;
  final bool pinned;

  UserPostBoard({
    required this.id,
    required this.title,
    required this.user,
    required this.deleted,
    required this.createdAt,
    required this.coverImageUrl,
    required this.numberOfPosts,
    required this.pinned,
  });

  UserPostBoard copyWith({
    int? id,
    String? title,
    VAppUser? user,
    bool? deleted,
    DateTime? createdAt,
    String? coverImageUrl,
    int? numberOfPosts,
    bool? pinned,
  }) {
    return UserPostBoard(
      id: id ?? this.id,
      title: title ?? this.title,
      user: user ?? this.user,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      numberOfPosts: numberOfPosts ?? this.numberOfPosts,
      pinned: pinned ?? this.pinned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'coverImageUrl': coverImageUrl,
      'user': user.toMap(),
      'deleted': deleted,
      'createdAt': createdAt.toUtc(),
      'numberOfPosts': numberOfPosts,
      'pinned': pinned,
    };
  }

  factory UserPostBoard.fromMap(Map<String, dynamic> map) {
    try {
      return UserPostBoard(
        id: int.parse(map['id']),
        title: map['title'] as String,
        coverImageUrl: map['coverImageUrl'] != null
            ? (map['coverImageUrl'] as String)
            : "",
        user: VAppUser.fromMinimalMap(map['user'] as Map<String, dynamic>),
        deleted: map['deleted'] as bool,
        createdAt: DateTime.parse(map['createdAt']),
        numberOfPosts: map['numberOfPosts'] as int,
        pinned: map['pinned'] as bool,
      );
    } catch (err, st) {
      print('cn7xqq $err $st');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory UserPostBoard.fromJson(String source) =>
      UserPostBoard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // return 'UserPostBoard(id: $id, title: $title, user: $user, deleted: $deleted, createdAt: $createdAt, coverImageUrl: $coverImageUrl, numberOfPosts: $numberOfPosts, pinned: $pinned)';
    return 'UserPostBoard(id: $id, title: $title,  deleted: $deleted, createdAt: $createdAt, coverImageUrl: $coverImageUrl, numberOfPosts: $numberOfPosts, pinned: $pinned)';
  }

  @override
  bool operator ==(covariant UserPostBoard other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.user == user &&
        other.deleted == deleted &&
        other.createdAt == createdAt &&
        other.coverImageUrl == coverImageUrl &&
        other.numberOfPosts == numberOfPosts &&
        other.pinned == pinned;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        user.hashCode ^
        deleted.hashCode ^
        createdAt.hashCode ^
        coverImageUrl.hashCode ^
        numberOfPosts.hashCode ^
        pinned.hashCode;
  }
}
