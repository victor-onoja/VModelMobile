import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';

import '../../../../core/utils/validators_mixins.dart';
import '../../../../res/res.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../../../shared/slider/range_slider.dart';
import '../../../../shared/switch/primary_switch.dart';
import '../../../../shared/text_fields/dropdown_text_field.dart';
import '../../../../shared/text_fields/primary_text_field.dart';
import '../../../../vmodel.dart';
import '../../../authentication/register/provider/user_types_controller.dart';

class JobMarketFilterBottomSheet extends ConsumerStatefulWidget {
  const JobMarketFilterBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<JobMarketFilterBottomSheet> createState() =>
      _JobMarketFilterBottomSheetState();
}

class _JobMarketFilterBottomSheetState
    extends ConsumerState<JobMarketFilterBottomSheet> {
  bool _isRemoteOnly = false;
  // final Gender _selectedGender = Gender.male;
  RangeValues rangeValues = const RangeValues(0, 300);
  List<String> genderList = ['Male', 'Female', 'Any'];
  List<String> jobTypeList = ["Model", "Influencer", "DJ"];
  String genderValue = 'Male';
  String jobTypeValue = 'Model';
  String petTypeValue = 'Dog';

  @override
  void initState() {
    super.initState();
    // var temp =
    //     ref.read(accountTypesProvider.notifier).state.valueOrNull ?? [];
    //     jobTypeList = temp
  }

  @override
  Widget build(BuildContext context) {
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            addVerticalSpacing(15),
            const Align(
                alignment: Alignment.center, child: VWidgetsModalPill()),
            addVerticalSpacing(25),
            Text("Filter",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600)),
            addVerticalSpacing(25),
            Row(
              children: [
                Flexible(
                  child: VWidgetsDropDownTextField<String>(
                    hintText: "",
                    isExpanded: true,
                    isOneLineEllipsize: true,
                    options: allUserTypes?.talents ?? [],
                    fieldLabel: "User Type",
                    onChanged: (val) {
                      setState(() {
                        jobTypeValue = val;
                      });
                    },
                    value: jobTypeValue,
                    getLabel: (String value) => value,
                  ),
                ),
                addHorizontalSpacing(10),
                Flexible(
                  child: VWidgetsDropDownTextField(
                    hintText: "",
                    options: genderList,
                    fieldLabel: "Gender",
                    onChanged: (val) {
                      setState(() {
                        genderValue = val;
                      });
                    },
                    value: genderValue,
                    getLabel: (String value) => value,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: jobTypeValue.toLowerCase() == 'pet model'
                  ? null
                  : 0, //Change null to a numeric value to implicit animation
              child: VWidgetsDropDownTextField<String>(
                hintText: "",
                isExpanded: true,
                isOneLineEllipsize: true,
                options: const ['Dog', 'Cat'],
                fieldLabel: "Pet Type",
                onChanged: (val) {
                  setState(() {
                    petTypeValue = val;
                  });
                },
                value: petTypeValue,
                getLabel: (String value) => value,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: VWidgetsPrimaryTextFieldWithTitle2(
                    minLines: 1,

                    // maxLines: 2,
                    isDense: true,
                    controller: TextEditingController(),
                    label: 'Price range',
                    hintText: 'min',
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                    heightForErrorText: 0,
                    validator: (value) => VValidatorsMixin.isValidServicePrice(
                        value,
                        field: "Price"),
                  ),
                ),
                addHorizontalSpacing(45),
                Text("to",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600)),
                addHorizontalSpacing(45),
                Expanded(
                  child: VWidgetsPrimaryTextFieldWithTitle2(
                    minLines: 1,
                    // maxLines: 2,
                    isDense: true,
                    controller: TextEditingController(),
                    label: '',
                    hintText: 'max',
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                    heightForErrorText: 0,
                    validator: (value) => VValidatorsMixin.isValidServicePrice(
                        value,
                        field: "Price"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Remote only",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: VWidgetsSwitch(
                      swicthValue: _isRemoteOnly,
                      onChanged: (value) {
                        _isRemoteOnly = value;
                        setState(() {});
                      }),
                ),
              ],
            ),
            addVerticalSpacing(16),
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600)),
                    addVerticalSpacing(5),
                    VWidgetsRangeSlider(
                      sliderValue: rangeValues,
                      sliderMinValue: 0,
                      sliderMaxValue: 300,
                      isTitleVisible: false,
                      isLabelWidgetVisible: false,
                      onChanged: (RangeValues value) {
                        setState(() {
                          rangeValues = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          '${rangeValues.start.toInt()} km',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          rangeValues.end.toInt() == 300
                              ? "Nationwide"
                              : '${rangeValues.end.toInt()} km',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_isRemoteOnly)
                  Positioned.fill(
                      child: Container(
                    color: VmodelColors.white.withOpacity(0.75),
                  )),
              ],
            ),
            addVerticalSpacing(40),
            Center(
              child: VWidgetsPrimaryButton(
                // butttonWidth: 70,
                // buttonHeight: 32,
                onPressed: () {},
                buttonTitle: 'Filter',
                enableButton: true,
              ),
            ),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
