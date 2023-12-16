import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsSlider<T> extends StatelessWidget {
  final double? minWidth;
  final String? startLabel;
  final String? endLabel;
  final double? sliderValue;
  final double? sliderMinValue;
  final double? sliderMaxValue;
  final Function(double)? onChanged;

  const VWidgetsSlider(
      {this.minWidth,
      this.startLabel,
      this.endLabel,
      this.sliderMaxValue,
      this.sliderMinValue,
      this.sliderValue,
      this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth ?? 100.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startLabel ?? "",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: VmodelColors.primaryColor,
                )
              ),
              Text(
                endLabel ?? "",
                 style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: VmodelColors.primaryColor,
                )
              ),
            ],
          ),
          addVerticalSpacing(0),
          Slider(
            thumbColor: Colors.white,
            value: sliderValue!,
            label: sliderValue.toString(),
            onChanged: (value) {
              onChanged!(value);
            },
            min: sliderMinValue!,
            max: sliderMaxValue!,
          ),
        ],
      ),
    );
  }
}
