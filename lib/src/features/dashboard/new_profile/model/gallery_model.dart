// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/utils/enum/album_type.dart';
import '../../../create_posts/models/post_set_model.dart';

class GalleryModel {
  final String id;
  final String name;
  final AlbumType galleryType;
  final List<AlbumPostSetModel> postSets;

//<editor-fold desc="Data Methods">

  const GalleryModel({
    required this.id,
    required this.name,
    required this.galleryType,
    required this.postSets,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GalleryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          galleryType == other.galleryType &&
          postSets == other.postSets);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ galleryType.hashCode ^ postSets.hashCode;

  @override
  String toString() {
    return 'GalleryModel{ id: $id, name: $name, galleryType: $galleryType, postSets: $postSets,}';
  }

  GalleryModel copyWith({
    String? id,
    String? name,
    AlbumType? albumType,
    List<AlbumPostSetModel>? postSets,
  }) {
    return GalleryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      galleryType: albumType ?? galleryType,
      postSets: postSets ?? this.postSets,
    );
  }

  Map<String, dynamic> toMap() {
    //Todo re-implement this
    return {
      'id': id,
      'name': name,
      'albumType': galleryType.name,
      'postSet': postSets.map((e) => e.toMap()),
    };
  }

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> responsePostSets =
        map['postSet'] ?? map['photos'] ?? [];
    final apiGalleryType =
        map['albumType'] != null ? map['albumType'] as String : null;
    return GalleryModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : "",
      galleryType: apiGalleryType != null
          ? AlbumType.values.byName(apiGalleryType)
          : AlbumType.polaroid,
      postSets:
          responsePostSets.map((e) => AlbumPostSetModel.fromMap(e)).toList(),
    );
  }

//</editor-fold>
}
