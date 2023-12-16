import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:vmodel/src/vmodel.dart';

class MyCommentChildWidget extends StatelessWidget {
  final PreferredSizeWidget? replyToContent;
  // final Widget? replyIcon;
  final bool? isLast;
  final Size? avatarRoot;
  // final replyToColor = Colors.pink;

  const MyCommentChildWidget({
    required this.isLast,
    required this.replyToContent,
    // required this.replyIcon,
    required this.avatarRoot,
  });

  @override
  Widget build(BuildContext context) {
    final replyToColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.5);
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : avatarRoot!.width + 8.0,
        bottom: 0,
        top: 0,
        right: isRTL ? avatarRoot!.width + 8.0 : 0);

    return CustomPaint(
      painter: _Painter(
        isLast: isLast!,
        padding: padding,
        textDirection: Directionality.of(context),
        avatarRoot: avatarRoot,
        avatarChild: replyToContent!.preferredSize,
        pathColor: replyToColor,
        // pathColor: Colors.grey.shade300,
        strokeWidth: 1,
      ),
      child: Container(
        // padding: padding,
        margin: EdgeInsets.fromLTRB(
          padding.left + 4,
          padding.top,
          padding.right,
          padding.bottom,
        ),
        // color: Colors.blue.shade300,

        // decoration: BoxDecoration(
        //   color: Colors.grey.shade300,
        //   borderRadius: BorderRadius.circular(7),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              // flex: 2,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  // width: 68.w,
                  // constraints: BoxConstraints(
                  //   minWidth: 38.w,
                  //   maxWidth: 68.w,
                  // ),
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade300,
                    color: replyToColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: replyToContent!),
            ),
            // Expanded(child: const SizedBox(width: 8)),
            const SizedBox(width: 8),
            // replyIcon!,
          ],
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  bool isLast = false;

  EdgeInsets? padding;
  final TextDirection textDirection;
  Size? avatarRoot;
  Size? avatarChild;
  Color? pathColor;
  double? strokeWidth;

  _Painter({
    required this.isLast,
    required this.textDirection,
    this.padding,
    this.avatarRoot,
    this.avatarChild,
    this.pathColor,
    this.strokeWidth,
  }) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    if (textDirection == TextDirection.rtl) canvas.translate(size.width, 0);
    double rootDx = avatarRoot!.width / 2;
    if (textDirection == TextDirection.rtl) rootDx *= -1;
    // path.moveTo(rootDx * 4, 0);
    // path.moveTo(20, 20);
    // path.cubicTo(
    //   rootDx,
    //   0,
    //   rootDx,
    //   padding!.top + avatarChild!.height / 2,
    //   rootDx * 2,
    //   padding!.top + avatarChild!.height / 2,
    // );
    // Path path = Path();

    /// Almost
    // final double _xScaling = rootDx;
    // final double _yScaling = avatarChild!.height / 2;
    // // path.moveTo(rootDx * 4, _yScaling * 2);
    // path.cubicTo(
    //   0.01 * _xScaling,
    //   1.01 * _yScaling,
    //   1.01 * _xScaling,
    //   // 6.99601 * _yScaling,
    //   7.01 * _yScaling,
    //   1.01 * _xScaling,
    //   // 6.99601 * _yScaling,
    //   7.01 * _yScaling,
    // );
    // canvas.drawPath(path, _paint);

    // path.arcToPoint(
    //   Offset(20, 40),
    //   radius: Radius.circular(20),
    //   // rotation: 5,
    //   clockwise: false,
    // );

    // path.addArc(
    //     Rect.fromLTWH(rootDx, avatarChild!.height, rootDx * 3,
    //         5 * padding!.top + avatarChild!.height),
    //     degToRad(180),
    //     degToRad(360));
    final olo = avatarChild!.height / 2;
    path.moveTo(avatarChild!.width + 6 + 4, olo);
    path.cubicTo(
      15,
      olo,
      15,
      olo,
      15,
      avatarChild!.height + 2,
    );
    canvas.drawPath(path, _paint);

    //Last attempt

    // if (!isLast) {
    //   canvas.drawLine(
    //     Offset(rootDx, 0),
    //     Offset(rootDx, size.height),
    //     _paint,
    //   );
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // Method to convert degree to radians
  double degToRad(num deg) => deg * (math.pi / 180.0);
}
