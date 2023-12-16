import 'package:vmodel/src/features/create_posts/models/post_set_model.dart';

class SavedGalleryModel {
  final String id;
  final List<AlbumPostSetModel> post;

//<editor-fold desc="Data Methods">

  const SavedGalleryModel({
    required this.id,
    required this.post,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedGalleryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          post == other.post);

  @override
  int get hashCode => id.hashCode ^ post.hashCode;

  @override
  String toString() {
    return 'SavedGalleryModel{ id: $id,  post: $post,}';
  }

  SavedGalleryModel copyWith({
    String? id,
    List<AlbumPostSetModel>? postSets,
  }) {
    return SavedGalleryModel(
      id: id ?? this.id,
      post: postSets ?? post,
    );
  }

  Map<String, dynamic> toMap() {
    //Todo re-implement this
    return {
      'id': id,
      'post': post.map((e) => e.toMap()),
    };
  }

  factory SavedGalleryModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> responsePostSets = map['post'] ?? [];
    return SavedGalleryModel(
      id: map['id'] as String,
      post:
          responsePostSets.map((e) => AlbumPostSetModel.fromMap(e)).toList(),
    );
  }

//</editor-fold>
}
