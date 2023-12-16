// ignore_for_file: public_member_api_docs, sort_constructors_first

class ServiceImageModel {
  final String? url;
  final String? thumbnail;

  ServiceImageModel({
    required this.url,
    required this.thumbnail,
  });

  ServiceImageModel copyWith({
    String? url,
    String? thumbnail,
  }) {
    return ServiceImageModel(
      url: url ?? this.url,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'thumbnail': thumbnail,
    };
  }

  factory ServiceImageModel.fromMap(Map<String, dynamic> map) {
    return ServiceImageModel(
      url: map['url'] as String,
      thumbnail: map['thumbnail'] as String,
    );
  }

  @override
  String toString() => 'ServiceImageModel(url: $url, thumbnail: $thumbnail)';

  @override
  bool operator ==(covariant ServiceImageModel other) {
    if (identical(this, other)) return true;

    return other.url == url && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => url.hashCode ^ thumbnail.hashCode;
}
