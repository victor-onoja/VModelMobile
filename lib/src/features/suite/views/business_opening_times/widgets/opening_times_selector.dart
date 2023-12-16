import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_normal.dart';

import '../../../../../res/res.dart';
import '../../../../../shared/switch/primary_switch.dart';
import '../../../../../vmodel.dart';
import '../../../../jobs/create_jobs/controller/create_job_controller.dart';
import '../models/simple_open_time.dart';

class OpeningTimesSelectorWidget extends ConsumerStatefulWidget {
  const OpeningTimesSelectorWidget({
    super.key,
    required this.dayOfWeek,
    required this.openTime,
    required this.onChanged,
  });

  final String dayOfWeek;
  final SimpleOpenTime openTime;
  final ValueChanged<SimpleOpenTime> onChanged;

  @override
  ConsumerState<OpeningTimesSelectorWidget> createState() =>
      _OpeningTimesSelectorWidgetState();
}

class _OpeningTimesSelectorWidgetState
    extends ConsumerState<OpeningTimesSelectorWidget> {
  Duration startTimeDurationValue = Duration(hours: 9);
  Duration endTimeDurationValue = Duration(hours: 17);

  // int startTimeIndex = 0;
  //start index of closing time options is 2 indices greater than index of
  // statTimeDuratoinValue
  int endTimeStartIndex = 2;
  bool isAllDay = false;

  @override
  initState() {
    super.initState();

    final workingHours = ref.read(timeOpProvider);
    if (widget.openTime.open != null) {
      startTimeDurationValue = timeStringToDuration(widget.openTime.open!);
      endTimeStartIndex = min(workingHours.indexOf(startTimeDurationValue) + 2,
          workingHours.length - 1);
    }
    if (widget.openTime.close != null) {
      endTimeDurationValue = timeStringToDuration(widget.openTime.close!);
    }
    isAllDay = widget.openTime.allDay;
  }

  @override
  Widget build(BuildContext context) {
    print('[bhsh] $endTimeStartIndex');
    final timeOptions = ref.watch(timeOpProvider);
    // final ssl = timeOptions.sublist(endTimeStartIndex);
    // print('[kssi] $ssl');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.openTime.day,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    // color: isDisabled
                    // ? Theme.of(context).primaryColor.withOpacity(.5)
                    // color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
        addVerticalSpacing(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Flexible(
            //   child: VWidgetsDropDownTextField(
            //     fieldLabel: "Start Time",
            //     hintText: "",
            //     value: startTimeValue,
            //     onChanged: (val) {
            //       setState(() {
            //         startTimeValue = val;
            //       });
            //     },
            //     options: startTimeList,
            //     getLabel: (String value) => value,
            //   ),
            // ),

            Flexible(
              child: VWidgetsDropdownNormal<Duration>(
                fieldLabel: "Opening",
                fieldLabelStyle: dropdownFieldStyle(!isAllDay),
                hintText: "",
                // isExpanded: true,
                // isOneLineEllipsize: true,
                validator: null,
                value: startTimeDurationValue,
                onChanged: isAllDay
                    ? null
                    : (val) {
                        startTimeDurationValue = val!;
                        endTimeStartIndex = min(timeOptions.indexOf(val) + 2,
                            timeOptions.length - 1);
                        print('UUUUUUUUUUUUUUUUUUUUU $endTimeStartIndex ');
                        if (endTimeDurationValue <
                            timeOptions[endTimeStartIndex]) {
                          endTimeDurationValue = timeOptions[endTimeStartIndex];
                        }

                        widget.onChanged(widget.openTime.copyWith(
                            open: val.toHourMinutes,
                            close: endTimeDurationValue.toHourMinutes));
                        setState(() {});
                      },
                items: timeOptions.sublist(0, 48),
                // getLabel: (Duration value) => value.inHours.toString(),
                itemToString: (value) => value.getDurationForDropdown(),
              ),
            ),

            addHorizontalSpacing(10),
            // Flexible(
            //   child: VWidgetsDropDownTextField(
            //     fieldLabel: "End Time",
            //     hintText: "",
            //     value: endTimeValue,
            //     onChanged: (val) {
            //       setState(() {
            //         endTimeValue = val;
            //       });
            //     },
            //     options: endTimeList,
            //     getLabel: (String value) => value,
            //   ),
            // ),

            Flexible(
              child: VWidgetsDropdownNormal<Duration>(
                fieldLabel: "Closing",
                fieldLabelStyle: dropdownFieldStyle(!isAllDay),
                hintText: "",
                // isExpanded: true,
                // isOneLineEllipsize: true,
                validator: null,
                value: endTimeDurationValue,
                onChanged: isAllDay
                    ? null
                    : (val) {
                        print('oooww $val');
                        endTimeDurationValue = val!;

                        widget.onChanged(
                          widget.openTime.copyWith(
                            open: startTimeDurationValue.toHourMinutes,
                            close: val.toHourMinutes,
                          ),
                        );
                        setState(() {});
                      },
                // options: timeOptions.sublist(endTimeStartIndex),

                items: timeOptions.sublist(endTimeStartIndex),
                // getLabel: (String value) => value,
                itemToString: (value) => value.getDurationForDropdown(),
              ),
            ),

            addHorizontalSpacing(25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("24/7", style: dropdownFieldStyle(isAllDay)),
                addVerticalSpacing(16),
                VWidgetsSwitch(
                  swicthValue: isAllDay,
                  onChanged: (val) {
                    // startTimeDurationValue = timeOptions[];
                    // endTimeDurationValue = widget.endTime;
                    // ref
                    //     .read(
                    //         selectedDateTimeAndDurationProvider.notifier)
                    //     .updateDeliveryDateTimes(widget.dt,
                    //         isFullDay: val);
                    // switchValue = !switchValue;
                    isAllDay = val;

                    if (isAllDay) {
                      widget.onChanged(widget.openTime.alwaysOpen);
                    } else {
                      widget.onChanged(widget.openTime.copyWith(
                        day: widget.openTime.day,
                        open: startTimeDurationValue.toHourMinutes,
                        close: endTimeDurationValue.toHourMinutes,
                        allDay: isAllDay,
                      ));
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  TextStyle dropdownFieldStyle(bool enabled) {
    return enabled
        ? Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w500,
            )
        : Theme.of(context).textTheme.displayMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context)
                .textTheme
                .displayMedium
                ?.color
                ?.withOpacity(0.5));
  }
}
