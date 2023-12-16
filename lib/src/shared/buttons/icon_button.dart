import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsIconButton extends StatelessWidget {
  final String? buttonTitle;
  final Function()? onPressed;
  final bool? enableButton;
  final double? butttonWidth;
  final double? buttonHeight;
  final TextStyle? buttonTitleTextStyle;
  final Color? buttonColor;
  final Color? splashColor;
  final double? borderRadius;
  const VWidgetsIconButton({
    super.key,
    required this.onPressed,
    this.buttonTitle,
    this.enableButton,
    this.buttonHeight,
    this.buttonTitleTextStyle,
    this.splashColor,
    this.buttonColor,
    this.butttonWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      onPressed: enableButton == true ? onPressed : null,
      disabledColor: VmodelColors.greyColor.withOpacity(0.2),
      disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.2),
      elevation: 0,
      minWidth: butttonWidth ?? MediaQuery.of(context).size.width / 1,
      height: buttonHeight ?? 40,
      textColor: VmodelColors.vModelprimarySwatch,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: VmodelColors.vModelprimarySwatch,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 8),
        ),
      ),
      splashColor: splashColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          const Icon(Icons.chat_outlined),
          Text(
          buttonTitle ?? "",
          style: enableButton == true
              ? buttonTitleTextStyle ??
              Theme.of(context).textTheme.displayLarge!.copyWith(
                color:  VmodelColors.vModelprimarySwatch
                    ,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              )
              : Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
          ),
        ),
      ]
      ),
    );
  }
}
