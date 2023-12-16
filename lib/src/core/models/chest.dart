import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class ChestModel {
  final String value;
  final String unit;

  const ChestModel({
    required this.value,
    required this.unit,
  });

  ChestModel copyWith({
    String? value,
    String? unit,
  }) {
    return ChestModel(
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

  factory ChestModel.fromMap(Map<String, dynamic> map) {
    map['value'] = map['value'] ?? '';
    map['unit'] = map['unit'] ?? '';
    return ChestModel(
      value: map['value'] as String,
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChestModel.fromJson(String source) =>
      ChestModel.fromMap(json.decode(source) as Map<String, dynamic>);

 

  @override
  int get hashCode =>
      value.hashCode ^ value.hashCode;
}