import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class VWidgetsPictureAvataStyle extends StatelessWidget {
  final String? imagePath;
  final double imageHeight;
  final double imageWidth;
  const VWidgetsPictureAvataStyle(
      {super.key,
      required this.imagePath,
      required this.imageHeight,
      required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: VModelBoxDecoration.avatarDecoration.copyWith(
          color: VmodelColors.appBarBackgroundColor,
        ),
        width: imageWidth,
        height: imageWidth,
        child: imagePath == null
            ? const RenderSvg(
                svgPath: "assets/images/tap_icon.svg",
                svgHeight: 37,
                svgWidth: 18,
              )
            : Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: VModelBoxDecoration.avatarDecoration.copyWith(
                      color: VmodelColors.appBarBackgroundColor,
                      image: DecorationImage(
                        image: AssetImage(
                          imagePath!,
                        ),
                        fit: BoxFit.cover,
                      )),
                  width: 50,
                  height: 50,
                ),
              ),
      ),
    );
  }
}
