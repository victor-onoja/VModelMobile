import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class CreateOffer extends StatefulWidget {
  const CreateOffer({Key? key}) : super(key: key);
  @override
  State<CreateOffer> createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  String dropdownGenderValue = "Male";
  String dropDownOfferType = "Hybrid";
  String drpDownOfferPriceValue = "£ 500";
  String _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "",
        elevation: 0.0,
        trailingIcon: [
          IconButton(
              onPressed: () {
                popSheet(context);
              },
              icon: const RenderSvg(
                svgPath: VIcons.closeIcon,
              ))
        ],
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: VWidgetsPrimaryTextFieldWithTitle(
                        label: "Offer Price",
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        hintText: "£ 500",
                        onChanged: (val) {},
                      ),
                    ),
                    addVerticalSpacing(10),
                     VWidgetsDescriptionTextFieldWithTitle(
                      label: "Describe your offer",
                      hintText: "Include as much details as possible...",
                    ),
                    addVerticalSpacing(20),
                    VWidgetsDropDownTextField(
                      fieldLabel: "Offer Type",
                      hintText: "",
                      options: const ["Hybrid", "Remote"],
                      value: dropDownOfferType,
                      onChanged: (val) {
                        setState(() {
                          setState(() {
                            dropDownOfferType = val;
                          });
                        });
                      },
                    ),
                    addVerticalSpacing(25),
                    Row(
                      children: [
                        Text("Delivery Date :",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: VmodelColors.primaryColor,
                                    fontWeight: FontWeight.w600)),
                        addHorizontalSpacing(10),
                        Text(_date,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: VmodelColors.primaryColor,
                                    fontWeight: FontWeight.w500)),
                      ],
                    ),
                    addVerticalSpacing(10),
                    Column(
                      children: <Widget>[
                        SfDateRangePicker(
                          showNavigationArrow: true,
                          allowViewNavigation: true,
                          showActionButtons: false,
                          toggleDaySelection: true,
                          headerStyle: const DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                          ),
                          headerHeight: 70,
                          monthCellStyle: DateRangePickerMonthCellStyle(
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontSize: 13.sp,
                                ),
                          ),
                          onSelectionChanged: selectionChanged,
                          selectionMode: DateRangePickerSelectionMode.single,
                          view: DateRangePickerView.month,
                        ),
                      ],
                    ),
                    addVerticalSpacing(40)
                  ],
                ),
              ),
            ),
            addVerticalSpacing(10),
            VWidgetsPrimaryButton(
                enableButton: true,
                buttonTitle: "Done",
                onPressed: () {
                  popSheet(context);
                }),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        _date = DateFormat('dd, MMMM yyyy').format(args.value).toString();
      });
    });
  }
}
