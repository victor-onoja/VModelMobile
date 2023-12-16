import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../shared/rend_paint/render_svg.dart';

class VWidgetsAppearanceDefaultIconTile extends StatefulWidget {
  final String? title;
  final bool isSelected;
  final VoidCallback onTap;
  final String svgIconAsset;

  const VWidgetsAppearanceDefaultIconTile({
    super.key,
    required this.title,
    required this.svgIconAsset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<VWidgetsAppearanceDefaultIconTile> createState() =>
      _VWidgetsAppearanceDefaultIconTileState();
}

class _VWidgetsAppearanceDefaultIconTileState
    extends State<VWidgetsAppearanceDefaultIconTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RenderSvgWithoutColor(
                      svgPath: widget.svgIconAsset,
                    ),
                    addHorizontalSpacing(24),
                    Text(
                      widget.title!,
                      style: widget.isSelected
                          ? Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                // color: VmodelColors.primaryColor,
                              )
                          : Theme.of(context).textTheme.displayMedium!.copyWith(
                                // color:
                                //     VmodelColors.primaryColor.withOpacity(0.5),
                                color: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.color
                                    ?.withOpacity(0.5),
                              ),
                    ),
                  ],
                ),
                widget.isSelected
                    ? const Icon(
                        Icons.radio_button_checked_rounded,
                        // color: VmodelColors.primaryColor,
                      )
                    : Icon(
                        Icons.radio_button_off_rounded,
                        // color: VmodelColors.primaryColor.withOpacity(0.5),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
              ],
            ),
            const Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
