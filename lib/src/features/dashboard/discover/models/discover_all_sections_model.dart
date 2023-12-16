import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'discover_item.dart';

@immutable
class DiscoverSectionsDataModel {
  final List<DiscoverItemObject> featuredTalents;
  final List<DiscoverItemObject> risingTalents;
  final List<DiscoverItemObject> popularTalents;
  final List<DiscoverItemObject> photographers;
  final List<DiscoverItemObject> petModels;

  DiscoverSectionsDataModel({
    required this.featuredTalents,
    required this.risingTalents,
    required this.popularTalents,
    required this.photographers,
    required this.petModels,
  });

  DiscoverSectionsDataModel copyWith({
    List<DiscoverItemObject>? featuredTalents,
    List<DiscoverItemObject>? risingTalents,
    List<DiscoverItemObject>? popularTalents,
    List<DiscoverItemObject>? photographers,
    List<DiscoverItemObject>? petModels,
  }) {
    return DiscoverSectionsDataModel(
      featuredTalents: featuredTalents ?? this.featuredTalents,
      risingTalents: risingTalents ?? this.risingTalents,
      popularTalents: popularTalents ?? this.popularTalents,
      photographers: photographers ?? this.photographers,
      petModels: petModels ?? this.petModels,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'featuredTalents': featuredTalents.map((x) => x.toMap()).toList(),
      'risingTalents': risingTalents.map((x) => x.toMap()).toList(),
      'popularTalents': popularTalents.map((x) => x.toMap()).toList(),
      'photographers': photographers.map((x) => x.toMap()).toList(),
      'petModels': petModels.map((x) => x.toMap()).toList(),
    };
  }

  factory DiscoverSectionsDataModel.fromMap(Map<String, dynamic> map) {
    return DiscoverSectionsDataModel(
      featuredTalents: List<DiscoverItemObject>.from(
        (map['featuredTalents'] as List).map<DiscoverItemObject>(
          (x) => DiscoverItemObject.fromMap(x as Map<String, dynamic>),
        ),
      ),
      risingTalents: List<DiscoverItemObject>.from(
        (map['risingTalents'] as List).map<DiscoverItemObject>(
          (x) => DiscoverItemObject.fromMap(x as Map<String, dynamic>),
        ),
      ),
      popularTalents: List<DiscoverItemObject>.from(
        (map['popularTalents'] as List).map<DiscoverItemObject>(
          (x) => DiscoverItemObject.fromMap(x as Map<String, dynamic>),
        ),
      ),
      photographers: List<DiscoverItemObject>.from(
        (map['photographers'] as List).map<DiscoverItemObject>(
          (x) => DiscoverItemObject.fromMap(x as Map<String, dynamic>),
        ),
      ),
      petModels: List<DiscoverItemObject>.from(
        (map['petModels'] as List).map<DiscoverItemObject>(
          (x) => DiscoverItemObject.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoverSectionsDataModel.fromJson(String source) =>
      DiscoverSectionsDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DiscoverDataCompleteModel(featuredTalents: $featuredTalents, risingTalents: $risingTalents, popularTalents: $popularTalents, photographers: $photographers, petModels: $petModels)';
  }

  @override
  bool operator ==(covariant DiscoverSectionsDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.featuredTalents, featuredTalents) &&
        listEquals(other.risingTalents, risingTalents) &&
        listEquals(other.popularTalents, popularTalents) &&
        listEquals(other.photographers, photographers) &&
        listEquals(other.petModels, petModels);
  }

  @override
  int get hashCode {
    return featuredTalents.hashCode ^
        risingTalents.hashCode ^
        popularTalents.hashCode ^
        photographers.hashCode ^
        petModels.hashCode;
  }
}
