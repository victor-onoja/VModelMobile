//  Forked from IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_picker_slider.dart';
import 'track_type.dart';

/// The default layout of Color Picker.
class VMColorPicker extends StatefulWidget {
  const VMColorPicker({
    super.key,
    //GENERAL
    this.paletteType = VMIGPaletteType.hsv,
    this.currentColor,
    this.onColorChanged,
    // //HISTORY
    this.historyColorsBuilder,
    this.colorHistory,
    // //ALL VIEWS DECORATION
    // this.enableAlpha = true,
    this.padding,
    this.elementSpacing = 10,
    // //DECORATION COLOR PICKER SLIDER
    this.showSlider = true,
    this.sliderRadius,
    this.sliderBorderColor,
    this.sliderBorderWidth,
    this.displayThumbColor = true,
    // //DECORATION COLOR PICKER ALPHA SLIDER
    // this.alphaSliderRadius,
    // this.alphaSliderBorderColor,
    // this.alphaSliderBorderWidth,
    // //DECORATION COLOR PICKER AREA
    // this.areaWidth = 300.0,
    // this.areaHeight,
    // this.areaRadius,
    // this.areaBorderColor,
    // this.areaBorderWidth,
    // //DECORATION COLOR PICKER INPUT BAR
    // this.showInputBar = true,
    // this.inputBarBorderColor,
    // this.inputBarBorderWidth,
    // this.inputBarRadius,
    // this.inputBarPadding,
    // this.inputBarDisable,
    // this.customInputBar,
    // //DECORATION COLOR PICKER COLOR DETAILS
    // this.colorDetailsLabelTypes = const [
    //   IGColorLabelType.hex,
    //   IGColorLabelType.rgb,
    //   IGColorLabelType.hsv,
    //   IGColorLabelType.hsl
    // ],
    // this.colorDetailsWidget,
  });

  //GENERAL
  final VMIGPaletteType paletteType;

  final Color? currentColor;
  final ValueChanged<Color>? onColorChanged;

  //HISTORY
  final Widget Function()? historyColorsBuilder;
  final List<Color>? colorHistory;

  //ALL VIEWS DECORATION
  final EdgeInsetsGeometry? padding;
  final double elementSpacing;

  //DECORATION COLOR PICKER SLIDER
  final bool showSlider;
  final double? sliderRadius;
  final Color? sliderBorderColor;
  final double? sliderBorderWidth;
  final bool displayThumbColor;

  //DECORATION COLOR PICKER ALPHA SLIDER
  // final bool enableAlpha;
  // final double? alphaSliderRadius;
  // final Color? alphaSliderBorderColor;
  // final double? alphaSliderBorderWidth;

  //DECORATION COLOR PICKER AREA
  // final double areaWidth;
  // final double? areaHeight;
  // final double? areaRadius;
  // final Color? areaBorderColor;
  // final double? areaBorderWidth;

  //DECORATION COLOR PICKER INPUT BAR
  // final bool showInputBar;
  // final double? inputBarRadius;
  // final Color? inputBarBorderColor;
  // final double? inputBarBorderWidth;
  // final EdgeInsetsGeometry? inputBarPadding;
  // final bool? inputBarDisable;
  // final Widget Function(Color)? customInputBar;

  //DECORATION COLOR PICKER COLOR DETAILS
  // final List<IGColorLabelType> colorDetailsLabelTypes;
  // final Widget Function(
  //   List<String> hex,
  //   List<String> rgb,
  //   List<String> hsv,
  //   List<String> hsl,
  // )? colorDetailsWidget;

  @override
  VMColorPickerState createState() => VMColorPickerState();
}

class VMColorPickerState extends State<VMColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0, 0, 0, 0);
  List<Color> colorHistory = [];

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(
      widget.currentColor ?? Colors.white,
    );
    if (widget.colorHistory != null) {
      colorHistory = widget.colorHistory ?? [];
    }
    super.initState();
  }

  @override
  void didUpdateWidget(VMColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(
      widget.currentColor ?? Colors.white,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //COLOR PICKER SLIDER & ALPHA SLIDER
          // _sliderByPaletteType,
          VMIGColorPickerSlider(
            trackType: VMIGTrackType.hue,
            hsvColor: currentHsvColor,
            onColorChanged: (HSVColor color) {
              setState(() => currentHsvColor = color);
              widget.onColorChanged?.call(currentHsvColor.toColor());
            },
            // displayThumbColor: widget.displayThumbColor,
            displayThumbColor: true,
            borderColor: Colors.transparent,
            borderWidth: 0,
            radius: widget.sliderRadius,
          ),
          // _colorPickerSlider(IGTrackType.hue),
        ],
      ),
    );
  }

  //UTILS
  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged?.call(currentHsvColor.toColor());
  }

  //WIDGETS

  Widget get space {
    return SizedBox(height: widget.elementSpacing);
  }
}
