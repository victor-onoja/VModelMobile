import 'package:flutter/services.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsSignUpTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function(String?)? onFieldSubmitted;
  const VWidgetsSignUpTextField({
    super.key,
    this.inputFormatters,
    this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      inputFormatters: inputFormatters,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      textInputAction:
                    TextInputAction.done,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: VmodelColors.hintColor.withOpacity(0.5), fontSize: 11.sp),
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(14.5, 14.5, 14.5, 14.5),
       focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor.withOpacity(1),
                          width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5))),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: VmodelColors.bottomNavIndicatiorColor,
                          width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(7.5))),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(7.5)))
      ),
    );
  }
}
