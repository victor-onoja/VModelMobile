// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/create_posts/models/photo_post_model.dart';

import '../../../core/models/app_user.dart';
import '../../settings/views/booking_settings/models/service_package_model.dart';

@immutable
class AlbumPostSetModel {
  final int id;
  final int albumId;
  final int likes;
  final bool userLiked;
  final bool userSaved;
  final UploadAspectRatio aspectRatio;
  final String? caption;
  final String? locationInfo;
  final VAppUser user;
  final List<VAppUser> tagged;
  final List<PhotoPostModel> photos;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ServicePackageModel? service;

  const AlbumPostSetModel({
    required this.id,
    required this.albumId,
    required this.likes,
    required this.userLiked,
    required this.userSaved,
    required this.aspectRatio,
    this.caption,
    this.locationInfo,
    required this.user,
    required this.tagged,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
    this.service,
  });

  AlbumPostSetModel copyWith({
    int? id,
    int? albumId,
    int? likes,
    bool? userLiked,
    bool? userSaved,
    UploadAspectRatio? aspectRatio,
    String? caption,
    String? locationInfo,
    VAppUser? user,
    List<VAppUser>? tagged,
    List<PhotoPostModel>? photos,
    DateTime? createdAt,
    DateTime? updatedAt,
    ServicePackageModel? service,
  }) {
    return AlbumPostSetModel(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      likes: likes ?? this.likes,
      userLiked: userLiked ?? this.userLiked,
      userSaved: userSaved ?? this.userSaved,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      caption: caption ?? this.caption,
      locationInfo: locationInfo ?? this.locationInfo,
      user: user ?? this.user,
      tagged: tagged ?? this.tagged,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'albumId': albumId,
      'likes': likes,
      'user': user.toMap(),
      'userLiked': userLiked,
      'userSaved': userSaved,
      'aspectRatio': aspectRatio.apiValue,
      'caption': caption,
      'createdAt': createdAt.toUtc(),
      'updatedAt': updatedAt.toUtc(),
      'locationInfo': locationInfo,
      'tagged': tagged.map((x) => x.toMap()).toList(),
      'photos': photos.map((x) => x.toMap()).toList(),
      'service': service?.toMap(),
    };
  }

