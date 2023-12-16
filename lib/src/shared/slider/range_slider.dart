import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../features/dashboard/discover/widget/slider_custom_design.dart';

class VWidgetsRangeSlider<T> extends StatelessWidget {
  final double? minWidth;
  final String? title;
  final String? startLabel;
  final String? endLabel;
  final RangeValues sliderValue;
  final double sliderMinValue;
  final double sliderMaxValue;
  final ValueChanged<RangeValues> onChanged;
  final bool isTitleVisible;
  final bool isLabelWidgetVisible;
  final bool isDisplayLabelOnTop;

  const VWidgetsRangeSlider({
    super.key,
    this.minWidth,
    this.title,
    this.startLabel,
    this.endLabel,
    this.isTitleVisible = true,
    this.isLabelWidgetVisible = true,
    this.isDisplayLabelOnTop = true,
    required this.sliderMaxValue,
    required this.sliderMinValue,
    required this.sliderValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTitleVisible)
          Text(title ?? "",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  // color: VmodelColors.primaryColor,
                  fontWeight: FontWeight.w600)),
        if (isTitleVisible) addVerticalSpacing(25),
        if (isLabelWidgetVisible && isDisplayLabelOnTop) _labelWidget(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: 24,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                overlayShape: SliderComponentShape.noOverlay,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                    enabledThumbRadius: 8, disabledThumbRadius: 8),
                trackShape: CustomTrackShape(),
                trackHeight: 0.5,
              ),
              child: RangeSlider(
                labels: RangeLabels(
                    sliderValue.start.toString(), sliderValue.end.toString()),
                min: sliderMinValue,
                max: sliderMaxValue,
                values: sliderValue,
                inactiveColor: VmodelColors.borderColor,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        if (isLabelWidgetVisible && !isDisplayLabelOnTop) _labelWidget(context),
      ],
    );
  }

  Row _labelWidget(BuildContext context) {
    return Row(
      children: [
        Text(
          startLabel ?? '${sliderValue.start.round()}',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w400,
                // color: VmodelColors.primaryColor,
              ),
        ),
        const Spacer(),
        Text(
          endLabel ?? '${sliderValue.end.round()}',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w400,
                // color: VmodelColors.primaryColor,
              ),
        ),
      ],
    );
  }
}
