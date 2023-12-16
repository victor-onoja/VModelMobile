// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class LocationData {
  final double latitude;
  final double longitude;
  final String locationName;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  LocationData copyWith({
    double? latitude,
    double? longitude,
    String? locationName,
  }) {
    return LocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
    };
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    // print('WWWWWWWWwwow location is $map');

    try {
      double lat = 0;
      double lon = 0;
      if (map['latitude'] is String) {
        lat = double.tryParse(map['latitude']) ?? 0.0;
      } else {
        lat = map['latitude'] ?? 0;
      }
      if (map['longitude'] is String) {
        lon = double.tryParse(map['longitude']) ?? 0.0;
      } else {
        lon = map['longitude'] ?? 0;
      }
      return LocationData(
        latitude: lat,
        longitude: lon,
        locationName: map['locationName'] as String? ?? 'No Location',
      );
    } catch (e, st) {
      print('Exception parsing location $e $st');
      return const LocationData(
          latitude: 0, longitude: 0, locationName: 'No location');
    }
  }

  String toJson() => json.encode(toMap());

  factory LocationData.fromJson(String source) =>
      LocationData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Location(latitude: $latitude, longitude: $longitude, locationName: $locationName)';

  @override
  bool operator ==(covariant LocationData other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.locationName == locationName;
  }

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ locationName.hashCode;
}
