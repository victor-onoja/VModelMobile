// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

//Todo delete this class after all thumbnail uploads are done not really useful
class PostPhotoThumbnail {
  final String postId;
  final List<ThumbnailUrl> thumbnailUrl;

  PostPhotoThumbnail({
    required this.postId,
    required this.thumbnailUrl,
  });

  PostPhotoThumbnail copyWith({
    String? postId,
    List<ThumbnailUrl>? thumbnailUrl,
  }) {
    return PostPhotoThumbnail(
      postId: postId ?? this.postId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'thumbnailUrl': thumbnailUrl.map((x) => x.toMap()).toList(),
    };
  }

  // factory PostPhotoThumbnail.fromMap(Map<String, dynamic> map) {
  //   return PostPhotoThumbnail(
  //     postId: map['postId'] as String,
  //     thumbnailUrl: List<ThumbnailUrl>.from(
  //       (map['thumbnailUrl'] as List<int>).map<ThumbnailUrl>(
  //         (x) => ThumbnailUrl.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory PostPhotoThumbnail.fromJson(String source) =>
  //     PostPhotoThumbnail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PostPhotoThumbnail(postId: $postId, thumbnailUrl: $thumbnailUrl)';

  @override
  bool operator ==(covariant PostPhotoThumbnail other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        listEquals(other.thumbnailUrl, thumbnailUrl);
  }

  @override
  int get hashCode => postId.hashCode ^ thumbnailUrl.hashCode;
}

class ThumbnailUrl {
  final int photoId;
  final String thumbnail;
  ThumbnailUrl({
    required this.photoId,
    required this.thumbnail,
  });

  ThumbnailUrl copyWith({
    int? photoId,
    String? thumbnail,
  }) {
    return ThumbnailUrl(
      photoId: photoId ?? this.photoId,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photoId': photoId,
      'thumbnail': thumbnail,
    };
  }

  factory ThumbnailUrl.fromMap(
      int photoId, String baseUrl, Map<String, dynamic> map) {
    final thumbFile = map['sd_url'] as String;
    return ThumbnailUrl(
      photoId: photoId,
      thumbnail: '$baseUrl$thumbFile',
    );
  }

  String toJson() => json.encode(toMap());

  factory ThumbnailUrl.fromJson(int photoId, String source) {
    try {
      final map = json.decode(source) as Map<String, dynamic>;
      String baseUrl = map['base_url'] ?? '';
      return ThumbnailUrl.fromMap(photoId, baseUrl, map['data']);
    } catch (e, st) {
      print('$e $st');
      rethrow;
    }
  }

  @override
  String toString() => 'ThumbnailUrl(photoId: $photoId, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant ThumbnailUrl other) {
    if (identical(this, other)) return true;

    return other.photoId == photoId && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => photoId.hashCode ^ thumbnail.hashCode;
}
