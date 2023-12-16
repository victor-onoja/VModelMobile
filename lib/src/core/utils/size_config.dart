/*
Important class to help and support responsiveness in the app,
it gets width and height by Media Query and then used to calculate other important pixels.
this class also contains some color values that are used throughout the app for
custom styling.
 */

import 'package:flutter/material.dart';
 
class SizeConfig {
  static late MediaQueryData _mediaQueryData; //initializer
  static late double screenWidth; //Width of screen
  static late double screenHeight; //Height of Phone's screen
  static late double blockSizeHorizontal; // 1/100th value of screen's width
  static late double blockSizeVertical; // 1/100th value of screen's height
  static late double defaultButtonSize; // 1/100th value of screen's height
  static late double baseFontSize; // 1/100th value of screen's height

  static late double
      _safeAreaHorizontal; // Padding on both side (left-right) for safe area. notches and iPhoneX and above
  static late double
      _safeAreaVertical; // Padding on both (top-bottom) for safe area vertically.
  static late double
      safeBlockHorizontal; // 1/100th of screen width after subtracting safe-area.
  static late double
      safeBlockVertical; // 1/100th of screen height after subtracting safe-area.
  static late Color
      backgroundColour; // Color of base canvas in every screen of application.

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    backgroundColour = const Color(0xff3b48ad);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height - AppBar().preferredSize.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    baseFontSize = (SizeConfig.blockSizeVertical * 1.6).floor().toDouble();
    defaultButtonSize = SizeConfig.blockSizeVertical * 9;
  }
}
