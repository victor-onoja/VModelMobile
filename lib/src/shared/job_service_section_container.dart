import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    required this.topRadius,
    required this.bottomRadius,
    this.padding,
    this.width = double.maxFinite,
    this.height = 100,
    this.color,
  });

  final Widget child;
  final double width;
  final double height;
  final double topRadius;
  final double bottomRadius;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color ?? null,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(topRadius),
              bottom: Radius.circular(bottomRadius))),
      child: child,
    );
  }
}
