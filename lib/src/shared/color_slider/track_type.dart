//  Forked from IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.

enum VMIGPaletteType {
  hsv,
  hsvWithHue,
  hsvWithValue,
  hsvWithSaturation,
  hsl,
  hslWithHue,
  hslWithLightness,
  hslWithSaturation,
  rgbWithBlue,
  rgbWithGreen,
  rgbWithRed,
  hueWheel;

  String get displayName {
    switch (this) {
      case VMIGPaletteType.hsv:
        return 'HSV';
      case VMIGPaletteType.hsvWithHue:
        return 'HSV with hue';
      case VMIGPaletteType.hsvWithValue:
        return 'HSV with value';
      case VMIGPaletteType.hsvWithSaturation:
        return 'HSV with saturation';
      case VMIGPaletteType.hsl:
        return 'HSL';
      case VMIGPaletteType.hslWithHue:
        return 'HSL with hue';
      case VMIGPaletteType.hslWithLightness:
        return 'HSL with lightness';
      case VMIGPaletteType.hslWithSaturation:
        return 'HSL with saturation';
      case VMIGPaletteType.rgbWithBlue:
        return 'RGB with blue';
      case VMIGPaletteType.rgbWithGreen:
        return 'RGB with green';
      case VMIGPaletteType.rgbWithRed:
        return 'RGB with red';
      case VMIGPaletteType.hueWheel:
        return 'HUE Wheel';
    }
  }
}

/// Track types for slider picker.
enum VMIGTrackType {
  hue,
  saturation,
  saturationForHSL,
  value,
  lightness,
  red,
  green,
  blue,
  alpha,
}

/// Color information label type.
enum VMIGColorLabelType { hex, rgb, hsv, hsl }

/// Types for slider picker widget.
enum VMIGColorModel { rgb, hsv, hsl }
