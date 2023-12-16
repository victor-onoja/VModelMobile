// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class PhoneNumberModel {
  final String number;
  final String countryCode;
  final String? e164Number;

  const PhoneNumberModel({
    required this.number,
    required this.countryCode,
    this.e164Number,
  });

  PhoneNumberModel copyWith({
    String? number,
    String? countryCode,
    String? e164Number,
  }) {
    return PhoneNumberModel(
      number: number ?? this.number,
      countryCode: countryCode ?? this.countryCode,
      e164Number: e164Number ?? this.e164Number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'countryCode': countryCode,
      'completed': e164Number,
    };
  }

  factory PhoneNumberModel.fromMap(Map<String, dynamic> map) {
    map['number'] = map['number'] ?? '';
    map['countryCode'] = map['countryCode'] ?? '';
    return PhoneNumberModel(
      number: map['number'] as String,
      countryCode: map['countryCode'] as String,
      e164Number: map['completed'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneNumberModel.fromJson(String source) =>
      PhoneNumberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PhoneNumberModel(number: $number, countryCode: $countryCode, completed: $e164Number)';

  @override
  bool operator ==(covariant PhoneNumberModel other) {
    if (identical(this, other)) return true;

    return other.number == number &&
        other.countryCode == countryCode &&
        other.e164Number == e164Number;
  }

  @override
  int get hashCode =>
      number.hashCode ^ countryCode.hashCode ^ e164Number.hashCode;
}
