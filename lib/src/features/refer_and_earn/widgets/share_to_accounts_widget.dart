import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class ShareToAccountsWidget extends StatelessWidget {
  final String? svgPath;
  final double size;

  final double? svgHeight;
  final double? svgWidth;
  final VoidCallback onTap;

  const ShareToAccountsWidget({
    super.key,
    required this.svgPath,
    this.size = 100.00,
    this.svgHeight,
    this.svgWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: RenderSvgWithoutColor(
            svgPath: svgPath!,
            svgHeight: svgHeight,
            svgWidth: svgWidth,
          ),
        ),
      ),
    );
  }
}
