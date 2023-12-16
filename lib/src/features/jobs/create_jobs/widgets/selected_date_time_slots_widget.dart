import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/switch/primary_switch.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../controller/create_job_controller.dart';

class VWidgetsSelectedDateTimeDurationWidget extends ConsumerStatefulWidget {
  final String? selectedDate;
  final String? selectedDateDay;
  final ValueChanged<Duration>? durationForDate;
  final int dateTimeInMilliseconds;
  final DateTime dt;
  final Duration startTime;
  final Duration endTime;
  final JobDeliveryDate jobDeliveryDate;

  const VWidgetsSelectedDateTimeDurationWidget({
    super.key,
    required this.selectedDate,
    required this.selectedDateDay,
    this.durationForDate,
    required this.dateTimeInMilliseconds,
    required this.dt,
    required this.startTime,
    required this.endTime,
    required this.jobDeliveryDate,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VWidgetsSelectedDateTimeDurationWidgetState();
}

class _VWidgetsSelectedDateTimeDurationWidgetState
    extends ConsumerState<VWidgetsSelectedDateTimeDurationWidget> {
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
    startTimeDurationValue = widget.startTime;
    endTimeDurationValue = widget.endTime;
    switchValue = widget.jobDeliveryDate.isFullDay;
  }

  @override
  Widget build(BuildContext context) {
    final timeOptions = ref.watch(timeOpProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // child: switchValue
      child: widget.jobDeliveryDate.isFullDay
          ? Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: // ref.read(selectedDateTimeAndDurationProvider.notifier).add(
                    //     widget.dateTimeInMilliseconds,
                    //     endTimeDurationValue - startTimeDurationValue);
                    Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Full day",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                // color: VmodelColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        addHorizontalSpacing(8),
                        Text(
                          "8 HRs",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                // color: VmodelColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: VWidgetsSwitch(
                    //     swicthValue: switchValue,
                    //     onChanged: (val) {
                    //       setState(() {
                    //         switchValue = !switchValue;
                    //       });
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: VWidgetsSwitch(
                        swicthValue: widget.jobDeliveryDate.isFullDay,
                        onChanged: (val) {
                          // setState(() {
                          //   switchValue = !switchValue;
                          // });
                          if (val) {
                            ref
                                .read(selectedDateTimeAndDurationProvider
                                    .notifier)
                                .updateDeliveryDateTimes(widget.dt,
                                    start: timeOptions[18],
                                    end: timeOptions[34],
                                    isFullDay: val);
                          } else {
                            ref
                                .read(selectedDateTimeAndDurationProvider
                                    .notifier)
                                .updateDeliveryDateTimes(widget.dt,
                                    start: startTimeDurationValue,
                                    end: endTimeDurationValue,
                                    isFullDay: val);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.selectedDate!,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            // color: VmodelColors.primaryColor.withOpacity(0.5),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      widget.selectedDateDay!,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            // color: VmodelColors.primaryColor.withOpacity(0.5),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                addVerticalSpacing(10),
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
                      child: VWidgetsDropDownTextField<Duration>(
                        fieldLabel: "Start Time",
                        hintText: "",
                        // isExpanded: true,
                        // isOneLineEllipsize: true,
                        value: startTimeDurationValue,
                        onChanged: (val) {
                          startTimeDurationValue = val;
                          // if (widget.durationForDate != null) {
                          //   widget.durationForDate!(
                          //       endTimeDurationValue - startTimeDurationValue);
                          // }

                          endTimeStartIndex = min(timeOptions.indexOf(val) + 2,
                              timeOptions.length - 1);
                          print('UUUUUUUUUUUUUUUUUUUUU $endTimeStartIndex ');
                          if (endTimeDurationValue <
                              timeOptions[endTimeStartIndex]) {
                            endTimeDurationValue =
                                timeOptions[endTimeStartIndex];
                            ref
                                .read(selectedDateTimeAndDurationProvider
                                    .notifier)
                                .updateDeliveryDateTimes(widget.dt,
                                    start: val, end: endTimeDurationValue);
                          } else {
                            ref
                                .read(selectedDateTimeAndDurationProvider
                                    .notifier)
                                .updateDeliveryDateTimes(widget.dt, start: val);
                          }
                          setState(() {});
                          // ref
                          //     .read(
                          //         selectedDateTimeAndDurationProvider.notifier)
                          //     .add(
                          //         widget.dateTimeInMilliseconds,
                          //         endTimeDurationValue -
                          //             startTimeDurationValue);
                          // Future.delayed(const Duration(seconds: 2), () {
                          // ref
                          //     .read(calculatedTotalDurationProvider.notifier)
                          //     .update(endTimeDurationValue -
                          //         startTimeDurationValue);
                          // });
                        },
                        options: timeOptions.sublist(0, 48),
                        getLabel: (Duration value) => value.inHours.toString(),
                        customDisplay: (value) =>
                            value.getDurationForDropdown(),
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
                      child: VWidgetsDropDownTextField<Duration>(
                        fieldLabel: "End Time",
                        hintText: "",
                        // isExpanded: true,
                        // isOneLineEllipsize: true,
                        value: endTimeDurationValue,
                        onChanged: (val) {
                          endTimeDurationValue = val;
                          ref
                              .read(
                                  selectedDateTimeAndDurationProvider.notifier)
                              .updateDeliveryDateTimes(widget.dt, end: val);
                          setState(() {});
                          // ref
                          //     .read(
                          //         selectedDateTimeAndDurationProvider.notifier)
                          //     .add(
                          //         widget.dateTimeInMilliseconds,
                          //         endTimeDurationValue -
                          //             startTimeDurationValue);
                          // Future.delayed(const Duration(seconds: 2), () {
                          // ref
                          //     .read(calculatedTotalDurationProvider.notifier)
                          //     .update(endTimeDurationValue -
                          //         startTimeDurationValue);
                          // });
                          // WidgetsBinding.instance
                          //     .addPostFrameCallback((timeStamp) {
                          //   if (widget.durationForDate != null) {
                          //     widget.durationForDate!(endTimeDurationValue -
                          //         startTimeDurationValue);
                          //   }
                          // });
                        },
                        options: timeOptions.sublist(endTimeStartIndex),
                        // getLabel: (String value) => value,
                        customDisplay: (value) =>
                            value.getDurationForDropdown(),
                      ),
                    ),

                    addHorizontalSpacing(25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Day",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                // color: VmodelColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        addVerticalSpacing(0),
                        VWidgetsSwitch(
                          swicthValue: switchValue,
                          onChanged: (val) {
                            // startTimeDurationValue = timeOptions[];
                            // endTimeDurationValue = widget.endTime;
                            // ref
                            //     .read(
                            //         selectedDateTimeAndDurationProvider.notifier)
                            //     .updateDeliveryDateTimes(widget.dt,
                            //         isFullDay: val);
                            // switchValue = !switchValue;
                            // setState(() {});
                            if (val) {
                              ref
                                  .read(selectedDateTimeAndDurationProvider
                                      .notifier)
                                  .updateDeliveryDateTimes(widget.dt,
                                      start: timeOptions[18],
                                      end: timeOptions[34],
                                      isFullDay: val);
                            } else {
                              ref
                                  .read(selectedDateTimeAndDurationProvider
                                      .notifier)
                                  .updateDeliveryDateTimes(widget.dt,
                                      start: startTimeDurationValue,
                                      end: endTimeDurationValue,
                                      isFullDay: val);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
