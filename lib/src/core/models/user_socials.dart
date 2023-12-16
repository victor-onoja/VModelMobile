// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:vmodel/src/core/utils/validators_mixins.dart';

@immutable
class UserSocialInfo {
  String? username;
  int? noOfFollows;

  bool get hasUsername => !username.isEmptyOrNull;

  UserSocialInfo({
    this.username,
    this.noOfFollows,
  });

  UserSocialInfo copyWith({
    String? username,
    int? noOfFollows,
  }) {
    return UserSocialInfo(
      username: username ?? this.username,
      noOfFollows: noOfFollows ?? this.noOfFollows,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'noOfFollows': noOfFollows,
    };
  }

  factory UserSocialInfo.fromMap(Map<String, dynamic> map) {
    return UserSocialInfo(
      username: map['username'] as String?,
      noOfFollows: map['noOfFollows'] as int?,
    );
  }

  @override
  String toString() =>
      'UserSocialInfo(username: $username, noOfFollows: $noOfFollows)';

  @override
  bool operator ==(covariant UserSocialInfo other) {
    if (identical(this, other)) return true;

    return other.username == username && other.noOfFollows == noOfFollows;
  }

  @override
  int get hashCode => username.hashCode ^ noOfFollows.hashCode;
}

@immutable
class UserSocials {
  final UserSocialInfo? facebook;
  final UserSocialInfo? instagram;
  final UserSocialInfo? tiktok;
  final UserSocialInfo? pinterest;
  final UserSocialInfo? youtube;
  final UserSocialInfo? twitter;
  final UserSocialInfo? linkedin;
  final UserSocialInfo? patreon;
  final UserSocialInfo? reddit;
  final UserSocialInfo? snapchat;

  bool get hasSocial =>
      (facebook != null && facebook!.hasUsername) ||
      (instagram != null && instagram!.hasUsername) ||
      (tiktok != null && tiktok!.hasUsername) ||
      (pinterest != null && pinterest!.hasUsername) ||
      (youtube != null && youtube!.hasUsername) ||
      (twitter != null && twitter!.hasUsername) ||
      (linkedin != null && linkedin!.hasUsername) ||
      (patreon != null && patreon!.hasUsername) ||
      (reddit != null && reddit!.hasUsername) ||
      (snapchat != null && snapchat!.hasUsername);

  String getSocialLink({required String social}) {
    final socialLowerCased = social.toLowerCase();
    if (socialLowerCased == 'instagram') {
      return instagram != null
          ? "https://www.instagram.com/$instagram/"
          : "https://www.instagram.com";
    } else if (socialLowerCased == 'tiktok') {
      return tiktok != null
          ? "https://www.tiktok.com/$tiktok"
          : "https://www.tiktok.com";
    } else if (socialLowerCased == 'youtube') {
      return youtube != null
          ? "https://www.youtube.com/$youtube"
          : "https://www.youtube.com";
    } else if (socialLowerCased == 'twitter') {
      return twitter != null
          ? "https://www.twitter.com/$twitter"
          : "https://www.twitter.com";
    } else if (socialLowerCased == 'facebook') {
      return facebook != null
          ? "https://www.facebook.com/$facebook"
          : "https://www.facebook.com";
    } else if (socialLowerCased == 'pinterest') {
      return pinterest != null
          ? "https://www.pinterest.com/$pinterest"
          : "https://www.pinterest.com";
    } else if (socialLowerCased == 'snapchat') {
      return snapchat != null
          ? "https://www.snapchat.com/$snapchat"
          : "https://www.snapchat.com";
    } else if (socialLowerCased == 'reddit') {
      return reddit != null
          ? "https://www.reddit.com/$reddit"
          : "https://www.reddit.com";
    } else if (socialLowerCased == 'patreon') {
      return patreon != null
          ? "https://www.patreon.com/$patreon"
          : "https://www.patreon.com";
    } else if (socialLowerCased == 'linkedin') {
      return linkedin != null
          ? "https://www.linkedin.com/$linkedin"
          : "https://www.linkedin.com";
    }
    return 'https://vmodel.app';
  }

  UserSocials({
    this.facebook,
    this.instagram,
    this.tiktok,
    this.pinterest,
    this.youtube,
    this.twitter,
    this.linkedin,
    this.patreon,
    this.reddit,
    this.snapchat,
  });

