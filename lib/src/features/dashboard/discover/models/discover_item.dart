// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

final lll = "Hi, I'm a model with ABC Model Agency in San Francisco, CA who is"
    " interested in building Hi, I'm a model with ABC Model Agency in San"
    "  Francisco, CA who is interested in building Hi, I'm a model with ABC"
    " Model Agency in San Francisco, CA who is interested in building";

class DiscoverItemObject {
  final String username;
  final String name;
  final String userType;
  String? label;
  final String image;
  final String age = '22';
  final String points;
  String? height = "5'10";
  String? gender = 'Female';
  String? ethnicity = 'Caucasian';
  String? hair = 'Brown';
  String? price = 'hair';
  String? location;
  String? description = lll;
  String? bio = "";
  final bool isBusinessAccount;
  final bool isVerified;
  final bool blueTickVerified;

  String get labelOrUserType => label ?? userType ?? 'No user type';

  DiscoverItemObject({
    required this.username,
    required this.name,
    required this.userType,
    required this.image,
    this.points = '4.9',
    this.label,
    this.height,
    this.gender,
    this.ethnicity,
    this.hair,
    this.price,
    this.location,
    this.description,
    this.bio,
    this.isBusinessAccount = false,
    this.isVerified = false,
    this.blueTickVerified = false,
  });

  DiscoverItemObject copyWith({
    String? username,
    String? name,
    String? userType,
    String? label,
    String? image,
    String? points,
    String? height,
    String? gender,
    String? ethnicity,
    String? hair,
    String? price,
    String? location,
    String? description,
    String? bio,
    bool? isBusiness,
    bool? isVerified,
    bool? blueTickVerified,
  }) {
    return DiscoverItemObject(
      username: username ?? this.username,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      label: label ?? this.label,
      image: image ?? this.image,
      points: points ?? this.points,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      ethnicity: ethnicity ?? this.ethnicity,
      hair: hair ?? this.hair,
      price: price ?? this.price,
      location: location ?? this.location,
      description: description ?? this.description,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
      isBusinessAccount: isBusinessAccount ?? this.isBusinessAccount,
      blueTickVerified: blueTickVerified ?? this.blueTickVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'userType': userType,
      'label': label,
      'image': image,
      'points': points,
      'height': height,
      'gender': gender,
      'ethnicity': ethnicity,
      'hair': hair,
      'price': price,
      'location': location,
      'description': description,
      'bio': bio,
      'isBusinessAccount': isBusinessAccount,
      'isVerified': isVerified,
      'blueTickVerified': blueTickVerified,
    };
  }

  factory DiscoverItemObject.fromMap(Map<String, dynamic> map) {
    try {
      final heightMapData = map['height'];
      String heightValue = '';
      if (heightMapData != null && heightMapData['value'] != null) {
        // print('[llk] ${.runtimeType}');
        heightValue = "${heightMapData['value']}";
      }

      return DiscoverItemObject(
        username: map['username'] as String,
        name: map['firstName'] as String,
        userType: map['userType'] as String,
        label: map['label'] as String?,
        image: map['profilePictureUrl'] as String,
        points: '4.9',
        height: heightValue,
        gender: map['gender'] != null ? map['gender'] as String : null,
        ethnicity: map['ethnicity'] != null ? map['ethnicity'] as String : null,
        hair: map['hair'] != null ? map['hair'] as String : null,
        price: map['price'] != null ? "${map['price']}" : null,
        location: map['location'] != null
            ? map['location']['locationName'] as String?
            : null,
        description:
            map['description'] != null ? map['description'] as String : null,
        bio: map['bio'] != null ? map['bio'] as String : null,
        isBusinessAccount: map['isBusinessAccount'] as bool,
        isVerified: map['isVerified'] as bool,
        blueTickVerified: map['blueTickVerified'] as bool,
      );
    } catch (e, st) {
      print('s[coolllllllll] $e \n $st');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory DiscoverItemObject.fromJson(String source) =>
      DiscoverItemObject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiscoverItemObject(username: $username,  userType: $userType,'
        ' name: $name, label: $label, image: $image, points: $points,'
        ' height: $height, gender: $gender, ethnicity: $ethnicity, hair: $hair,'
        ' price: $price, location: $location, description: $description,'
        ' bio: $bio, isVerified: $isVerified, blueTickVerified: $blueTickVerified,'
        'isBusinessAccount: $isBusinessAccount,)';
  }

  @override
  bool operator ==(covariant DiscoverItemObject other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.name == name &&
        other.userType == userType &&
        other.label == label &&
        other.image == image &&
        other.points == points &&
        other.height == height &&
        other.gender == gender &&
        other.ethnicity == ethnicity &&
        other.hair == hair &&
        other.price == price &&
        other.location == location &&
        other.description == description &&
        other.bio == bio &&
        other.isBusinessAccount == isBusinessAccount &&
        other.isVerified == isVerified &&
        other.blueTickVerified == blueTickVerified;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        name.hashCode ^
        userType.hashCode ^
        label.hashCode ^
        image.hashCode ^
        points.hashCode ^
        height.hashCode ^
        gender.hashCode ^
        ethnicity.hashCode ^
        hair.hashCode ^
        price.hashCode ^
        location.hashCode ^
        description.hashCode ^
        bio.hashCode ^
        isVerified.hashCode ^
        isBusinessAccount.hashCode ^
        blueTickVerified.hashCode;
  }
}





/**
 * 
 * 


 
 * 
 */