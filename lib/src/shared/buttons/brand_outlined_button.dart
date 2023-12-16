import 'package:flutter/cupertino.dart';

import '../../vmodel.dart';

class VWidgetsOutlinedButton extends StatelessWidget {
  const VWidgetsOutlinedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.enableButton = true,
    this.buttonTitleTextStyle,
    this.padding,
    this.showLoadingIndicator = false,
  });

  final String buttonText;
  final bool enableButton;
  final TextStyle? buttonTitleTextStyle;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;
  final bool showLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12)),
      onPressed: onPressed,
      child: showLoadingIndicator
          ? const Center(
              child: CupertinoActivityIndicator(
              color: Colors.white,
            ))
          : Text(
              buttonText,
              style: buttonTitleTextStyle ??
                  Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
            ),
    );
  }
}
