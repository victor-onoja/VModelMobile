import 'package:flutter/services.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsHelpAndSupportTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String hintText;
  final TextAlign? textAlign;
  final Widget? suffix;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  const VWidgetsHelpAndSupportTextField({
    super.key,
    this.inputFormatters,
    this.controller,
    this.suffix,
    this.maxLines,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.textAlign,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxLines != null ? 7.h : 22.h,
      child: TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        validator: validator,
        inputFormatters: inputFormatters,
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 30,

        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffix,
          //padding for hint/text inside the field
          contentPadding: const VWidgetsContentPadding.only(),
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
      ),
    );
  }
}
