import 'package:vmodel/src/res/res.dart';

import '../vmodel.dart';

class UIConstants {
  UIConstants._();
  static final UIConstants instance = UIConstants._();

  // static const focusedBorder = OutlineInputBorder(
  //     borderSide: BorderSide(color: VmodelColors.primaryColor, width: 1.7),
  //     borderRadius: BorderRadius.all(Radius.circular(8)));
  // static var disabledBorder = OutlineInputBorder(
  //     borderSide: BorderSide(
  //         color: VmodelColors.primaryColor.withOpacity(0.4), width: 1.5),
  //     borderRadius: const BorderRadius.all(Radius.circular(7.5)));
  // static const border = OutlineInputBorder(
  //     borderSide: BorderSide(
  //       color: VmodelColors.primaryColor,
  //       width: 1.5,
  //     ),
  //     borderRadius: BorderRadius.all(Radius.circular(7.5)));
  // static const enabledBorder = OutlineInputBorder(
  //     borderSide: BorderSide(color: VmodelColors.primaryColor, width: 1),
  //     borderRadius: BorderRadius.all(Radius.circular(7.5)));
  // static const focusedErrorBorder = OutlineInputBorder(
  //     borderSide:
  //         BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.5),
  //     borderRadius: BorderRadius.all(Radius.circular(7.5)));
  // static const errorBorder = OutlineInputBorder(
  //     borderSide:
  //         BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.0),
  //     borderRadius: BorderRadius.all(Radius.circular(7.5)));

  static Color? switchActiveColor(context) {
    return Theme.of(context)
        .switchTheme
        .trackColor
        ?.resolve({MaterialState.selected});
  }

  InputDecoration inputDecoration(
    BuildContext context, {
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? suffixWidget,
    String? hintText,
    String? helperText,
    String? counterText = '',
    TextStyle? hintStyle,
    EdgeInsets? contentPadding,
    bool isCollapsed = false,
    bool showCounter = false,
    bool enabled = true,
  }) {
    return InputDecoration(
      enabled: enabled,
      fillColor: Theme.of(context).buttonTheme.colorScheme!.secondary,
      filled: true,
      isDense: true,
      isCollapsed: isCollapsed,
      suffixIcon: suffixIcon,
      suffix: suffixWidget,
      // counterText: counterText,
      counter: showCounter ? null : const SizedBox.shrink(),
      prefixIcon: prefixIcon,
      suffixStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: VmodelColors.boldGreyText,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
      hintText: hintText,
      helperText: helperText,
      hintStyle: hintStyle ??
          Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                fontSize: 12.sp,
                height: 1.7,
              ),
      contentPadding:
          contentPadding ?? const EdgeInsets.fromLTRB(12, 12, 12, 12),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonTheme.colorScheme!.primary,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonTheme.colorScheme!.secondary,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).buttonTheme.colorScheme!.secondary,
              width: 0),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).buttonTheme.colorScheme!.secondary,
              width: 0),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).buttonTheme.colorScheme!.secondary,
              width: 0),
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
