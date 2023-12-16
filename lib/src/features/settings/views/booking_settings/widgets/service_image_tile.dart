import '../../../../../res/icons.dart';
import '../../../../../res/res.dart';
import '../../../../../shared/rend_paint/render_svg.dart';
import '../../../../../vmodel.dart';

class SelectedServiceImage extends StatelessWidget {
  const SelectedServiceImage(
      {super.key, required this.image, this.onPressRemove});
  final ImageProvider image;
  final VoidCallback? onPressRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: null,
          child: Container(
            height: 100,
            width: 90,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
        ),
        // if (isImageSelected)
        Positioned(
          top: 5,
          right: 10,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
            child: GestureDetector(
              //use VIcons here
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 12,
              ),

              onTap: onPressRemove,
            ),
          ),
        ),
      ],
    );
  }
}

class AddMoreImgaeButton extends StatelessWidget {
  const AddMoreImgaeButton(
      {super.key, required this.image, this.onPressRemove});
  final ImageProvider image;
  final VoidCallback? onPressRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: AlignmentDirectional.topStart,
      children: [
        GestureDetector(
          onTap: null,
          child: Container(
            height: 100,
            width: 90,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
        ),
        // if (isImageSelected)
        Positioned(
          // alignment: Alignment.bottomRight,
          right: 0,
          child: IconButton(
              //use VIcons here
              icon: RenderSvg(
                // svgPath: VIcons.trashIcon,
                svgPath: VIcons.remove,
                color: VmodelColors.white,
              ),
              color: VmodelColors.white,
              onPressed: onPressRemove),
        ),
      ],
    );
  }
}