  UserSocials copyWith({
    UserSocialInfo? facebook,
    UserSocialInfo? instagram,
    UserSocialInfo? tiktok,
    UserSocialInfo? pinterest,
    UserSocialInfo? youtube,
    UserSocialInfo? twitter,
    UserSocialInfo? linkedin,
    UserSocialInfo? patreon,
    UserSocialInfo? reddit,
    UserSocialInfo? snapchat,
  }) {
    return UserSocials(
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      tiktok: tiktok ?? this.tiktok,
      pinterest: pinterest ?? this.pinterest,
      youtube: youtube ?? this.youtube,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      patreon: patreon ?? this.patreon,
      reddit: reddit ?? this.reddit,
      snapchat: snapchat ?? this.snapchat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'facebook': facebook?.toMap(),
      'instagram': instagram?.toMap(),
      'tiktok': tiktok?.toMap(),
      'pinterest': pinterest?.toMap(),
      'youtube': youtube?.toMap(),
      'twitter': twitter?.toMap(),
      'linkedin': linkedin?.toMap(),
      'patreon': patreon?.toMap(),
      'reddit': reddit?.toMap(),
      'snapchat': snapchat?.toMap(),
    };
  }

  factory UserSocials.fromMap(Map<String, dynamic> map) {
    try {
      return UserSocials(
        facebook: map['facebook'] != null
            ? UserSocialInfo.fromMap(map['facebook'] as Map<String, dynamic>)
            : null,
        instagram: map['instagram'] != null
            ? UserSocialInfo.fromMap(map['instagram'] as Map<String, dynamic>)
            : null,
        tiktok: map['tiktok'] != null
            ? UserSocialInfo.fromMap(map['tiktok'] as Map<String, dynamic>)
            : null,
        pinterest: map['pinterest'] != null
            ? UserSocialInfo.fromMap(map['pinterest'] as Map<String, dynamic>)
            : null,
        youtube: map['youtube'] != null
            ? UserSocialInfo.fromMap(map['youtube'] as Map<String, dynamic>)
            : null,
        twitter: map['twitter'] != null
            ? UserSocialInfo.fromMap(map['twitter'] as Map<String, dynamic>)
            : null,
        linkedin: map['linkedin'] != null
            ? UserSocialInfo.fromMap(map['linkedin'] as Map<String, dynamic>)
            : null,
        patreon: map['patreon'] != null
            ? UserSocialInfo.fromMap(map['patreon'] as Map<String, dynamic>)
            : null,
        reddit: map['reddit'] != null
            ? UserSocialInfo.fromMap(map['reddit'] as Map<String, dynamic>)
            : null,
        snapchat: map['snapchat'] != null
            ? UserSocialInfo.fromMap(map['snapchat'] as Map<String, dynamic>)
            : null,
      );
    } catch (e, st) {
      print('[yy2] $e, $st');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory UserSocials.fromJson(String source) =>
      UserSocials.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSocials(facebook: $facebook, instagram: $instagram, tiktok: $tiktok, pinterest: $pinterest, youtube: $youtube, twitter: $twitter,snapchat: $snapchat, tiktok: $tiktok, reddit: $reddit, patreon: $patreon,linkedin: $linkedin)';
  }

  @override
  bool operator ==(covariant UserSocials other) {
    if (identical(this, other)) return true;

    return other.facebook == facebook &&
        other.instagram == instagram &&
        other.tiktok == tiktok &&
        other.pinterest == pinterest &&
        other.youtube == youtube &&
        other.linkedin == linkedin &&
        other.patreon == patreon &&
        other.reddit == reddit &&
        other.snapchat == snapchat &&
        other.twitter == twitter;
  }

  @override
  int get hashCode {
    return facebook.hashCode ^
        instagram.hashCode ^
        tiktok.hashCode ^
        pinterest.hashCode ^
        youtube.hashCode ^
        linkedin.hashCode ^
        reddit.hashCode ^
        snapchat.hashCode ^
        patreon.hashCode ^
        twitter.hashCode;
  }

//</editor-fold>
}

//Helper method to get social url


/**
 






 */
