// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/models/app_user.dart';

class NewPostCommentsModel {
  final String? id;
  final int? upVotes;
  final String? createdAt;
  final String? updatedAt;
  final String comment;
  final bool? userLiked;
  final bool? hasChildren;
  final int? childrenCount;
  final NewPostCommentsModel? parent;
  final NewPostCommentsModel? rootParent;
  final VAppUser? user;
  final int? postId;

  int get idToInt {
    return int.tryParse(this.id!) ?? -1;
  }

  NewPostCommentsModel({
    this.id,
    required this.upVotes,
    required this.createdAt,
    required this.updatedAt,
    required this.comment,
    required this.userLiked,
    required this.hasChildren,
    required this.childrenCount,
    this.parent,
    this.rootParent,
    this.user,
    this.postId,
  });

  NewPostCommentsModel copyWith({
    String? id,
    int? upVotes,
    String? createdAt,
    String? updatedAt,
    String? comment,
    bool? userLiked,
    bool? hasChildren,
    int? childrenCount,
    NewPostCommentsModel? parent,
    NewPostCommentsModel? rootParent,
    VAppUser? user,
    int? postId,
  }) {
    return NewPostCommentsModel(
      id: id ?? this.id,
      upVotes: upVotes ?? this.upVotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      comment: comment ?? this.comment,
      userLiked: userLiked ?? this.userLiked,
      hasChildren: hasChildren ?? this.hasChildren,
      childrenCount: childrenCount ?? this.childrenCount,
      parent: parent ?? this.parent,
      rootParent: rootParent ?? this.rootParent,
      user: user ?? this.user,
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'upVotes': upVotes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'comment': comment,
      'userLiked': userLiked,
      'hasChildren': hasChildren,
      'childrenCount': childrenCount,
      'parent': parent?.toMap(),
      'rootParent': rootParent?.toMap(),
      'user': user?.toMap(),
      'postId': postId,
    };
  }

  factory NewPostCommentsModel.fromMap(Map<String, dynamic> map) {
    return NewPostCommentsModel(
      id: map['id'] != null ? map['id'] as String : null,
      upVotes: map['upVotes'] != null ? map['upVotes'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      comment: map['comment'] as String,
      userLiked: map['userLiked'] != null ? map['userLiked'] as bool : null,
      hasChildren:
          map['hasChildren'] != null ? map['hasChildren'] as bool : null,
      childrenCount:
          map['childrenCount'] != null ? map['childrenCount'] as int : null,
      parent: map['parent'] != null
          ? NewPostCommentsModel.fromMap(map['parent'] as Map<String, dynamic>)
          : null,
      rootParent: map['rootParent'] != null
          ? NewPostCommentsModel.fromMap(
              map['rootParent'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? VAppUser.fromMinimalMap(map['user'] as Map<String, dynamic>)
          : null,
      postId: map['post'] != null ? int.tryParse(map['post']['id']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewPostCommentsModel.fromJson(String source) =>
      NewPostCommentsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewPostCommentsModel(id: $id, upVotes: $upVotes, createdAt: $createdAt, updatedAt: $updatedAt, comment: $comment, userLiked: $userLiked, hasChildren: $hasChildren, childrenCount: $childrenCount, parent: $parent, rootParent: $rootParent, user: $user, postId: $postId)';
  }

  @override
  bool operator ==(covariant NewPostCommentsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.upVotes == upVotes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.comment == comment &&
        other.userLiked == userLiked &&
        other.hasChildren == hasChildren &&
        other.childrenCount == childrenCount &&
        other.parent == parent &&
        other.rootParent == rootParent &&
        other.user == user &&
        other.postId == postId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        upVotes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        comment.hashCode ^
        userLiked.hashCode ^
        hasChildren.hashCode ^
        childrenCount.hashCode ^
        parent.hashCode ^
        rootParent.hashCode ^
        user.hashCode ^
        postId.hashCode;
  }
}

/*


  int get idToInt {
    return int.tryParse(this.id!) ?? -1;
  }

  NewPostCommentsModel({
    this.id,
    required this.upVotes,
    required this.createdAt,
    required this.updatedAt,
    required this.comment,
    required this.userLiked,
    required this.hasChildren,
    required this.childrenCount,
    this.parent,
    this.rootParent,
    this.user,
  });

  NewPostCommentsModel copyWith({
    String? id,
    int? upVotes,
    String? createdAt,
    String? updatedAt,
    String? comment,
    bool? userLiked,
    bool? hasChildren,
    int? childrenCount,
    NewPostCommentsModel? parent,
    NewPostCommentsModel? rootParent,
    VAppUser? user,
  }) {
    return NewPostCommentsModel(
      id: id ?? this.id,
      upVotes: upVotes ?? this.upVotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      comment: comment ?? this.comment,
      userLiked: userLiked ?? this.userLiked,
      hasChildren: hasChildren ?? this.hasChildren,
      childrenCount: childrenCount ?? this.childrenCount,
      parent: parent ?? this.parent,
      rootParent: rootParent ?? this.rootParent,
      user: user ?? this.user,
    );
  }



  String toJson() => json.encode(toMap());

  factory NewPostCommentsModel.fromJson(String source) =>
      NewPostCommentsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewPostCommentsModel(id: $id, upVotes: $upVotes, createdAt: $createdAt, updatedAt: $updatedAt, comment: $comment, userLiked: $userLiked, hasChildren: $hasChildren, childrenCount: $childrenCount, parent: $parent, rootParent: $rootParent, user: $user)';
  }

  @override
  bool operator ==(covariant NewPostCommentsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.upVotes == upVotes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.comment == comment &&
        other.userLiked == userLiked &&
        other.hasChildren == hasChildren &&
        other.childrenCount == childrenCount &&
        other.parent == parent &&
        other.rootParent == rootParent &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        upVotes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        comment.hashCode ^
        userLiked.hashCode ^
        hasChildren.hashCode ^
        childrenCount.hashCode ^
        parent.hashCode ^
        rootParent.hashCode ^
        user.hashCode;
  }
}

*/