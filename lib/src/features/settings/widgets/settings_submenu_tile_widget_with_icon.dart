import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsSettingsSubMenuWithSuffixTileWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String svgPath;
  const VWidgetsSettingsSubMenuWithSuffixTileWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: RenderSvg(
                      svgPath: svgPath,
                      svgHeight: 24,
                      svgWidth: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  addHorizontalSpacing(16),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
