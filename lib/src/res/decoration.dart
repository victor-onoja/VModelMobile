import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VModelBoxDecoration {
  VModelBoxDecoration._();
  static BoxDecoration avatarDecoration = BoxDecoration(
    color: VmodelColors.primaryColor,
    border: Border.all(
      width: 1.8,
      color: VmodelColors.primaryColor,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(100),
    ),
  );
}
InputDecoration inputDecoration({String? hint}) => InputDecoration(
  border: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide(color: Colors.grey[350]!)),
  hintText: hint,
  hintStyle: descriptionTextStyle.copyWith(color: Colors.grey[700]),
  contentPadding: const EdgeInsets.only(left: 12, right: 12),
  // constraints: const BoxConstraints(maxHeight: 40),
);