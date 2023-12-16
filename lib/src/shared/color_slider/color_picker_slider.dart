//Forked IGLU COLOR PICKER
//
// Copyright © 2020 - 2023 IGLU. All rights reserved.
// Copyright © 2020 - 2023 IGLU S.r.l.s.
//

import 'package:flutter/material.dart';

import 'color_picker.dart';
import 'slider_layout.dart';
import 'thumb_painter.dart';
import 'track_type.dart';

/// 9 track types for slider picker widget.
class VMIGColorPickerSlider extends StatelessWidget {
  const VMIGColorPickerSlider({
    required this.trackType,
    required this.hsvColor,
    required this.onColorChanged,
    super.key,
    this.displayThumbColor = false,
    this.fullThumbColor = false,
    this.radius,
    this.borderColor,
    this.borderWidth,
    this.mainColor,
  });

  final VMIGTrackType trackType;
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final bool displayThumbColor;
  final bool fullThumbColor;

  final Color? mainColor;

  //DECORATION COLOR PICKER AREA
  final double? radius;
  final Color? borderColor;
  final double? borderWidth;

  void slideEvent(RenderBox getBox, BoxConstraints box, Offset globalPosition) {
    final localDx = getBox.globalToLocal(globalPosition).dx - 15.0;
    final progress =
        localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0);
    onColorChanged(hsvColor.withHue(progress * 359));
    // switch (trackType) {
    //   case IGTrackType.hue:
    //     // 360 is the same as zero
    //     // if set to 360, sliding to end goes to zero
    //     onColorChanged(hsvColor.withHue(progress * 359));
    //   default:
    //     onColorChanged(
    //       hsvColor.withAlpha(
    //         localDx.clamp(0.0, box.maxWidth - 30.0) / (box.maxWidth - 30.0),
    //       ),
    //     );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        var thumbOffset = 15.0;
        Color thumbColor;
        thumbOffset += (box.maxWidth - 30.0) * hsvColor.hue / 360;
        thumbColor = HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor();
        // switch (trackType) {
        //   case IGTrackType.hue:
        //     thumbOffset += (box.maxWidth - 30.0) * hsvColor.hue / 360;
        //     thumbColor = HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor();
        //   default:
        //     thumbOffset += (box.maxWidth - 30.0) * hsvColor.toColor().opacity;
        //     thumbColor = hsvColor.toColor().withOpacity(hsvColor.alpha);
        // }

        return SizedBox(
          height: 24,
          child: CustomMultiChildLayout(
            delegate: VMSliderLayout(),
            children: <Widget>[
              LayoutId(
                id: VMSliderLayout.track,
                child: Container(
                  decoration: BoxDecoration(
                    border: borderColor != null || borderWidth != null
                        ? Border.all(
                            color: borderColor ?? Colors.black,
                            width: borderWidth ?? 3,
                          )
                        : null,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius ?? 8),
                    ),
                  ),
                  child: CustomPaint(
                    painter: VMIGTrackPainter(
                      trackType: trackType,
                      hsvColor: hsvColor,
                      color: mainColor ?? Colors.black,
                      radius: radius != null ? radius! - 3 : 5,
                    ),
                  ),
                ),
              ),
              LayoutId(
                id: VMSliderLayout.thumb,
                child: Transform.translate(
                  offset: Offset(thumbOffset, 0),
                  child: CustomPaint(
                    painter: VMIGThumbPainter(
                      // shadowColor: Colors.blue,
                      // thumbColor: displayThumbColor ? thumbColor : null,
                      thumbColor: Colors.white,
                      fullThumbColor: true,
                      color: mainColor ?? Colors.black,
                    ),
                  ),
                ),
              ),
              LayoutId(
                id: VMSliderLayout.gestureContainer,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints box) {
                    final getBox = context.findRenderObject() as RenderBox?;

                    return Listener(
                      behavior: HitTestBehavior.opaque,
                      onPointerDown: (PointerDownEvent details) {
                        if (getBox != null) {
                          slideEvent(getBox, box, details.position);
                        }
                      },
                      onPointerMove: (event) {
                        if (getBox != null) {
                          slideEvent(getBox, box, event.position);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
