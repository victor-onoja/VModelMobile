
import '../../../vmodel.dart';

class BottomNavTopIndicator extends Decoration {
  final Color color;
  BottomNavTopIndicator({required this.color});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox(color: color);
  }
}

class _TopIndicatorBox extends BoxPainter {
  final Color color;
  _TopIndicatorBox({required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..isAntiAlias = true;

    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), _paint);
  }
}
