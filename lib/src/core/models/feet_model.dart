import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class FeetModel {
  final String value;
  final String unit;

  const FeetModel({
    required this.value,
    required this.unit,
  });

  FeetModel copyWith({
    String? value,
    String? unit,
  }) {
    return FeetModel(
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

  factory FeetModel.fromMap(Map<String, dynamic> map) {
    map['value'] = map['value'] ?? '';
    map['unit'] = map['unit'] ?? '';
    return FeetModel(
      value: map['value'] as String,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeetModel.fromJson(String source) =>
      FeetModel.fromMap(json.decode(source) as Map<String, dynamic>);

 

  @override
  int get hashCode =>
      value.hashCode ^ value.hashCode;
}