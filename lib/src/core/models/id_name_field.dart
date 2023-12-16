// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class NameIDField {
  String id;
  String name;
  NameIDField({
    required this.id,
    required this.name,
  });

  NameIDField copyWith({
    String? id,
    String? name,
  }) {
    return NameIDField(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory NameIDField.fromMap(Map<String, dynamic> map) {
    return NameIDField(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NameIDField.fromJson(String source) =>
      NameIDField.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NameIDField(id: $id, name: $name)';

  @override
  bool operator ==(covariant NameIDField other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
