import 'package:vmodel/src/features/dashboard/discover/widget/filter_genders.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/slider_custom_design.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/star_rating_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class JobMarketFilter extends StatefulWidget {
  const JobMarketFilter({Key? key}) : super(key: key);

  @override
  State<JobMarketFilter> createState() => _JobMarketFilterState();
}

class _JobMarketFilterState extends State<JobMarketFilter> {
  double value = 4;
  double locationVal = 30;

  static double lowerValue = 150;
  static double upperValue = 600;

  RangeValues rangeValues = RangeValues(lowerValue, upperValue);

  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Filter",
        appBarHeight: 50,
        elevation: 0.0,
        trailingIcon: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, top: 0),
              child: Text(
                "Clear All",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: VmodelColors.primaryColor,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpacing(30),
              Text(
                "Based on Job:",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: VmodelColors.primaryColor,
                    ),
              ),
              addVerticalSpacing(10),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(5),
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      VWidgetsDropDownTextField<String>(
                        havePrefix: true,
                        onChanged: (selected) {
                          setState(() {
                            selectedVal1 = selected;
                          });
                        },
                        value: selectedVal1,
                        hintText: "",
                        options: const ["Photographers", "Models"],
                        prefixText: "Jobs  ",
                        getLabel: (String value) => selectedVal1,
                      ),
                      addHorizontalSpacing(8),
                      VWidgetsDropDownTextField<String>(
                        havePrefix: true,
                        onChanged: (selected) {
                          setState(() {
                            selectedVal2 = selected;
                          });
                        },
                        value: selectedVal2,
                        hintText: "",
                        options: const ["Photographers", "Models"],
                        prefixText: "Job Types  ",
                        getLabel: (String value) => selectedVal2,
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpacing(10),

              const FilterGenders(),

              addVerticalSpacing(40),

              // Location / Maximum Distance
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Location / Maximum Distance",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.primaryColor,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 45,
                      child: SliderTheme(
                        data: SliderThemeData(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 14),
                          trackShape: CustomTrackShape(),
                        ),
                        child: Slider(
                          min: 10,
                          max: 100,
                          inactiveColor: VmodelColors.borderColor,
                          onChanged: (val) {
                            setState(() {
                              locationVal = val;
                            });
                          },
                          value: locationVal,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${locationVal.toInt()} KM",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.primaryColor,
                        ),
                  ),
                ],
              ),

              // addVerticalSpacing(40),

              // Duration
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              // Text("Duration", style: Theme.of(context).textTheme.displayMedium?.copyWith(
              //   fontSize: 14, fontWeight: FontWeight.w600, color: VmodelColors.primaryColor,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: SizedBox(
              //     height: 45,
              //     child: SliderTheme(
              //       data: SliderThemeData(
              //         thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
              //         trackShape: CustomTrackShape(),
              //       ),
              //       child: Slider(
              //         min: 1,
              //         max: 10,
              //         inactiveColor: VmodelColors.borderColor,
              //         onChanged: (val){
              //           setState(() {
              //             value = val;
              //           });
              //         },
              //         value: value,
              //       ),
              //     ),
              //   ),
              // ),

              //     Text("${value.toInt()} days",style: Theme.of(context).textTheme.displayMedium?.copyWith(
              //       fontSize: 14, fontWeight: FontWeight.w600, color: VmodelColors.primaryColor,),),
              //   ],
              // ),

              addVerticalSpacing(40),

              // Price range
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Price Range",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.primaryColor,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 45,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          overlayShape: SliderComponentShape.noOverlay,
                          rangeThumbShape: const RoundRangeSliderThumbShape(
                              enabledThumbRadius: 14, disabledThumbRadius: 14),
                          trackShape: CustomTrackShape(),
                        ),
                        child: RangeSlider(
                          labels: RangeLabels(rangeValues.start.toString(),
                              rangeValues.end.toString()),
                          min: 50,
                          max: 1000,
                          values: rangeValues,
                          inactiveColor: VmodelColors.borderColor,
                          onChanged: (val) {
                            setState(() {
                              rangeValues = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "£${rangeValues.start.toInt().toString()}  -  ",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: VmodelColors.primaryColor,
                                ),
                      ),
                      Text(
                        "£${rangeValues.end.toInt().toString()}",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: VmodelColors.primaryColor,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
              addVerticalSpacing(30),
              const StartRatings(),
              addVerticalSpacing(100),
              VWidgetsPrimaryButton(
                  enableButton: true,
                  buttonTitle: "Done",
                  onPressed: () {
                    goBack(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
