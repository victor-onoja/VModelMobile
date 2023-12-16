// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/enum/auth_enum.dart';
import '../utils/enum/vmodel_app_themes.dart';

enum DefualtFeedView { normal, slides }

@immutable
class UserPrefsConfig {
  final ThemeMode themeMode;
  // final String preferredLightTheme;
  final VModelAppThemes preferredLightTheme;
  final AuthStatus savedAuthStatus;
  final bool isDefaultFeedViewSlides;
  final int defaulProfileColorIndex;

  UserPrefsConfig({
    required this.themeMode,
    required this.preferredLightTheme,
    required this.savedAuthStatus,
    required this.isDefaultFeedViewSlides,
    required this.defaulProfileColorIndex,
  });

  factory UserPrefsConfig.defaultConfig() {
    return UserPrefsConfig(
      themeMode: ThemeMode.system,
      preferredLightTheme: VModelAppThemes.classic,
      savedAuthStatus: AuthStatus.initial,
      isDefaultFeedViewSlides: false,
      defaulProfileColorIndex: Random().nextInt(Colors.primaries.length),
    );
  }

  UserPrefsConfig copyWith({
    ThemeMode? themeMode,
    VModelAppThemes? preferredLightTheme,
    AuthStatus? savedAuthStatus,
    bool? isDefaultFeedViewSlides,
    int? defaulProfileColorIndex,
  }) {
    return UserPrefsConfig(
      themeMode: themeMode ?? this.themeMode,
      preferredLightTheme: preferredLightTheme ?? this.preferredLightTheme,
      savedAuthStatus: savedAuthStatus ?? this.savedAuthStatus,
      isDefaultFeedViewSlides:
          isDefaultFeedViewSlides ?? this.isDefaultFeedViewSlides,
      defaulProfileColorIndex:
          defaulProfileColorIndex ?? this.defaulProfileColorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeMode': themeMode.name,
      'preferredLightTheme': preferredLightTheme.name,
      'savedAuthStatus': savedAuthStatus.name,
      'isDefaultFeedViewSlides': isDefaultFeedViewSlides,
      'defaulProfileColorIndex': defaulProfileColorIndex,
    };
  }

  factory UserPrefsConfig.fromMap(Map<String, dynamic> map) {
    try {
      return UserPrefsConfig(
        themeMode: ThemeMode.values.byName(map['themeMode'] as String),
        preferredLightTheme:
            VModelAppThemes.values.byName(map['preferredLightTheme'] as String),
        savedAuthStatus:
            AuthStatus.values.byName(map['savedAuthStatus'] as String),
        isDefaultFeedViewSlides: map['isDefaultFeedViewSlides'],
        defaulProfileColorIndex: map['defaulProfileColorIndex'] as int,
      );
    } catch (e) {
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory UserPrefsConfig.fromJson(String source) =>
      UserPrefsConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserPrefsConfig(themeMode: $themeMode, preferredLightTheme: $preferredLightTheme, savedAuthStatus: $savedAuthStatus, isDefaultFeedViewSlides: $isDefaultFeedViewSlides, defaulProfileColorIndex: $defaulProfileColorIndex)';
  }

  @override
  bool operator ==(covariant UserPrefsConfig other) {
    if (identical(this, other)) return true;

    return other.themeMode == themeMode &&
        other.preferredLightTheme == preferredLightTheme &&
        other.savedAuthStatus == savedAuthStatus &&
        other.isDefaultFeedViewSlides == isDefaultFeedViewSlides &&
        other.defaulProfileColorIndex == defaulProfileColorIndex;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^
        preferredLightTheme.hashCode ^
        savedAuthStatus.hashCode ^
        isDefaultFeedViewSlides.hashCode ^
        defaulProfileColorIndex.hashCode;
  }
}
