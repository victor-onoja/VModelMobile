import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';

class ReviewIcons extends StatelessWidget {
  const ReviewIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: VmodelColors.primaryColor,
          ),
          child: Center(child: SvgPicture.asset(VIcons.shareIcon, color: Colors.white, height: 20, width: 20,),),
        ),

        Container(
          height: 37,
          width: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: VmodelColors.primaryColor,
          ),
          child: Center(child: Text("Share", style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),),),
        )
      ],
    );
  }
}