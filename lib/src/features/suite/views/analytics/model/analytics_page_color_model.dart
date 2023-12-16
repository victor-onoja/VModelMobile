// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../../../../res/colors.dart';
import 'two_color_gradient_model.dart';

@immutable
class AnalyticsPageColors {
  final TwoColorGradient page;
  final TwoColorGradient chartBackground;

  AnalyticsPageColors({
    required this.page,
    required this.chartBackground,
  });

  factory AnalyticsPageColors.defaultColors() {
    return AnalyticsPageColors(
      page: TwoColorGradient(
        begin: VmodelColors.defaultGradientBegin,
        end: VmodelColors.defaultGradientEnd,
      ),
      chartBackground: TwoColorGradient(
        begin: VmodelColors.defaultChartGradientBegin,
        end: Color(0xFFDEDEDE),
      ),
    );
  }

  AnalyticsPageColors copyWith({
    TwoColorGradient? page,
    TwoColorGradient? chartBackground,
  }) {
    return AnalyticsPageColors(
      page: page ?? this.page,
      chartBackground: chartBackground ?? this.chartBackground,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page.toMap(),
      'chartBackground': chartBackground.toMap(),
    };
  }

  factory AnalyticsPageColors.fromMap(Map<String, dynamic> map) {
    return AnalyticsPageColors(
      page: TwoColorGradient.fromMap(map['page'] as Map<String, dynamic>),
      chartBackground: TwoColorGradient.fromMap(
          map['chartBackground'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnalyticsPageColors.fromJson(String source) =>
      AnalyticsPageColors.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AnalyticsPageColors(page: $page, chartBackground: $chartBackground)';

  @override
  bool operator ==(covariant AnalyticsPageColors other) {
    if (identical(this, other)) return true;

    return other.page == page && other.chartBackground == chartBackground;
  }

  @override
  int get hashCode => page.hashCode ^ chartBackground.hashCode;
}
