import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsPrimaryButton extends StatelessWidget {
  final String? buttonTitle;
  final VoidCallback? onPressed;
  final bool enableButton;
  final bool showLoadingIndicator;
  final double? butttonWidth;
  final double? buttonHeight;
  final TextStyle? buttonTitleTextStyle;
  final Color? buttonColor;
  final Color? splashColor;
  final double? borderRadius;
  const VWidgetsPrimaryButton({
    super.key,
    required this.onPressed,
    this.buttonTitle,
    this.enableButton = true,
    this.buttonHeight,
    this.buttonTitleTextStyle,
    this.splashColor,
    this.buttonColor,
    this.butttonWidth,
    this.borderRadius,
    this.showLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _buttonPressedState,
      disabledColor: VmodelColors.greyColor.withOpacity(0.2),
      disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.2),
      elevation: 0,
      minWidth: butttonWidth ?? MediaQuery.of(context).size.width,
      height: buttonHeight ?? 40,
      textColor: enableButton == true
          ? Theme.of(context).buttonTheme.colorScheme!.onPrimary
          : Theme.of(context).primaryColor.withOpacity(0.2),
      color: enableButton == true
          ? buttonColor ?? Theme.of(context).buttonTheme.colorScheme?.background
          : Theme.of(context)
              .buttonTheme
              .colorScheme
              ?.background
              .withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 8),
        ),
      ),
      splashColor: splashColor,
      child: showLoadingIndicator
          ? SizedBox(
              // width: butttonWidth ?? MediaQuery.of(context).size.width,
              width: (butttonWidth != null)
                  ? (butttonWidth! * 0.7)
                  : MediaQuery.of(context).size.width,
              child: const Center(
                  child: CupertinoActivityIndicator(
                color: Colors.white,
              )),
            )
          : Text(
              buttonTitle ?? "",
              style: enableButton
                  ? buttonTitleTextStyle ??
                      Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: enableButton
                                ? Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .onPrimary
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                            fontWeight: FontWeight.w600,
                            // fontSize: 12.sp,
                          )
                  : Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w600,
                        // fontSize: 12.sp,
                      ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }

  VoidCallback? get _buttonPressedState {
    if (enableButton && !showLoadingIndicator) {
      return onPressed;
    } else if (enableButton && showLoadingIndicator) {
      return () {};
    }
    return null;
  }
}