  factory AlbumPostSetModel.fromMap(Map<String, dynamic> map) {
    try {
      print('999999922222222222 ${map['tagged']}');
      final photosJsonList = map['photos'] as List;
      final parsedPhotos = photosJsonList.map((e) => PhotoPostModel.fromMap(e));
      final parsedAspectRatio = map['aspectRatio'] ?? '';
      // final taggedUsers = map['tagged'] as List;
      final createdDateTime = DateTime.parse(map['createdAt']);
      final updatedDateTime = DateTime.parse(map['updatedAt']);
      return AlbumPostSetModel(
        id: int.tryParse(map['id']) ?? -1,
        albumId: int.tryParse(map['album']['id']) ?? -1,
        likes: map['likes'] as int,
        user: VAppUser.fromMinimalMap(map['user'] as Map<String, dynamic>),
        userLiked: map['userLiked'] as bool,
        userSaved: map['userSaved'] as bool,
        caption: map['caption'] as String?,
        aspectRatio: UploadAspectRatio.aspectRatioByApiValue(parsedAspectRatio),
        locationInfo: map['locationInfo'],
        createdAt: createdDateTime,
        updatedAt: updatedDateTime,
        // tagged: List<String>.from((map['tagged'] as List<String>)),

        // tagged: List<FeedUser>.from(
        // (map['tagged'] as List).map<FeedUser>(
        //   (x) => FeedUser.fromMap(x as Map<String, dynamic>),
        // ),
        tagged: List<VAppUser>.from(
          (map['tagged'] as List).map<VAppUser>(
            (x) => VAppUser.fromMinimalMap(x as Map<String, dynamic>),
          ),
        ),
        photos: parsedPhotos.toList(),
        service: map['service'] != null
            ? ServicePackageModel.fromMiniMap(
                map['service'] as Map<String, dynamic>)
            : null,
      );
    } catch (e, st) {
      print('OOOOOooooOOOOOooo $e \n $st');
      rethrow;
      // return AlbumPostSetModel(
      //     id: -1,
      //     albumId: -1,
      //     likes: -1,
      //     userLiked: false,
      //     userSaved: false,
      //     createdAt: DateTime.now(),
      //     updatedAt: DateTime.now(),
      //     tagged: [],
      //     aspectRatio: UploadAspectRatio.square,
      //     photos: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory AlbumPostSetModel.fromJson(String source) =>
      AlbumPostSetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlbumPostSetModel(id: $id, albumId: $albumId, likes: $likes, userLiked: $userLiked, userSaved: $userSaved, aspectRatio: $aspectRatio, caption: $caption, locationInfo: $locationInfo, user: $user, tagged: $tagged, photos: $photos, createdAt: $createdAt, updatedAt: $updatedAt, service: $service)';
  }

  @override
  bool operator ==(covariant AlbumPostSetModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.albumId == albumId &&
        other.likes == likes &&
        other.userLiked == userLiked &&
        other.userSaved == userSaved &&
        other.aspectRatio == aspectRatio &&
        other.caption == caption &&
        other.locationInfo == locationInfo &&
        other.user == user &&
        listEquals(other.tagged, tagged) &&
        listEquals(other.photos, photos) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.service == service;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        albumId.hashCode ^
        likes.hashCode ^
        userLiked.hashCode ^
        userSaved.hashCode ^
        aspectRatio.hashCode ^
        caption.hashCode ^
        locationInfo.hashCode ^
        user.hashCode ^
        tagged.hashCode ^
        photos.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        service.hashCode;
  }
}


//latest

/** 


class AlbumPostSetModel {
  final int id;
  final int albumId;
  final int likes;
  final bool userLiked;
  final bool userSaved;
  final UploadAspectRatio aspectRatio;
  final String? caption;
  final String? locationInfo;
  final VAppUser user;
  final List<VAppUser> tagged;
  final List<PhotoPostModel> photos;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AlbumPostSetModel({
    required this.id,
    required this.albumId,
    required this.likes,
    required this.userLiked,
    required this.userSaved,
    required this.aspectRatio,
    this.caption,
    this.locationInfo,
    required this.user,
    required this.tagged,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
  });

  AlbumPostSetModel copyWith({
    int? id,
    int? albumId,
    int? likes,
    bool? userLiked,
    bool? userSaved,
    UploadAspectRatio? aspectRatio,
    String? caption,
    String? locationInfo,
    VAppUser? user,
    List<VAppUser>? tagged,
    List<PhotoPostModel>? photos,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AlbumPostSetModel(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      likes: likes ?? this.likes,
      userLiked: userLiked ?? this.userLiked,
      userSaved: userSaved ?? this.userSaved,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      caption: caption ?? this.caption,
      locationInfo: locationInfo ?? this.locationInfo,
      user: user ?? this.user,
      tagged: tagged ?? this.tagged,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'albumId': albumId,
      'likes': likes,
      'user': user.toMap(),
      'userLiked': userLiked,
      'userSaved': userSaved,
      'aspectRatio': aspectRatio.apiValue,
      'caption': caption,
      'createdAt': createdAt.toUtc(),
      'updatedAt': updatedAt.toUtc(),
      'locationInfo': locationInfo,
      'tagged': tagged.map((x) => x.toMap()).toList(),
      'photos': photos.map((x) => x.toMap()).toList(),
    };
  }

  factory AlbumPostSetModel.fromMap(Map<String, dynamic> map) {
    try {
      print('999999922222222222 ${map['tagged']}');
      final photosJsonList = map['photos'] as List;
      final parsedPhotos = photosJsonList.map((e) => PhotoPostModel.fromMap(e));
      final parsedAspectRatio = map['aspectRatio'] ?? '';
      // final taggedUsers = map['tagged'] as List;
      final createdDateTime = DateTime.parse(map['createdAt']);
      final updatedDateTime = DateTime.parse(map['updatedAt']);
      return AlbumPostSetModel(
        id: int.tryParse(map['id']) ?? -1,
        albumId: int.tryParse(map['album']['id']) ?? -1,
        likes: map['likes'] as int,
        user: VAppUser.fromMinimalMap(map['user'] as Map<String, dynamic>),
        userLiked: map['userLiked'] as bool,
        userSaved: map['userSaved'] as bool,
        caption: map['caption'] as String?,
        aspectRatio: UploadAspectRatio.aspectRatioByApiValue(parsedAspectRatio),
        locationInfo: map['locationInfo'],
        createdAt: createdDateTime,
        updatedAt: updatedDateTime,
        // tagged: List<String>.from((map['tagged'] as List<String>)),

        // tagged: List<FeedUser>.from(
        // (map['tagged'] as List).map<FeedUser>(
        //   (x) => FeedUser.fromMap(x as Map<String, dynamic>),
        // ),
        tagged: List<VAppUser>.from(
          (map['tagged'] as List).map<VAppUser>(
            (x) => VAppUser.fromMinimalMap(x as Map<String, dynamic>),
          ),
        ),
        photos: parsedPhotos.toList(),
      );
    } catch (e, st) {
      print('OOOOOooooOOOOOooo $e \n $st');
      rethrow;
      // return AlbumPostSetModel(
      //     id: -1,
      //     albumId: -1,
      //     likes: -1,
      //     userLiked: false,
      //     userSaved: false,
      //     createdAt: DateTime.now(),
      //     updatedAt: DateTime.now(),
      //     tagged: [],
      //     aspectRatio: UploadAspectRatio.square,
      //     photos: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory AlbumPostSetModel.fromJson(String source) =>
      AlbumPostSetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlbumPostSetModel(id: $id, albumId: $albumId, likes: $likes, userLiked: $userLiked, userSaved: $userSaved, aspectRatio: $aspectRatio, caption: $caption, locationInfo: $locationInfo, user: $user, tagged: $tagged, photos: $photos, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant AlbumPostSetModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.albumId == albumId &&
        other.likes == likes &&
        other.userLiked == userLiked &&
        other.userSaved == userSaved &&
        other.aspectRatio == aspectRatio &&
        other.caption == caption &&
        other.locationInfo == locationInfo &&
        other.user == user &&
        listEquals(other.tagged, tagged) &&
        listEquals(other.photos, photos) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        albumId.hashCode ^
        likes.hashCode ^
        userLiked.hashCode ^
        userSaved.hashCode ^
        aspectRatio.hashCode ^
        caption.hashCode ^
        locationInfo.hashCode ^
        user.hashCode ^
        tagged.hashCode ^
        photos.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}





*/
