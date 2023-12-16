import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

extension StringExtension on String {
  int getNumberOfLines(TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);
    return textPainter.computeLineMetrics().length;
  }
}
