// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../../res/colors.dart';
import '../../suite/views/analytics/model/two_color_gradient_model.dart';

@immutable
class QRPageColors {
  final TwoColorGradient page;
  final TwoColorGradient qr;

  QRPageColors({
    required this.page,
    required this.qr,
  });

  factory QRPageColors.defaultColors() {
    return QRPageColors(
      page: TwoColorGradient(
        begin: VmodelColors.defaultGradientBegin,
        end: VmodelColors.defaultGradientEnd,
      ),
      qr: TwoColorGradient(
        begin: VmodelColors.defaultGradientBegin,
        end: Color(0xFFFFFFFF),
      ),
    );
  }

  QRPageColors copyWith({
    TwoColorGradient? page,
    TwoColorGradient? qr,
  }) {
    return QRPageColors(
      page: page ?? this.page,
      qr: qr ?? this.qr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page.toMap(),
      'qr': qr.toMap(),
    };
  }

  factory QRPageColors.fromMap(Map<String, dynamic> map) {
    return QRPageColors(
      page: TwoColorGradient.fromMap(map['page'] as Map<String, dynamic>),
      qr: TwoColorGradient.fromMap(map['qr'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory QRPageColors.fromJson(String source) =>
      QRPageColors.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QRPageColors(page: $page, qr: $qr)';

  @override
  bool operator ==(covariant QRPageColors other) {
    if (identical(this, other)) return true;

    return other.page == page && other.qr == qr;
  }

  @override
  int get hashCode => page.hashCode ^ qr.hashCode;
}
