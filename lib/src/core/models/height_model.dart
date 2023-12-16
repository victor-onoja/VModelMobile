import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class HeightModel {
  final String value;
  final String unit;

  const HeightModel({
    required this.value,
    required this.unit,
  });

  HeightModel copyWith({
    String? value,
    String? unit,
  }) {
    return HeightModel(
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'unit': unit,
    };
  }

  factory HeightModel.fromMap(Map<String, dynamic> map) {
    map['value'] = map['value'] ?? '';
    map['unit'] = map['unit'] ?? '';
    return HeightModel(
      value: map['value'] as String,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HeightModel.fromJson(String source) =>
      HeightModel.fromMap(json.decode(source) as Map<String, dynamic>);

 

  @override
  int get hashCode =>
      value.hashCode ^ value.hashCode;
}