// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

@immutable
class VellArticle {
  final String articleUrl;
  final String title;
  final String? imageUrl;

  VellArticle({
    required this.articleUrl,
    required this.title,
    this.imageUrl,
  });

  @override
  String toString() =>
      'VellArticle(articleUrl: $articleUrl, title: $title, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant VellArticle other) {
    if (identical(this, other)) return true;

    return other.articleUrl == articleUrl &&
        other.title == title &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => articleUrl.hashCode ^ title.hashCode ^ imageUrl.hashCode;
}
