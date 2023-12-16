import 'package:flutter/foundation.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/vmodel.dart';

@immutable
class SearchUserModel {
  final String username;
  final String firstName;
  final String lastName;
  final String? pictureUrl;
  final String userType;
  final String? connectionStatus;

  String get fullName => '$firstName $lastName';

//<editor-fold desc="Data Methods">
  const SearchUserModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    this.connectionStatus,
    this.pictureUrl,
    required this.userType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchUserModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          pictureUrl == other.pictureUrl &&
          userType == other.userType &&
          connectionStatus == other.connectionStatus);

  @override
  int get hashCode =>
      username.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      pictureUrl.hashCode ^
      userType.hashCode ^
      connectionStatus.hashCode;

  @override
  String toString() {
    return 'SearchUserModel{ username: $username, firstName: $firstName, lastName: $lastName, pictureUrl: $pictureUrl, userType: $userType, connectionStatus: $connectionStatus}';
  }

  SearchUserModel copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? pictureUrl,
    String? userType,
    String? connectionStatus,
  }) {
    return SearchUserModel(
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        pictureUrl: pictureUrl ?? this.pictureUrl,
        userType: userType ?? this.userType,
        connectionStatus: connectionStatus ?? this.connectionStatus);
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'profilePictureUrl': pictureUrl,
      'userType': userType,
      'connectionStatus': connectionStatus,
    };
  }

  //Had to make input type Map<dynamic, dynamic> because of hive
  factory SearchUserModel.fromMap(Map<dynamic, dynamic> map) {
    final profession = map['userType'] ?? "No profession";
    final fn = map['firstName'] as String?;
    final ln = map['lastName'] as String?;
    return SearchUserModel(
      username: map['username'] as String,
      firstName: fn?.capitalizeFirstVExt ?? "No firstname",
      lastName: ln?.capitalizeFirstVExt ?? "No lastname",
      pictureUrl: map['profilePictureUrl'] as String?,
      userType: profession.toString().toUpperCase(),
      connectionStatus: map['connectionStatus'],
    );
  }

//</editor-fold>
}
