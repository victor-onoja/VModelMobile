import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vmodel/src/res/res.dart';

/// My app class to display the date range picker
class VWidgetsDatePickerUI extends StatefulWidget {
  final Function(DateTime)? selection;
  final DateTime? startDate;
  final DateTime? endDate;
  const VWidgetsDatePickerUI(
      {super.key, this.selection, this.startDate, this.endDate});

  @override
  VWidgetsDatePickerUIState createState() => VWidgetsDatePickerUIState();

  static openVModelDateTimeDialog({
    required Function(DateTime)? selection,
    required BuildContext context,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return VWidgetsDatePickerUI(
            selection: selection,
            startDate: startDate,
            endDate: endDate,
          );
        });
  }
}

/// State for MyApp
class VWidgetsDatePickerUIState extends State<VWidgetsDatePickerUI> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Theme(
        data: VModelTheme.lightMode,
        child: Scaffold(
          backgroundColor: VmodelColors.appBarBackgroundColor.withOpacity(0.3),
          body: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: MediaQuery.of(context).size.height / 2.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SfDateRangePicker(
                    showNavigationArrow: true,
                    allowViewNavigation: true,
                    showActionButtons: false,
                    toggleDaySelection: true,
                    minDate: widget.startDate,
                    maxDate: widget.endDate,
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                    headerStyle: const DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                    ),
                    confirmText: "OK",
                    onSubmit: (val) {
                      Navigator.of(context).pop();
                    },
                    headerHeight: 70,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: 13.sp,
                              ),
                      todayCellDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      /// The argument value will return the changed date as [DateTime] when the
                      /// widget [SfDateRangeSelectionMode] set as single.
                      Navigator.of(context).pop();
                      setState(() {
                        widget.selection!(args.value);
                      });
                    },
                    selectionMode: DateRangePickerSelectionMode.single,
                    view: DateRangePickerView.month,
                    initialSelectedRange: PickerDateRange(
                        widget.startDate ??
                            DateTime.now().subtract(const Duration(days: 4)),
                        widget.endDate ??
                            DateTime.now().add(const Duration(days: 3))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
