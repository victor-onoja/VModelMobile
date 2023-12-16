// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

@immutable
class PhotoPostModel {
  final int id;
  final String url;
  final String? thumbnail;
  final String? description;

  bool get thumbnailUnavailable => thumbnail.isEmptyOrNull;

//<editor-fold desc="Data Methods">
  const PhotoPostModel({
    required this.id,
    required this.url,
    this.thumbnail,
    this.description,
  });

  @override
  bool operator ==(covariant PhotoPostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.thumbnail == thumbnail &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        thumbnail.hashCode ^
        description.hashCode;
  }

  @override
  String toString() {
    return 'PhotoPostModel(id: $id, url: $url, thumbnail: $thumbnail, description: $description)';
  }

  PhotoPostModel copyWith({
    int? id,
    String? url,
    String? thumbnail,
    String? description,
  }) {
    return PhotoPostModel(
      id: id ?? this.id,
      url: url ?? this.url,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'itemLink': url,
      'thumbnail': thumbnail,
      'description': description,
    };
  }

  factory PhotoPostModel.fromMap(Map<String, dynamic> map) {
    return PhotoPostModel(
      id: int.tryParse(map['id']) ?? -1,
      url: map['itemLink'] as String,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

//</editor-fold>

  String toJson() => json.encode(toMap());

  factory PhotoPostModel.fromJson(String source) =>
      PhotoPostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}




// import 'package:flutter/foundation.dart';

// @immutable
// class PhotoPostModel {
//   final int id;
//   final String url;
//   final String? description;

// //<editor-fold desc="Data Methods">
//   const PhotoPostModel({
//     required this.id,
//     required this.url,
//     this.description,
//   });

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is PhotoPostModel &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           url == other.url &&
//           description == other.description);

//   @override
//   int get hashCode => id.hashCode ^ url.hashCode ^ description.hashCode;

//   @override
//   String toString() {
//     return 'PhotoPostModel{ id: $id, url: $url, description: $description,}';
//   }

//   PhotoPostModel copyWith({
//     int? id,
//     String? url,
//     String? description,
//   }) {
//     return PhotoPostModel(
//       id: id ?? this.id,
//       url: url ?? this.url,
//       description: description ?? this.description,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'itemLink': url,
//       'description': description,
//     };
//   }

//   factory PhotoPostModel.fromMap(Map<String, dynamic> map) {
//     return PhotoPostModel(
//       id: int.tryParse(map['id']) ?? -1,
//       url: map['itemLink'] as String,
//       description: (map['description'] as String?) ?? '',
//     );
//   }

// //</editor-fold>
// }
