import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsBackButton extends StatelessWidget {
  final Color? buttonColor;
  final Function? onTap;
  final Function? onLongPress;
  const VWidgetsBackButton(
      {super.key, this.buttonColor, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap == null ? Navigator.pop(context) : onTap!();
      },
      onLongPress: () {
        if (onLongPress != null) onLongPress!();
      },
      child: IconButton(
        onPressed: () {
          onTap == null ? Navigator.pop(context) : onTap!();
        },
        icon:
            // RotatedBox(
            // quarterTurns: 2,
            // child:
            RenderSvg(
          svgPath: VIcons.forwardIcon,
          svgWidth: 13,
          svgHeight: 13,
          color: buttonColor ?? Theme.of(context).iconTheme.color,
        ),
        // ),
      ),
    );
  }
}
