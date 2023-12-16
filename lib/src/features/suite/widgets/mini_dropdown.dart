import 'package:flutter/material.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../res/res.dart';
import '../../../res/ui_constants.dart';
import '../../../shared/text_fields/dropdown_text_normal.dart';

class AnalyticsMiniDropdownNormal<T> extends StatelessWidget {
  const AnalyticsMiniDropdownNormal({
    super.key,
    required this.items,
    required this.validator,
    required this.onChanged,
    required this.itemToString,
    this.value,
    this.fieldLabel,
    this.fieldLabelStyle,
    this.hintText,
    this.isExpanded = false,
  });

  final List<T> items;
  final String? Function(T?)? validator;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemToString;
  final T? value;
  final String? fieldLabel;
  final String? hintText;
  final bool isExpanded;
  final TextStyle? fieldLabelStyle;

  @override
  Widget build(BuildContext context) {
    return VWidgetsDropdownNormal(
      items: items,
      validator: validator,
      onChanged: onChanged,
      itemToString: itemToString,
      value: value,
      fieldLabel: fieldLabel,
      fieldLabelStyle: fieldLabelStyle,
      hintText: hintText,
      isExpanded: isExpanded,
      iconEnabledColor: Colors.white,
      customDecoration: UIConstants.instance
          .inputDecoration(context,
              enabled: onChanged != null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0))
          .copyWith(
            fillColor: VmodelColors.greyLightColor.withOpacity(.5),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((item) {
          return Text(
            itemToString?.call(item) ?? '',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
          );
        }).toList();
      },
    );
  }
}
