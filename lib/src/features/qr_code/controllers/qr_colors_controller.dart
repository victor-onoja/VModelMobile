import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../suite/views/analytics/model/two_color_gradient_model.dart';
import '../models/qr_page_colors.dart';

// final
final qrPageColorsProvider =
    NotifierProvider<QRPageColorNotifier, QRPageColors>(
        QRPageColorNotifier.new);

class QRPageColorNotifier extends Notifier<QRPageColors> {
  @override
  QRPageColors build() {
    return QRPageColors.defaultColors();
  }

  void updateColors({
    Color? pageBegin,
    Color? pageEnd,
    Color? qrCodeColor,
    Color? qrBackground,
  }) {
    state = state.copyWith(
      page: state.page.copyWith(begin: pageBegin, end: pageEnd),
      qr: state.qr.copyWith(begin: qrCodeColor, end: qrBackground),
    );
  }

  void updateGradients({
    TwoColorGradient? page,
    TwoColorGradient? qr,
  }) {
    state = state.copyWith(
      page: page,
      qr: qr,
    );
  }

  void applyDefaults() {
    state = QRPageColors.defaultColors();
  }
}
