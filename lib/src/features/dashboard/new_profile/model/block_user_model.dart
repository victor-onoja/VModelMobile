// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vmodel/src/res/res.dart';

class BlockUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String? displayName;
  final String userType;
  final String label;
  final bool isVerified;
  final bool blueTickVerified;
  final String? profilePictureUrl;
  final String? thumbnailUrl;

  BlockUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.displayName,
    required this.userType,
    required this.label,
    required this.isVerified,
    required this.blueTickVerified,
    this.profilePictureUrl,
    this.thumbnailUrl,
  });

  BlockUserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? displayName,
    String? userType,
    String? label,
    bool? isVerified,
    bool? blueTickVerified,
    String? profilePictureUrl,
    String? thumbnailUrl,
  }) {
    return BlockUserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      userType: userType ?? this.userType,
      label: label ?? this.label,
      isVerified: isVerified ?? this.isVerified,
      blueTickVerified: blueTickVerified ?? this.blueTickVerified,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'displayName': displayName,
      'userType': userType,
      'label': label,
      'isVerified': isVerified,
      'blueTickVerified': blueTickVerified,
      'profilePictureUrl': profilePictureUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory BlockUserModel.fromMap(Map<String, dynamic> map) {
    return BlockUserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      userType: map['userType'] ?? 'No talent',
      label: map['label'] ?? VMString.noSubTalentErrorText,
      isVerified: (map['isVerified'] as bool?) ?? false,
      blueTickVerified: (map['blueTickVerified'] as bool?) ?? false,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      profilePictureUrl: map['profilePictureUrl'] != null
          ? map['profilePictureUrl'] as String
          : null,
      thumbnailUrl:
          map['thumbnailUrl'] != null ? map['thumbnailUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockUserModel.fromJson(String source) =>
      BlockUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlockUserModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, displayName: $displayName, userType: $userType, label: $label, isVerified: $isVerified, blueTickVerified: $blueTickVerified, profilePictureUrl: $profilePictureUrl, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(covariant BlockUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.displayName == displayName &&
        other.userType == userType &&
        other.label == label &&
        other.isVerified == isVerified &&
        other.blueTickVerified == blueTickVerified &&
        other.profilePictureUrl == profilePictureUrl &&
        other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        displayName.hashCode ^
        userType.hashCode ^
        label.hashCode ^
        isVerified.hashCode ^
        blueTickVerified.hashCode ^
        thumbnailUrl.hashCode ^
        profilePictureUrl.hashCode;
  }
}


/**
//
//
//

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'userType': userType,
      'label': label,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  factory BlockUserModel.fromMap(Map<String, dynamic> map) {
    return BlockUserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      userType: map['userType'] ?? 'No talent',
      label: map['label'] ?? VMString.noSubTalentErrorText,
      profilePictureUrl: map['profilePictureUrl'] != null
          ? map['profilePictureUrl'] as String
          : null,
    );
  }


  factory BlockUserModel.fromMap(Map<String, dynamic> map) {
    return BlockUserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      profilePictureUrl: map['profilePictureUrl'] != null ? map['profilePictureUrl'] as String : null,
    );
  }

/
//
//
// */