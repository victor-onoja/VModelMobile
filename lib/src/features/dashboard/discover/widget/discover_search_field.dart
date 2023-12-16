import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsDiscoverSearchTextField extends StatelessWidget {
  final String? label;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final TextInputFormatter? formatter;
  final TextCapitalization? textCapitalization;
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
  final ValueChanged? onTapOutside;
  final InputBorder? enabledBorder;
  final bool showInputBorder;
  final bool autofocus;

  const VWidgetsDiscoverSearchTextField(
      {super.key,
      this.label,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.keyboardType,
      this.formatter,
      this.onSaved,
      this.obscureText = false,
      this.hintText,
      this.maxLength,
      this.controller,
      this.validator,
      this.textCapitalization,
      this.shouldReadOnly = false,
      trailing,
      this.suffixIcon,
      this.enabled = true,
      this.minWidth,
      this.prefixIcon,
      this.labelStyle,
      this.hintStyle,
      this.focusNode,
      this.showInputBorder = true,
      this.autofocus = false,
      this.onTapOutside,
      this.enabledBorder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: minWidth ?? 100.0.w,
        child: SizedBox(
          height: maxLength != null ? 6.h : 6.h,
          width: minWidth ?? 100.0.w,
          child: TextFormField(
            autofocus: autofocus,
            autocorrect: false,
            enableSuggestions: false,
            minLines: minLines ?? 1,
            controller: controller,
            maxLength: maxLength,
            onSaved: onSaved,
            enabled: enabled,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            onTap: onTap,
            onTapOutside: onTapOutside,
            focusNode: focusNode,
            onChanged: (text) {
              if (onChanged != null) onChanged!(text);
            },
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: keyboardType,
            obscureText: obscureText,
            obscuringCharacter: '●',
            inputFormatters: [
              formatter ?? FilteringTextInputFormatter.singleLineFormatter
            ],
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).primaryColor.withOpacity(1),
                ),
            readOnly: shouldReadOnly,
            decoration: InputDecoration(
              border: showInputBorder
                  ? const UnderlineInputBorder()
                  : InputBorder.none,
              //suffix: suffixIcon,
              suffixIcon: suffixIcon,
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 20, maxWidth: 24),
              prefixIcon: prefixIcon,
              suffixStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: VmodelColors.boldGreyText,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
              isDense: true,
              counterText: "",
              hintText: hintText,
              hintStyle: hintStyle ??
                  Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      fontSize: 11.sp,
                      overflow: TextOverflow.clip),
              contentPadding: const EdgeInsets.fromLTRB(2, 12, 14.5, 8),
              enabledBorder: enabledBorder ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                      // color: VmodelColors.primaryColor,
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2,
                    ),
                  ),
            ),
          ),
        ));
  }
}
