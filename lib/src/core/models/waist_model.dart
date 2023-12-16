import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class WaistModel {
  final String value;
  final String unit;

  const WaistModel({
    required this.value,
    required this.unit,
  });

  WaistModel copyWith({
    String? value,
    String? unit,
  }) {
    return WaistModel(
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

  factory WaistModel.fromMap(Map<String, dynamic> map) {
    map['value'] = map['value'] ?? '';
    map['unit'] = map['unit'] ?? '';
    return WaistModel(
      value: map['value'] as String,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WaistModel.fromJson(String source) =>
      WaistModel.fromMap(json.decode(source) as Map<String, dynamic>);

 

  @override
  int get hashCode =>
      value.hashCode ^ value.hashCode;
}