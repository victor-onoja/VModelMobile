class CommentsModel {
  String? message;
  Comment? comment;

  CommentsModel({this.message, this.comment});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    comment =
        json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.comment != null) {
      data['comment'] = this.comment!.toJson();
    }
    return data;
  }
}

class Comment {
  String? id;
  String? comment;
  int? upVotes;
  String? createdAt;
  String? updatedAt;
  bool? userLiked;
  Post? post;
  User? user;

  Comment(
      {this.id,
      this.comment,
      this.upVotes,
      this.createdAt,
      this.updatedAt,
      this.userLiked,
      this.post,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    upVotes = json['upVotes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userLiked = json['userLiked'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['upVotes'] = this.upVotes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userLiked'] = this.userLiked;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Post {
  String? id;

  Post({this.id});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? profilePicture;
  String? profilePictureUrl;

  User({this.id, this.username, this.profilePicture, this.profilePictureUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profilePicture = json['profilePicture'];
    profilePictureUrl = json['profilePictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['profilePicture'] = this.profilePicture;
    data['profilePictureUrl'] = this.profilePictureUrl;
    return data;
  }
}
