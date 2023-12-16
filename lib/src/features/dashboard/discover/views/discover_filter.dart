import 'package:vmodel/src/features/dashboard/discover/models/mock_data.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/category_button.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/filter_genders.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/slider_custom_design.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/star_rating_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class DiscoverFilter extends StatefulWidget {
  const DiscoverFilter({Key? key}) : super(key: key);

  @override
  _DiscoverFilterState createState() => _DiscoverFilterState();
}

class _DiscoverFilterState extends State<DiscoverFilter> {
  double value = 4;
  double locationVal = 30;

  static double lowerValue = 150;
  static double upperValue = 600;
  String selectedChip = "Models";
  RangeValues rangeValues = RangeValues(lowerValue, upperValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Filter",
        appBarHeight: 50,
        elevation: 0.0,
        trailingIcon: [
          Center(
            child: Text(
              "Clear All",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: VmodelColors.primaryColor,
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
              addVerticalSpacing(20),
              SizedBox(
                height: 56,
                child: ListView.builder(
                  padding: const EdgeInsets.only(right: 14),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryButton(
                      isSelected: selectedChip == categories[index],
                      text: categories[index],
                      onPressed: () =>
                          setState(() => selectedChip = categories[index]),
                    );
                  },
                ),
              ),
              addVerticalSpacing(10),
              VWidgetsPrimaryButton(
                  enableButton: true,
                  buttonTitle: "Done",
                  onPressed: () {
                    goBack(context);
                  }),
              addVerticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
