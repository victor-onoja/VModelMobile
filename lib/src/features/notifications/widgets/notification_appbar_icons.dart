import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsNotificationAppbarIcons extends StatelessWidget {
  final VoidCallback? onPressedClip;
  final VoidCallback? onPressedSend;
  const VWidgetsNotificationAppbarIcons({
    required this.onPressedClip,
    required this.onPressedSend,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 30,
        child: Row(
          children: [
            Flexible(
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: onPressedClip,
                    icon: const RenderSvg(
                      svgPath: VIcons.unsavedPostsIcon,
                      svgHeight: 24,
                      svgWidth: 24,
                    ))),
            Flexible(
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: onPressedSend,
                    icon: const RenderSvg(
                      svgPath: VIcons.sendWitoutNot,
                      svgHeight: 24,
                      svgWidth: 24,
                    ))),
            addHorizontalSpacing(5),
          ],
        ));
  }
}
