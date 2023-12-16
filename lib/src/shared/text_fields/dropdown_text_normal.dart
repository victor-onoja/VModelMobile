import 'package:flutter/material.dart';
import 'package:vmodel/src/res/gap.dart';

import '../../res/ui_constants.dart';

class VWidgetsDropdownNormal<T> extends StatelessWidget {
  const VWidgetsDropdownNormal(
      {super.key,
      required this.items,
      required this.validator,
      required this.onChanged,
      required this.itemToString,
      this.value,
      this.fieldLabel,
      this.fieldLabelStyle,
      this.hintText,
      this.isExpanded = false,
      this.selectedItemBuilder,
      this.customDecoration,
      this.iconEnabledColor,
      this.itemMaxLines,
      this.itemTextOverflow});

  final List<T> items;
  final String? Function(T?)? validator;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemToString;
  final T? value;
  final String? fieldLabel;
  final String? hintText;
  final bool isExpanded;
  final TextStyle? fieldLabelStyle;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final InputDecoration? customDecoration;
  final Color? iconEnabledColor;
  final int? itemMaxLines;
  final TextOverflow? itemTextOverflow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldLabel != null)
          Text(
            fieldLabel!,
            style: fieldLabelStyle ??
                Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
          ),
        if (fieldLabel != null) addVerticalSpacing(10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            borderRadius: BorderRadius.circular(12),
            hint: hintText != null ? Text(hintText!) : null,
            value: value,
            menuMaxHeight: 200,
            iconEnabledColor: iconEnabledColor,
            isDense: true,
            iconSize: 32,
            validator: validator,
            isExpanded: isExpanded,
            decoration: customDecoration ??
                UIConstants.instance.inputDecoration(context,
                    enabled: onChanged != null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5)),
            selectedItemBuilder: selectedItemBuilder,
            items: items.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  itemToString!(value),
                  maxLines: itemMaxLines,
                  overflow: itemTextOverflow,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
