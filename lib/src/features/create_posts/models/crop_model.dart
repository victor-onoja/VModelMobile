import 'package:flutter/material.dart';

class CropKeyModel {
  final String id;
  bool isRemoved;
  final GlobalKey key;
  final Widget cropView;

  CropKeyModel(
      {required this.id, required this.key, required this.cropView, this.isRemoved = false});
}
