// To parse this JSON data, do
//
//     final featuredTalent = featuredTalentFromJson(jsonString);

import 'dart:convert';

class FeaturedTalent {
    String? typename;
    int? id;
    String? firstName;
    String? lastName;
    String? username;
    String? label;
    String? profilePicture;
    String? profilePictureUrl;

    FeaturedTalent({
        this.typename,
        this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.label,
        this.profilePicture,
        this.profilePictureUrl,
    });

    FeaturedTalent copyWith({
        String? typename,
        int? id,
        String? firstName,
        String? lastName,
        String? username,
        String? label,
        String? profilePicture,
        String? profilePictureUrl,
    }) => 
        FeaturedTalent(
            typename: typename ?? this.typename,
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            username: username ?? this.username,
            label: label ?? this.label,
            profilePicture: profilePicture ?? this.profilePicture,
            profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        );

    factory FeaturedTalent.fromRawJson(String str) => FeaturedTalent.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FeaturedTalent.fromJson(Map<String, dynamic> json) => FeaturedTalent(
        typename: json["__typename"],
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        label: json["label"],
        profilePicture: json["profilePicture"],
        profilePictureUrl: json["profilePictureUrl"],
    );

    Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "label": label,
        "profilePicture": profilePicture,
        "profilePictureUrl": profilePictureUrl,
    };
}
