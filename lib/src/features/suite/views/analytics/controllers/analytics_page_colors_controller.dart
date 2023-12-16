import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/analytics_page_color_model.dart';
import '../model/two_color_gradient_model.dart';

// final
final analyticsPageColorsProvider =
    NotifierProvider<AnalyticsPageColorNotifier, AnalyticsPageColors>(
        AnalyticsPageColorNotifier.new);

class AnalyticsPageColorNotifier extends Notifier<AnalyticsPageColors> {
  @override
  AnalyticsPageColors build() {
    return AnalyticsPageColors.defaultColors();
  }

  void updateColors({
    Color? pageBegin,
    Color? pageEnd,
    Color? chartBegin,
    Color? chartEnd,
  }) {
    state = state.copyWith(
      page: state.page.copyWith(begin: pageBegin, end: pageEnd),
      chartBackground:
          state.chartBackground.copyWith(begin: chartBegin, end: chartEnd),
    );
  }

  void updateGradients({
    TwoColorGradient? page,
    TwoColorGradient? chartBacground,
  }) {
    state = state.copyWith(
      page: page,
      chartBackground: chartBacground,
    );
  }

  void applyDefaults() {
    state = AnalyticsPageColors.defaultColors();
  }
}
