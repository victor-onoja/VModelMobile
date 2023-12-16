import 'package:flutter/services.dart';

import '../../../../../res/res.dart';
import '../../../../../res/ui_constants.dart';
import '../../../../../vmodel.dart';

class VWidgetsCommentFieldNormal extends StatelessWidget {
  const VWidgetsCommentFieldNormal({
    super.key,
    this.onChanged,
    this.hintText,
    this.validator,
    this.contentPadding,
    this.controller,
    this.labelText,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.obscureText = false,
    this.textCapitalization,
    this.focusNode,
    required this.handleDoneButtonPress,
    required this.showSendButton,
  });

  final Function(String?)? onChanged;
  final Function() handleDoneButtonPress;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? labelText;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final bool showSendButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(labelText!,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor.withOpacity(1),
                  )),
        if (labelText != null) addVerticalSpacing(10),
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: onChanged,
          textInputAction: TextInputAction.send,
          onEditingComplete: handleDoneButtonPress,
          textCapitalization: textCapitalization == null
              ? TextCapitalization.none
              : textCapitalization!,
          minLines: 1,
          maxLines: 2,
          maxLength: maxLength,
          // maxLines: 5,
          inputFormatters: inputFormatters,
          validator: validator ??
              (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter text';
                }
                return null;
              },
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColor,
              ),
          decoration: UIConstants.instance.inputDecoration(
            context,
            hintText: hintText,
            isCollapsed: true,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          ),
        ),
      ],
    );
  }
}
