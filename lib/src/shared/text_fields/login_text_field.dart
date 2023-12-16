import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/res/ui_constants.dart';

class VWidgetsLoginTextField extends StatelessWidget {
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

  const VWidgetsLoginTextField({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: minWidth ?? 100.0.w,
        child: SizedBox(
          height: maxLength != null ? 6.h : 6.h,
          width: minWidth ?? 100.0.w,
          child: TextFormField(
            autocorrect: false,
            enableSuggestions: false,
            minLines: minLines ?? 1,
            controller: controller,
            maxLength: maxLength,
            onSaved: onSaved,
            enabled: enabled,
            cursorHeight: 15,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            onTap: onTap,
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
            decoration: UIConstants.instance.inputDecoration(context,
                hintText: hintText,
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 16)),
          ),
        ));
  }
}
