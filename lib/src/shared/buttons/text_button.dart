import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? fontSize;
  final void Function()? onLongPress;
  final ButtonStyle? style;
  final void Function(bool)? onFocusChange;
  final void Function(bool)? onHover;
  final bool? autofocus;
  final Clip? clipBehavior;
  final MaterialStatesController? statesController;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final bool showLoadingIndicator;
  final Color? loadingIndicatorColor;

  const VWidgetsTextButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.onFocusChange,
    this.onHover,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
    this.focusNode,
    this.textStyle,
    required this.text,
    this.fontSize,
    this.showLoadingIndicator = false,
    this.loadingIndicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: showLoadingIndicator ? null : onPressed,
      onLongPress: () {},
      style: ButtonStyle(textStyle: MaterialStateProperty.all(promptTextStyle)),
      onFocusChange: onFocusChange,
      onHover: onHover,
      autofocus: false,
      clipBehavior: Clip.none,
      statesController: statesController,
      focusNode: focusNode,
      child: showLoadingIndicator
          ? Center(
              child: CupertinoActivityIndicator(
                color: loadingIndicatorColor ?? Theme.of(context).primaryColor,
              ),
            )
          : Text(
              text,
              style: textStyle ??
                  Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
            ),
    );
  }
}
