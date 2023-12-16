import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';

import '../../res/ui_constants.dart';

class VWidgetsPrimaryTextFieldWithTitle extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? helperText;
  final List<TextInputFormatter>? formatters;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final ValueChanged? onTapOutside;
  final int? maxLength;
  final TextEditingController? controller;
  final dynamic validator;
  final bool shouldReadOnly;
  final double? minWidth;
  final double? minHeight;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTapTrailingIcon;
  final TextStyle? labelStyle;
  final bool enabled;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool isIncreaseHeightForErrorText;
  final double? heightForErrorText;

  const VWidgetsPrimaryTextFieldWithTitle({
    super.key,
    this.label,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.keyboardType,
    this.initialValue,
    this.formatters,
    this.onSaved,
    this.obscureText = false,
    this.hintText,
    this.maxLength,
    this.controller,
    this.validator,
    this.shouldReadOnly = false,
    this.trailingWidget,
    this.onTapTrailingIcon,
    this.suffixIcon,
    this.enabled = true,
    this.minWidth,
    this.minHeight,
    this.prefixIcon,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.autofocus = false,
    this.isIncreaseHeightForErrorText = false,
    this.heightForErrorText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth ?? 100.0.w,
      // height: 10.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label ?? "",
                style: labelStyle ??
                    Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor.withOpacity(1),
                        ),
              ),
              GestureDetector(
                onTap: onTapTrailingIcon,
                child: trailingWidget ?? const Text(""),
              ),
            ],
          ),
          SizedBox(height: 0.3.h),
          SizedBox(
            height: maxLength != null
                ? 5.3.h
                : isIncreaseHeightForErrorText
                    ? heightForErrorText ?? 10.h
                    : 5.3.h,
            width: minWidth ?? 100.0.w,
            child: TextFormField(
              initialValue: initialValue,
              autofocus: autofocus!,
              focusNode: focusNode,
              cursorHeight: 11,
              autocorrect: false,
              onTapOutside: onTapOutside,
              enableSuggestions: false,
              minLines: minLines ?? 1,
              controller: controller,
              maxLength: maxLength,
              onSaved: onSaved,
              enabled: enabled,
              onTap: onTap,
              onChanged: (text) {
                if (onChanged != null) onChanged!(text);
              },
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: keyboardType,
              obscureText: obscureText,
              inputFormatters: formatters ??
                  [FilteringTextInputFormatter.singleLineFormatter],
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    decoration: TextDecoration.none,
                    color: Theme.of(context).primaryColor.withOpacity(1),
                    fontSize: 12.sp,
                  ),
              readOnly: shouldReadOnly,
              decoration: UIConstants.instance.inputDecoration(
                context,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                helperText: helperText,
                hintStyle: hintStyle,

                // contentPadding: const EdgeInsets.symmetric(vertical: 40),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VWidgetsPrimaryTextFieldWithTitle2 extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final List<TextInputFormatter>? formatters;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final int? maxLength;
  final TextEditingController? controller;
  final dynamic validator;
  final bool shouldReadOnly;
  final double? minWidth;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? labelStyle;
  final bool enabled;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final bool? autofocus;
  //
  final bool isIncreaseHeightForErrorText;
  final double? heightForErrorText;
  final EdgeInsetsGeometry? contentPadding;
  final bool isDense;

  final int? maxLines;
  final TextCapitalization? textCapitalization;

  const VWidgetsPrimaryTextFieldWithTitle2({
    super.key,
    this.maxLength,
    this.label,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.initialValue,
    this.formatters,
    this.onSaved,
    this.obscureText = false,
    this.hintText,
    this.controller,
    this.validator,
    this.shouldReadOnly = false,
    trailing,
    this.suffixIcon,
    this.enabled = true,
    this.minWidth,
    this.prefixIcon,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.autofocus = false,
    this.isIncreaseHeightForErrorText = false,
    this.heightForErrorText,
    this.contentPadding,
    this.isDense = false,
    this.maxLines,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth ?? 100.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: labelStyle ??
                Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: maxLength != null
                ? 6.h
                : isIncreaseHeightForErrorText
                    ? heightForErrorText ?? 10.h
                    : 10.h,
            width: minWidth ?? 100.0.w,
            child: TextFormField(
              minLines: minLines ?? 1,
              maxLines: maxLines ?? 1,
              initialValue: initialValue,
              autofocus: autofocus!,
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              textCapitalization: textCapitalization == null
                  ? TextCapitalization.none
                  : textCapitalization!,
              cursorHeight: 13,
              autocorrect: false,
              enableSuggestions: false,
              // minLines: minLines ?? 1,
              controller: controller,
              maxLength: maxLength,
              onSaved: onSaved,
              enabled: enabled,
              onTap: onTap,
              onChanged: (text) {
                if (onChanged != null) onChanged!(text);
              },
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: keyboardType,
              obscureText: obscureText,

              inputFormatters: formatters ??
                  [FilteringTextInputFormatter.singleLineFormatter],
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    decoration: TextDecoration.none,
                    color: Theme.of(context).primaryColor.withOpacity(1),
                    fontSize: 12.sp,
                  ),
              readOnly: shouldReadOnly,

              decoration: UIConstants.instance.inputDecoration(
                context,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                helperText: null,
                hintStyle: hintStyle,
                counterText: null,
              ),
              // decoration: InputDecoration(
              //     isDense: isDense,
              //     suffixIcon: suffixIcon,
              //     prefixIcon: prefixIcon,
              //     suffixStyle:
              //         Theme.of(context).textTheme.displayMedium!.copyWith(
              //               color: VmodelColors.boldGreyText,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 12.sp,
              //             ),
              //     hintText: hintText,
              //     hintStyle: hintStyle ??
              //         Theme.of(context).textTheme.displayMedium!.copyWith(
              //             color:
              //                 Theme.of(context).primaryColor.withOpacity(0.5),
              //             fontSize: 12.sp,
              //             height: 1.7),
              //     contentPadding: contentPadding ??
              //         const EdgeInsets.fromLTRB(12, 12, 12, 12),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: //Theme.of(context).primaryColor.withOpacity(1),
              //                 Colors.purple,
              //             width: 1.5),
              //         borderRadius: const BorderRadius.all(Radius.circular(8))),
              //     disabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color:
              //                 Theme.of(context).primaryColor.withOpacity(0.4),
              //             width: 1.5),
              //         borderRadius:
              //             const BorderRadius.all(Radius.circular(7.5))),
              //     border: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color:
              //                 // Theme.of(context).primaryColor.withOpacity(0.4),

              //                 Colors.green,
              //             width: 1.5),
              //         borderRadius:
              //             const BorderRadius.all(Radius.circular(7.5))),
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color:
              //                 // Theme.of(context).primaryColor.withOpacity(0.4),
              //                 Colors.pink,
              //             width: 1.5),
              //         borderRadius:
              //             const BorderRadius.all(Radius.circular(7.5))),
              //     focusedErrorBorder: const OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: VmodelColors.bottomNavIndicatiorColor,
              //             width: 1.5),
              //         borderRadius: BorderRadius.all(Radius.circular(7.5))),
              //     errorBorder: const OutlineInputBorder(
              //         borderSide: BorderSide(
              //             color: VmodelColors.bottomNavIndicatiorColor,
              //             width: 1.0),
              //         borderRadius: BorderRadius.all(Radius.circular(7.5)))),
            ),
          )
        ],
      ),
    );
  }
}

InputDecoration _inputDecoration(
  BuildContext context, {
  Widget? prefixIcon,
  Widget? suffixIcon,
  String? hintText,
  String? helperText,
  TextStyle? hintStyle,
}) {
  return InputDecoration(
      isCollapsed: true,
      suffixIcon: suffixIcon,
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
              height: 1.7),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor,

              // Colors.purple,
              width: 1.7),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(7.5))),
      border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(7.5))),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(7.5))),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: VmodelColors.bottomNavIndicatiorColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(7.5))),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: VmodelColors.bottomNavIndicatiorColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(7.5))));
}
