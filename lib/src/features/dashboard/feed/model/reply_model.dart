class ReplyModel {
  String? id;
  int? upVotes;
  String? createdAt;
  String? updatedAt;
  String? comment;
  bool? userLiked;
  Parent? parent;
  User? user;
  List<ReplyParent>? replyParent;

  ReplyModel(
      {this.id,
      this.upVotes,
      this.createdAt,
      this.updatedAt,
      this.comment,
      this.userLiked,
      this.parent,
      this.user,
      this.replyParent});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    upVotes = json['upVotes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    comment = json['comment'];
    userLiked = json['userLiked'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['replyParent'] != null) {
      replyParent = <ReplyParent>[];
      json['replyParent'].forEach((v) {
        replyParent!.add(new ReplyParent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['upVotes'] = this.upVotes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['comment'] = this.comment;
    data['userLiked'] = this.userLiked;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.replyParent != null) {
      data['replyParent'] = this.replyParent!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ReplyModel copyWith({
    String? id,
    int? upVotes,
    String? createdAt,
    String? updatedAt,
    String? comment,
    bool? userLiked,
    Parent? parent,
    User? user,
    List<ReplyParent>? replyParent,
  }) {
    return ReplyModel(
      id: id ?? this.id,
      upVotes: upVotes ?? this.upVotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      comment: comment ?? this.comment,
      userLiked: userLiked ?? this.userLiked,
      parent: parent ?? this.parent,
      user: user ?? this.user,
      replyParent: replyParent ?? this.replyParent,
    );
  }

  @override
  String toString() {
    return 'ReplyModel(id: $id,'
        'upVotes: $upVotes,'
        'createdAt: $createdAt,'
        'updatedAt:$updatedAt,'
        'comment: $comment,'
        'userLiked: $userLiked,'
        'parent:$parent,'
        'user:$user,)';
  }

  @override
  bool operator ==(covariant ReplyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.comment == comment &&
        other.parent == parent &&
        other.upVotes == upVotes &&
        other.updatedAt == updatedAt &&
        other.user == user &&
        other.userLiked == userLiked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        comment.hashCode ^
        parent.hashCode ^
        upVotes.hashCode ^
        updatedAt.hashCode ^
        user.hashCode ^
        userLiked.hashCode;
  }
}

class Parent {
  String? id;
  String? comment;

  Parent({this.id, this.comment});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? profilePicture;
  String? thumbnailUrl;

  User({this.id, this.username, this.profilePicture, this.thumbnailUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profilePicture = json['profilePicture'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['profilePicture'] = this.profilePicture;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class ReplyParent {
  String? comment;
  ReplyUser? replyUser;

  ReplyParent({this.comment, this.replyUser});

  ReplyParent.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    replyUser =
        json['user'] != null ? new ReplyUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    if (this.replyUser != null) {
      data['replyUser'] = this.replyUser!.toJson();
    }
    return data;
  }
}

class ReplyUser {
  String? id;
  String? username;
  String? thumbnailUrl;

  ReplyUser({this.id, this.username, this.thumbnailUrl});

  ReplyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
