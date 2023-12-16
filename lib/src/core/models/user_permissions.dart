// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../utils/enum/permission_enum.dart';

@immutable
class UserPermissionsSettings {
  final PermissionSetting whoCanMessageMe;
  final PermissionSetting whoCanFeatureMe;
  final PermissionSetting whoCanViewMyNetwork;
  final PermissionSetting whoCanConnectWithMe;

  UserPermissionsSettings({
    required this.whoCanMessageMe,
    required this.whoCanFeatureMe,
    required this.whoCanViewMyNetwork,
    required this.whoCanConnectWithMe,
  });

  UserPermissionsSettings copyWith({
    PermissionSetting? whoCanMessageMe,
    PermissionSetting? whoCanFeatureMe,
    PermissionSetting? whoCanViewMyNetwork,
    PermissionSetting? whoCanConnectWithMe,
  }) {
    return UserPermissionsSettings(
      whoCanMessageMe: whoCanMessageMe ?? this.whoCanMessageMe,
      whoCanFeatureMe: whoCanFeatureMe ?? this.whoCanFeatureMe,
      whoCanViewMyNetwork: whoCanViewMyNetwork ?? this.whoCanViewMyNetwork,
      whoCanConnectWithMe: whoCanConnectWithMe ?? this.whoCanConnectWithMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'whoCanMessageMe': whoCanMessageMe.name,
      'whoCanFeatureMe': whoCanFeatureMe.name,
      'whoCanViewMyNetwork': whoCanViewMyNetwork.name,
      'whoCanConnectWithMe': whoCanConnectWithMe.name,
    };
  }

  factory UserPermissionsSettings.fromMap(Map<String, dynamic> map) {
    return UserPermissionsSettings(
      whoCanMessageMe:
          PermissionSetting.byApiValue(map['whoCanMessageMe'] as String),
      whoCanFeatureMe:
          PermissionSetting.byApiValue(map['whoCanFeatureMe'] as String),
      whoCanViewMyNetwork:
          PermissionSetting.byApiValue(map['whoCanViewMyNetwork'] as String),
      whoCanConnectWithMe:
          PermissionSetting.byApiValue(map['whoCanConnectWithMe'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPermissionsSettings.fromJson(String source) =>
      UserPermissionsSettings.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserPermissionsSettings(whoCanMessageMe: $whoCanMessageMe, whoCanFeatureMe: $whoCanFeatureMe, whoCanViewMyNetwork: $whoCanViewMyNetwork, whoCanConnectWithMe: $whoCanConnectWithMe)';
  }

  @override
  bool operator ==(covariant UserPermissionsSettings other) {
    if (identical(this, other)) return true;

    return other.whoCanMessageMe == whoCanMessageMe &&
        other.whoCanFeatureMe == whoCanFeatureMe &&
        other.whoCanViewMyNetwork == whoCanViewMyNetwork &&
        other.whoCanConnectWithMe == whoCanConnectWithMe;
  }

  @override
  int get hashCode {
    return whoCanMessageMe.hashCode ^
        whoCanFeatureMe.hashCode ^
        whoCanViewMyNetwork.hashCode ^
        whoCanConnectWithMe.hashCode;
  }
}
