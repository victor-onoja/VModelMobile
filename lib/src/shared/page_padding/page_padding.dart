import 'package:flutter/material.dart';

/*
This class is a special class where you can use ...
new edge insets but your custom value on design file easily.
*/

/// For Page Padding
class VWidgetsPagePadding extends EdgeInsets {
  const VWidgetsPagePadding.all(double val) : super.all(val);
  const VWidgetsPagePadding.horizontalSymmetric(double val)
      : super.symmetric(horizontal: val);
  const VWidgetsPagePadding.verticalSymmetric(double val)
      : super.symmetric(vertical: val);
  const VWidgetsPagePadding.only(double rVal, double lVal, double tVal)
      : super.only(right: rVal, left: lVal, top: tVal);
  const VWidgetsPagePadding.onlyLeft(double val) : super.only(left: val);
  const VWidgetsPagePadding.onlyBottom(double val) : super.only(bottom: val);
  const VWidgetsPagePadding.onlyTop(double val) : super.only(top: val);
  const VWidgetsPagePadding.onlyRight(double val) : super.only(right: val);
}

///For Text Form Field Content Padding
class VWidgetsContentPadding extends EdgeInsets {
  static const double _top = 17;
  static const double _left = 10;

  const VWidgetsContentPadding.only() : super.only(top: _top, left: _left);
}
