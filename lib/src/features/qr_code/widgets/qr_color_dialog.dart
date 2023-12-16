import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/color_slider/vm_color_slider.dart';

import '../../../vmodel.dart';
import '../../suite/views/business_opening_times/widgets/bussiness_tag_widget.dart';
import '../controllers/qr_colors_controller.dart';

class QRColorPickerDialog extends ConsumerStatefulWidget {
  const QRColorPickerDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnalyticsColorDailogState();
}

class _AnalyticsColorDailogState extends ConsumerState<QRColorPickerDialog> {
  ValueNotifier<Color> myColorTop = ValueNotifier(Color(0xFFDC3535));
  ValueNotifier<Color> pageEnd = ValueNotifier(Color(0xFFDC3535));
  ValueNotifier<Color> qrCodeColor = ValueNotifier(Color(0xFFDC3535));
  ValueNotifier<Color> qrBackground = ValueNotifier(Color(0xFFDC3535));

  @override
  void initState() {
    super.initState();
    initColors();
  }

  void initColors() {
    myColorTop.value = ref.read(qrPageColorsProvider).page.begin;
    pageEnd.value = ref.read(qrPageColorsProvider).page.end;
    qrCodeColor.value = ref.read(qrPageColorsProvider).qr.begin;
    qrBackground.value = ref.read(qrPageColorsProvider).qr.end;
  }

  @override
  Widget build(BuildContext context) {
    // final analyticsPageColors = ref.watch(qrPageColorsProvider);
    // Color myColorTop = Color(0xFFDC3535);
    return StatefulBuilder(builder: (context, stflState) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // addVerticalSpacing(4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadingChip(title: 'Page'),
                ],
              ),
              addVerticalSpacing(1.h),
              VMColorPicker(
                currentColor: myColorTop.value,
                padding: EdgeInsets.zero,
                onColorChanged: (color) {
                  // if (kDebugMode) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    myColorTop.value = color;
                    stflState(() {});
                  });
                  // setState(() {});
                  print(myColorTop.value);
                  // }
                },
              ),
              addVerticalSpacing(1.5.h),
              VMColorPicker(
                currentColor: pageEnd.value,
                padding: EdgeInsets.zero,
                onColorChanged: (color) {
                  // if (kDebugMode) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    pageEnd.value = color;
                    stflState(() {});
                  });
                  // setState(() {});
                  print(myColorTop.value);
                  // }
                },
              ),
              addVerticalSpacing(4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadingChip(title: 'QR'),
                ],
              ),
              addVerticalSpacing(1.h),
              VMColorPicker(
                currentColor: qrCodeColor.value,
                padding: EdgeInsets.zero,
                onColorChanged: (color) {
                  // if (kDebugMode) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    qrCodeColor.value = color;
                    stflState(() {});
                  });
                  // setState(() {});
                  print(myColorTop.value);
                  // }
                },
              ),
              // addVerticalSpacing(1.5.h),
              // VMColorPicker(
              //   currentColor: qrBackground.value,
              //   paletteType: VMIGPaletteType.hsv,
              //   padding: EdgeInsets.zero,
              //   onColorChanged: (color) {
              //     // if (kDebugMode) {
              //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //       qrBackground.value = color;
              //       stflState(() {});
              //     });
              //     // setState(() {});
              //     print(color);
              //     // }
              //   },
              // ),
              addVerticalSpacing(4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: RepostButtonWidget(
                    isLoading: false,
                    isSelected: false,
                    text: "Apply",
                    // padding: EdgeInsets.only(left: 50.w, right: 50.w, bottom: 10),
                    borderColor: Colors.white,
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      ref.read(qrPageColorsProvider.notifier).updateColors(
                            pageBegin: myColorTop.value,
                            pageEnd: pageEnd.value,
                            qrCodeColor: qrCodeColor.value,
                            qrBackground: qrBackground.value,
                          );
                    }),
              ),
              addVerticalSpacing(1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: RepostButtonWidget(
                    isLoading: false,
                    isSelected: false,
                    text: "Default",
                    borderColor: Colors.white,
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      ref.read(qrPageColorsProvider.notifier).applyDefaults();
                      initColors();
                      stflState(() {});
                    }),
              ),
              // addVerticalSpacing(1.h),
              // VWidgetsPrimaryButton(
              //   buttonTitle: 'Peek',
              //   buttonTitleTextStyle: TextStyle(
              //     color: Colors.black,
              //   ),
              //   buttonColor: Colors.white,
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      );
    });
  }
}

class HeadingChip extends StatelessWidget {
  final String title;
  const HeadingChip({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
