import 'package:flutter/services.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsTextFieldWithoutTitle extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String hintText;
  final TextAlign? textAlign;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  const VWidgetsTextFieldWithoutTitle({
    super.key,
    this.inputFormatters,
    this.controller,
    this.suffix,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.textAlign,
    this.keyboardType,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: false,
      validator: validator,
      inputFormatters: inputFormatters,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffix,
        //padding for hint/text inside the field
        contentPadding: contentPadding ?? const VWidgetsContentPadding.only(),
        //Changed hintstyle opacity as it is with 0.5 throughout the app
        hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: VmodelColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(7.5),
        ),
        //made box height 40 px default as in figma designs all have 40 pc height
        constraints: const BoxConstraints(maxHeight: 40),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: VmodelColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(7.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.5),
          borderSide: BorderSide(
            color: VmodelColors.buttonColor,
          ),
        ),
      ),
    );
  }
}
