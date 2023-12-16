// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Helper model to parse response from uploading post images to bucket
/// and serializing to object that the API can consume using [toApiTypeMap].
///

class ImageUploadResponseModel {
  final bool status;
  final String baseUrl;
  final String message;
  final String file_url;
  final String sd_url;
  final String extension;

  ImageUploadResponseModel({
    required this.status,
    required this.baseUrl,
    required this.message,
    required this.file_url,
    required this.sd_url,
    required this.extension,
  });

//</editor-fold>

  /// Converts object to map representing [FileUrlType] required by createPost mutation
  Map<String, dynamic> toApiTypeMap(String? caption) {
    return {
      'description': caption,
      'url': '$baseUrl$file_url',
      'thumbnail': '$baseUrl$sd_url',
      'extension': extension,
    };
  }

  Map<String, dynamic> get toFileAndThumbnailMap {
    return {
      'url': '$baseUrl$file_url',
      'thumbnail': '$baseUrl$sd_url',
    };
  }

  ImageUploadResponseModel copyWith({
    bool? status,
    String? baseUrl,
    String? message,
    String? file_url,
    String? sd_url,
    String? extension,
  }) {
    return ImageUploadResponseModel(
      status: status ?? this.status,
      baseUrl: baseUrl ?? this.baseUrl,
      message: message ?? this.message,
      file_url: file_url ?? this.file_url,
      sd_url: sd_url ?? this.sd_url,
      extension: extension ?? this.extension,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'baseUrl': baseUrl,
      'message': message,
      'file_url': file_url,
      'sd_url': sd_url,
      'extension': extension,
    };
  }

  factory ImageUploadResponseModel.fromMap(
      String baseUrl, Map<String, dynamic> map) {
    try {
      return ImageUploadResponseModel(
        status: map['status'] as bool,
        baseUrl: baseUrl,
        message: map['message'] as String,
        file_url: map['file_url'] as String,
        sd_url: map['sd_url'] as String? ?? '',
        extension: map['extension'] as String,
      );
    } catch (e, st) {
      print('$e, $st');
      rethrow;
    }
  }

  @override
  String toString() {
    return 'ImageUploadResponseModel(status: $status, baseUrl: $baseUrl, message: $message, file_url: $file_url, sd_url: $sd_url, extension: $extension)';
  }

  @override
  bool operator ==(covariant ImageUploadResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.baseUrl == baseUrl &&
        other.file_url == file_url &&
        other.sd_url == sd_url &&
        other.extension == extension;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        baseUrl.hashCode ^
        file_url.hashCode ^
        sd_url.hashCode ^
        extension.hashCode;
  }
}



/*




*/