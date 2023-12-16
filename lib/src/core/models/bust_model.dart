import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class BustModel {
  final String value;
  final String unit;

  const BustModel({
    required this.value,
    required this.unit,
  });

  BustModel copyWith({
    String? value,
    String? unit,
  }) {
    return BustModel(
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

  factory BustModel.fromMap(Map<String, dynamic> map) {
    map['value'] = map['value'] ?? '';
    map['unit'] = map['unit'] ?? '';
    return BustModel(
      value: map['value'] as String,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BustModel.fromJson(String source) =>
      BustModel.fromMap(json.decode(source) as Map<String, dynamic>);

 

  @override
  int get hashCode =>
      value.hashCode ^ value.hashCode;
}