import '../../../core/utils/enum/album_type.dart';

class AlbumModel {
  final String id;
  final String name;
  final AlbumType albumType;

//<editor-fold desc="Data Methods">
  const AlbumModel({
    required this.id,
    required this.name,
    required this.albumType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          albumType == other.albumType);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ albumType.hashCode;

  @override
  String toString() {
    return 'AlbumModel{ id: $id, name: $name, albumType: $albumType,}';
  }

  AlbumModel copyWith({
    String? id,
    String? name,
    AlbumType? albumType,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      name: name ?? this.name,
      albumType: albumType ?? this.albumType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'albumType': albumType.name,
    };
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      id: map['id'] as String,
      name: map['name'] as String,
      albumType: AlbumType.values.byName(map['albumType']),
    );
  }

//</editor-fold>
}