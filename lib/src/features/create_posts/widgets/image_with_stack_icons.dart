import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsStackImage extends StatelessWidget {
  final ImageProvider<Object> image;
  final VoidCallback? bottomLeftIconOnPressed;
  final VoidCallback? topRightIconOnPressed;
  final VoidCallback? onTapImage;
  final bool isImageSelected;

  const VWidgetsStackImage(
      {required this.image,
      this.bottomLeftIconOnPressed,
      this.topRightIconOnPressed,
      this.onTapImage,
      this.isImageSelected = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        GestureDetector(
          onTap: onTapImage,
          child: Container(
            height: 142,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
          ),
        ),
        // if(isImageSelected)
        // Positioned(
        //   left: 65,
        //   child: IconButton(
        //       //use VIcons here
        //       icon: Icon(
        //         Icons.edit,
        //         color: VmodelColors.white,
        //       ),
        //       onPressed: topRightIconOnPressed),
        // ),
        if (isImageSelected)
          Align(
            alignment: Alignment.bottomLeft,
            child: IconButton(
                //use VIcons here
                icon: RenderSvg(
                  // svgPath: VIcons.trashIcon,
                  svgPath: VIcons.remove,
                  color: VmodelColors.white,
                ),
                color: VmodelColors.white,
                onPressed: bottomLeftIconOnPressed),
          ),
      ],
    );
  }
}
