import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/switch/primary_switch.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../shared/text_fields/dropdown_text_normal.dart';
import '../../../../jobs/create_jobs/controller/create_job_controller.dart';

class VWidgetsServiceLength extends ConsumerStatefulWidget {
  // final String? selectedDate;
  // final String? selectedDateDay;
  // final ValueChanged<Duration>? durationForDate;
  // final int dateTimeInMilliseconds;
  // final DateTime dt;
  // final Duration startTime;
  // final Duration endTime;

  const VWidgetsServiceLength({
    super.key,
    // required this.selectedDate,
    // required this.selectedDateDay,
    // this.durationForDate,
    // required this.dateTimeInMilliseconds,
    // required this.dt,
    // required this.startTime,
    // required this.endTime,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VWidgetsServiceLength();
}

class _VWidgetsServiceLength extends ConsumerState<VWidgetsServiceLength> {
  String heightFeet = "5";
  bool switchValue = false;
  String startTimeValue = "start...";
  String endTimeValue = "end...";
  Duration startTimeDurationValue = Duration.zero;
  Duration endTimeDurationValue = Duration.zero;

  int startTimeIndex = 0;
  int endTimeStartIndex = 20;

  @override
  void initState() {
    super.initState();
    // startTimeValue = startTimeList.first;
    // endTimeValue = startTimeList[16];
    // ref.read(selectedDateTimeAndDurationProvider.notifier).add(
    //     widget.dateTimeInMilliseconds,
    //     endTimeDjwidurationValue - startTimeDurationValue);
    // startTimeDurationValue = widget.startTime;
    // endTimeDurationValue = widget.endTime;
  }

  @override
  Widget build(BuildContext context) {
    final partLabelStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
          // color: Theme.of(context).primaryColor.withOpacity(0.4),
          // fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Service length",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    // color: Theme.of(context).primaryColor.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        addVerticalSpacing(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: VWidgetsDropdownNormal<int>(
                fieldLabel: "Days",
                fieldLabelStyle: partLabelStyle,
                hintText: "",
                // isExpanded: true,
                // isOneLineEllipsize: true,
                value: 0,
                items: List.generate(13, (index) => index),
                itemToString: (value) => value.toString().padLeft(2, '0'),
                validator: null,
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            Expanded(child: addHorizontalSpacing(16)),
            Flexible(
              flex: 2,
              child: VWidgetsDropdownNormal<int>(
                fieldLabel: "Hours",
                fieldLabelStyle: partLabelStyle,
                hintText: "",
                // isExpanded: true,
                // isOneLineEllipsize: true,
                value: 0,
                items: List.generate(13, (index) => index),
                itemToString: (value) => value.toString().padLeft(2, '0'),
                validator: null,
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            Expanded(child: addHorizontalSpacing(16)),
            Flexible(
              flex: 2,
              child: VWidgetsDropdownNormal<int>(
                fieldLabel: "Minutes",
                fieldLabelStyle: partLabelStyle,
                hintText: "",
                // isExpanded: true,
                // isOneLineEllipsize: true,
                value: 0,
                items: List.generate(5, (index) => (index) * 15),
                itemToString: (value) => value.toString().padLeft(2, '0'),
                validator: null,
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
