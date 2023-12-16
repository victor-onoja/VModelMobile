import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../../res/ui_constants.dart';

class VWidgetsCountryPhoneFieldWithTitle extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final String? initialCountryCode;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? helperText;
  final List<TextInputFormatter>? formatters;
  final Function(String)? onChanged;
  final ValueChanged<Country> onCountryChanged;
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

  const VWidgetsCountryPhoneFieldWithTitle({
    super.key,
    required this.onCountryChanged,
    this.label,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.keyboardType,
    this.initialValue,
    this.initialCountryCode,
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
      child: SizedBox(
        height: maxLength != null
            ? 5.3.h
            : isIncreaseHeightForErrorText
                ? heightForErrorText ?? 10.h
                : 5.3.h,
        width: minWidth ?? 100.0.w,
        child: IntlPhoneField(
          disableLengthCheck: true,
          showDropdownIcon: true,
          flagsButtonMargin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          initialValue: initialValue,
          initialCountryCode: initialCountryCode,
          autofocus: autofocus!,
          focusNode: focusNode,
          cursorHeight: 11,
          controller: controller,
          //onSaved: onSaved,
          enabled: enabled,
          onTap: onTap,
          onChanged: (text) {
            if (onChanged != null) onChanged!(text.completeNumber);
          },
          onCountryChanged: (value) {
            onCountryChanged(value);
          },
          cursorColor: Theme.of(context).primaryColor,
          obscureText: obscureText,
          inputFormatters:
              formatters ?? [FilteringTextInputFormatter.singleLineFormatter],
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
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            helperText: helperText,
            hintStyle: hintStyle,
          ),
          // InputDecoration(
          //     isCollapsed: true,
          //     suffixIcon: suffixIcon,

          //     prefixIcon: prefixIcon,
          //     suffixStyle:
          //         Theme.of(context).textTheme.displayMedium!.copyWith(
          //               color: VmodelColors.boldGreyText,
          //               fontWeight: FontWeight.w700,
          //               fontSize: 12.sp,
          //             ),
          //     hintText: hintText,
          //     helperText: helperText,
          //     hintStyle: hintStyle ??
          //         Theme.of(context).textTheme.displayMedium!.copyWith(
          //             color:
          //                 Theme.of(context).primaryColor.withOpacity(0.5),
          //             fontSize: 12.sp,
          //             height: 1.7),
          //     contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //             color: Theme.of(context).primaryColor.withOpacity(1),
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
          //                 Theme.of(context).primaryColor.withOpacity(0.4),
          //             width: 1.5),
          //         borderRadius:
          //             const BorderRadius.all(Radius.circular(7.5))),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //             color:
          //                 Theme.of(context).primaryColor.withOpacity(0.4),
          //             width: 1.5),
          //         borderRadius:
          //             const BorderRadius.all(Radius.circular(7.5))),
          //     focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.5), borderRadius: BorderRadius.all(Radius.circular(7.5))),
          //     errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.0), borderRadius: BorderRadius.all(Radius.circular(7.5)))),
        ),
      ),
    );
  }
}
