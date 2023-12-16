// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
class TwoColorGradient {
  final Color begin;
  final Color end;

  TwoColorGradient({
    required this.begin,
    required this.end,
  });

  TwoColorGradient copyWith({
    Color? begin,
    Color? end,
  }) {
    return TwoColorGradient(
      begin: begin ?? this.begin,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'begin': begin.value,
      'end': end.value,
    };
  }

  factory TwoColorGradient.fromMap(Map<String, dynamic> map) {
    return TwoColorGradient(
      begin: Color(map['begin'] as int),
      end: Color(map['end'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory TwoColorGradient.fromJson(String source) =>
      TwoColorGradient.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TwoColorGradient(begin: $begin, end: $end)';

  @override
  bool operator ==(covariant TwoColorGradient other) {
    if (identical(this, other)) return true;

    return other.begin == begin && other.end == end;
  }

  @override
  int get hashCode => begin.hashCode ^ end.hashCode;
}
