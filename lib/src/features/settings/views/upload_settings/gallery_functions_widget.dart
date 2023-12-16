import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsGalleryFunctionsCard extends StatelessWidget {
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;
  final String? title;
  const VWidgetsGalleryFunctionsCard(
      {required this.title,
      required this.onTapEdit,
      required this.onTapDelete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor),
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: onTapEdit,
                      child: const RenderSvg(svgPath: VIcons.galleryEdit)),
                  addHorizontalSpacing(12),
                  GestureDetector(
                      onTap: onTapDelete,
                      child: const RenderSvg(svgPath: VIcons.remove)),
                ],
              )
            ],
          ),
          const Divider(
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
