// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserData {
  String name;
  String imgPath;
  String subName;
  UserData({
    required this.name,
    required this.imgPath,
    required this.subName,
  });

  UserData copyWith({
    String? name,
    String? imgPath,
    String? subName,
  }) {
    return UserData(
      name: name ?? this.name,
      imgPath: imgPath ?? this.imgPath,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imgPath': imgPath,
      'subName': subName,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] as String,
      imgPath: map['imgPath'] as String,
      subName: map['subName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserData(name: $name, imgPath: $imgPath, subName: $subName)';

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.imgPath == imgPath &&
        other.subName == subName;
  }

  @override
  int get hashCode => name.hashCode ^ imgPath.hashCode ^ subName.hashCode;
}

List<UserData> userDataList() {
  return [
    UserData(name: "Georgina Powell", imgPath: "assets/images/feed_models/nadez.jpg", subName: "Georgina_Powell"),
    UserData(name: "Samantha", imgPath: "assets/images/doc/main-model.png", subName: "Samantha"),
    UserData(name: "Racheal Moses", imgPath: "assets/images/feed_models/m1.jpg", subName: "Racheal Moses"),
    UserData(name: "Georgina Powell", imgPath: "assets/images/feed_models/m13.jpg", subName: "Georgina Powell"),
  ];
}

class GetUserDataListFromStorage {
  List<UserData> userDataSavedList;
  GetUserDataListFromStorage({
    required this.userDataSavedList,
  });

  GetUserDataListFromStorage copyWith({
    List<UserData>? userDataSavedList,
  }) {
    return GetUserDataListFromStorage(
      userDataSavedList: userDataSavedList ?? this.userDataSavedList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userDataSavedList': userDataSavedList.map((x) => x.toMap()).toList(),
    };
  }

  factory GetUserDataListFromStorage.fromMap(Map<String, dynamic> map) {
    return GetUserDataListFromStorage(
      userDataSavedList: List<UserData>.from((map['userDataSavedList'] as List<int>).map<UserData>((x) => UserData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetUserDataListFromStorage.fromJson(String source) => GetUserDataListFromStorage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetUserDataListFromStorage(userDataSavedList: $userDataSavedList)';

  @override
  bool operator ==(covariant GetUserDataListFromStorage other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.userDataSavedList, userDataSavedList);
  }

  @override
  int get hashCode => userDataSavedList.hashCode;
}
