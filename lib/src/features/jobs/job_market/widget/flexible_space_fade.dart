import 'package:flutter/material.dart';

class FlexibleSpaceFade extends StatelessWidget {
  const FlexibleSpaceFade({super.key, required this.scrollOffset});
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: ((scrollOffset / 100).clamp(0, 1).toDouble()) < 0.7
            ? null
            : Theme.of(context)
                .scaffoldBackgroundColor
                .withOpacity((scrollOffset / 150).clamp(0, 1).toDouble()),
      ),
    );
  }
}
