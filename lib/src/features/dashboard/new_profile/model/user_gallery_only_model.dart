// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/utils/enum/album_type.dart';
import '../../../create_posts/models/post_set_model.dart';
import 'gallery_model.dart';

class UserGalleryOnlyModel {
  final String id;
  final String name;
  final bool hasPosts;
  final AlbumType galleryType;
  final List<AlbumPostSetModel> postSets;

  UserGalleryOnlyModel({
    required this.id,
    required this.name,
    required this.hasPosts,
    required this.galleryType,
    required this.postSets,
  });

  UserGalleryOnlyModel copyWith({
    String? id,
    String? name,
    bool? hasPosts,
    AlbumType? galleryType,
    List<AlbumPostSetModel>? postSets,
  }) {
    return UserGalleryOnlyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hasPosts: hasPosts ?? this.hasPosts,
      galleryType: galleryType ?? this.galleryType,
      postSets: postSets ?? this.postSets,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGalleryOnlyModel.fromJson(String source) =>
      UserGalleryOnlyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserGalleryOnlyModel(id: $id, name: $name, hasPosts: $hasPosts, galleryType: $galleryType, postSets: $postSets)';
  }

  @override
  bool operator ==(covariant UserGalleryOnlyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.hasPosts == hasPosts &&
        other.galleryType == galleryType &&
        listEquals(other.postSets, postSets);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        hasPosts.hashCode ^
        galleryType.hashCode ^
        postSets.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'hasPosts': hasPosts,
      'galleryType': galleryType.name,
      'postSets': postSets.map((x) => x.toMap()).toList(),
    };
  }

  factory UserGalleryOnlyModel.fromMap(Map<String, dynamic> map) {
    return UserGalleryOnlyModel(
      id: map['id'] as String,
      name: map['name'] as String,
      hasPosts: map['hasPosts'] as bool,
      galleryType: AlbumType.values.byName(map['albumType'] as String),
      postSets: [],
    );
  }

  GalleryModel get toGalleryModel {
    return GalleryModel(
      id: id,
      name: name,
      galleryType: galleryType,
      postSets: [],
    );
  }
}

/*


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'hasPosts': hasPosts,
      'albumType': galleryType.name,
    };
  }

  factory UserGalleryOnlyModel.fromMap(Map<String, dynamic> map) {
    // final postsIds = map['postSet'] as List;
    // final tempHasPosts = postsIds.isNotEmpty;
    return UserGalleryOnlyModel(
      id: map['id'] as String,
      name: map['name'] as String,
      hasPosts: map['hasPosts'] as bool,
      galleryType: AlbumType.values.byName(map['albumType'] as String),
    );
  }


 */