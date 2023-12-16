import 'package:flutter/material.dart';

class SolidCircle extends StatelessWidget {
  const SolidCircle({
    super.key,
    required this.radius,
    required this.color,
  });

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
