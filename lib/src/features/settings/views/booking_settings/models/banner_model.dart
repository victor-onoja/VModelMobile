import 'dart:convert';
import 'dart:io';

import 'package:vmodel/src/vmodel.dart';

@immutable
class BannerModel {
  final File? file;
  final String? bannerUrl;
  final String? bannerThumbnailUrl;
  final bool isFile;

  Map<String, dynamic> get toFileAndThumbnailMap {
    return {
      'url': '$bannerUrl',
      'thumbnail': '$bannerThumbnailUrl',
    };
  }

  BannerModel({
    this.file,
    this.bannerUrl,
    this.bannerThumbnailUrl,
    this.isFile = false,
  });

  BannerModel copyWith({
    File? file,
    String? bannerUrl,
    String? bannerThumbnailUrl,
    bool? isFile,
  }) {
    return BannerModel(
      file: file ?? this.file,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      bannerThumbnailUrl: bannerThumbnailUrl ?? this.bannerThumbnailUrl,
      isFile: isFile ?? this.isFile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file?.path,
      'bannerUrl': bannerUrl,
      'bannerThumbnailUrl': bannerThumbnailUrl,
      'isFile': isFile,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      file: map['file'] != null ? File(map['file'] ?? '') : null,
      bannerUrl: map['bannerUrl'] != null ? map['bannerUrl'] as String : null,
      bannerThumbnailUrl: map['bannerThumbnailUrl'] != null
          ? map['bannerThumbnailUrl'] as String
          : null,
      isFile: map['isFile'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(file: $file, bannerUrl: $bannerUrl, bannerThumbnailUrl: $bannerThumbnailUrl, isFile: $isFile)';
  }

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.file == file &&
        other.bannerUrl == bannerUrl &&
        other.bannerThumbnailUrl == bannerThumbnailUrl &&
        other.isFile == isFile;
  }

  @override
  int get hashCode {
    return file.hashCode ^
        bannerUrl.hashCode ^
        bannerThumbnailUrl.hashCode ^
        isFile.hashCode;
  }
}
