import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/booking/controller/calendar_event.dart';
import 'package:vmodel/src/features/jobs/create_jobs/widgets/selected_date_time_slots_widget.dart';
import 'package:vmodel/src/features/jobs/create_jobs/widgets/selected_date_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/utils/enum/service_pricing_enum.dart';
import '../../../../../core/utils/enum/work_location.dart';
import '../../../../../shared/text_fields/dropdown_text_normal.dart';
import '../../../../../shared/text_fields/places_autocomplete_field.dart';
import '../../../../authentication/register/provider/user_types_controller.dart';
import '../../../../jobs/create_jobs/controller/create_job_controller.dart';
import '../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../settings/views/booking_settings/controllers/unavailable_days_controller.dart';
import '../../../../settings/views/booking_settings/models/service_package_model.dart';
import '../create_booking_second.dart';

class CreateBookingFirstPage extends ConsumerStatefulWidget {
  const CreateBookingFirstPage(
      {super.key,
      required this.username,
      required this.displayName,
      this.unavailableDates});
  final String username;
  final String displayName;
  final List<DateTime>? unavailableDates;

  @override
  ConsumerState<CreateBookingFirstPage> createState() =>
      _CreateBookingFirstPageState();
}

class _CreateBookingFirstPageState
    extends ConsumerState<CreateBookingFirstPage> {
  double slideValue = 18;
  double amountSlide = 0;
  bool creativeBriefSwitchValue = false;
  String jobType = "Remote";
  late ServicePeriod priceType;
  String talentType = "Model";
  String duration = "Full-Day";
  String arrivalTime = "Morning";
  String gender = "Male";
  String ethinicity = "Asian";
  String budget = "Per Day";
  String identifiedGender = "Indentified Gender";
  String height = "5'11";
  String weight = "XL";
  String complexion = "Dark/Melanin";
  String deliveryDateType = "Range";

  String preferredGender = "Male";
  TextEditingController dateTime = TextEditingController();

  // @override
  // bool get wantKeepAlive => true;

  DateTime _focusedDay = DateTime.now();

  Set<DateTime> _selectedDays = {};

  ValueNotifier<List<Event>>? _selectedEvents;

  final Duration _dateTimeRes = const Duration();

  final _currencyFormatter = NumberFormat.simpleCurrency(locale: "en_GB");
  final _formKey = GlobalKey<FormState>();

  final _priceController = TextEditingController();
  final _titleController = TextEditingController();
  // final _talentNumberController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _briefTextController = TextEditingController();
  final _briefLinkController = TextEditingController();
  final bool _isMultipleApplicants = false;
  String _selectedLocation = "";
  List<DateTime>? unavailableDates = [];

  final mockServices = const [
    "I will be your model for 3 hours",
    "I wil shoot a video for your event",
    "Contact me for to capture your memorable moments"
  ];

  ServicePackageModel? selectedMockService;

  // List<Duration> startTimes = [];

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
    _selectedDays = LinkedHashSet<DateTime>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    // selectedMockService = mockServices.first;
    // startTimes =
    //     List.generate(48, (index) => Duration(minutes: index * 30)).toList();
    // startTimeDurationValue = startTimes[18];
    // endTimeDurationValue = startTimes[34];
    priceType = ServicePeriod.values.last;
    // final startT = DateTime.now();
    // final endT = startT.add(Duration(hours: 8));
    // _dateTimeRes = endT.difference(startT);
    unavailableDates = widget.unavailableDates;
  }

  @override
  void dispose() {
    _selectedEvents!.dispose();
    _priceController.dispose();
    _titleController.dispose();
    // _talentNumberController.dispose();
    _shortDescriptionController.dispose();
    _briefTextController.dispose();
    _briefLinkController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   setState(() {
  //     if (_selectedDays.contains(selectedDay)) {
  //       _selectedDays.remove(selectedDay);
  //     } else {
  //       _selectedDays.add(selectedDay);
  //     }
  //   });
  //   _selectedEvents!.value = _getEventsForDays(_selectedDays);
  //   _focusedDay = focusedDay;
  // }

  /// Remove selected dates
  void _removeSelectedDate(DateTime selectedDay) {
    if (_selectedDays.contains(selectedDay)) {
      _selectedDays.remove(selectedDay);
    }
    setState(() {});
  }

  /// Single Selection Function of date[When Price type is "Per service iin create a job first Page"]
  void _singleDateSelection(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.isEmpty) {
        _selectedDays.add(selectedDay);
      } else {
        _selectedDays.clear();
        _selectedDays.add(selectedDay);
      }
    });
    _selectedEvents!.value = _getEventsForDays(_selectedDays);
    _focusedDay = focusedDay;
  }

  bool _isDateDisabled(DateTime day) {
    var date = DateTime.parse(day.toIso8601String().split("T")[0]);
    if (widget.unavailableDates!.isNotEmpty) {
      print(widget.unavailableDates![0]);
      return widget.unavailableDates!.contains(date);
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicePackagesProvider(widget.username));
    final mySelectedDates = ref.watch(selectedDateTimeAndDurationProvider);
    final calculatedDuration = ref.watch(calculatedTotalDurationProvider);
    final timeOptions = ref.watch(timeOpProvider);
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;
    final tempJobData = ref.watch(jobDataProvider);
    if (unavailableDates == null) {
      unavailableDates = [];
      final temp =
          ref.watch(unavailableDaysProvider(widget.username)).valueOrNull ?? [];
      for (var data in temp) {
        unavailableDates!.add(data.date!);
      }
    }

    return Portal(
      child: Scaffold(
        appBar: VWidgetsAppBar(
          appBarHeight: 50,
          leadingIcon: VWidgetsBackButton(
            onTap: () {
              goBack(context);
              ref.invalidate(selectedDateTimeAndDurationProvider);
            },
          ),
          appbarTitle: "Book ${widget.displayName}",
        ),
        body: SingleChildScrollView(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpacing(20),

                services.when(data: (items) {
                  if (items.isEmpty) return Text('User has no services.');

                  final nonPausedServices =
                      items.where((element) => !element.paused).toList();

                  selectedMockService ??= items.first;

                  return VWidgetsDropdownNormal(
                    validator: null,
                    items: nonPausedServices,
                    isExpanded: true,
                    fieldLabel: "Select Gig or Service",
                    onChanged: (val) {
                      setState(() {
                        selectedMockService = val;
                      });
                    },
                    value: selectedMockService,
                    itemToString: (value) => value.title,
                    // heightForErrorText: 0,
                  );
                }, error: ((error, stackTrace) {
                  return Center(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child:
                            CircularProgressIndicator.adaptive(strokeWidth: 3)),
                  );
                }), loading: () {
                  return Text('No services');
                }),
                addVerticalSpacing(15),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Flexible(
                //       child: VWidgetsDropDownTextField(
                //         prefixText: "test",
                //         hintText: "",
                //         options: const ["On-Location", "Hybrid", "Remote"],
                //         fieldLabel: "Service Type",
                //         onChanged: (val) {
                //           setState(() {
                //             jobType = val;
                //           });
                //         },
                //         value: jobType,
                //         getLabel: (String value) => value,
                //         // heightForErrorText: 0,
                //       ),
                //     ),
                //     addHorizontalSpacing(10),
                //     Flexible(
                //       child: VWidgetsDropDownTextField<ServicePeriod>(
                //         hintText: "",
                //         options: ServicePeriod
                //             .values, //const ["Per service", "Per hour"],
                //         fieldLabel: "Price",
                //         onChanged: (val) {
                //           // ref
                //           //         .read(createJobIsSingleSelectionProvider.notifier)
                //           //         .state =
                //           //     !ref
                //           //         .read(createJobIsSingleSelectionProvider.notifier)
                //           //         .state;

                //           // _focusedDay = null;

                //           if (priceType != val) {
                //             ref.invalidate(selectedDateTimeAndDurationProvider);
                //           }

                //           setState(() {
                //             priceType = val;
                //           });
                //         },
                //         value: priceType,
                //         // getLabel: (String value) => value,
                //         customDisplay: (value) => value.tileDisplayName,
                //       ),
                //     ),
                //     // Flexible(
                //     //   child: VWidgetsPrimaryTextFieldWithTitle(
                //     //     label: "",
                //     //     minLines: 1,
                //     //     hintText: "Ex. 250",
                //     //     controller: _priceController,
                //     //     validator: VValidatorsMixin.isNotEmpty,
                //     //     isIncreaseHeightForErrorText: true,
                //     //     formatters: [
                //     //       FilteringTextInputFormatter.allow(
                //     //           RegExp(r'(^\d*\.?\d*)'))
                //     //     ],
                //     //     keyboardType: TextInputType.number,
                //     //     onChanged: (val) {
                //     //       setState(() {});
                //     //     },
                //     //     //onSaved: (){},
                //     //   ),
                //     // ),
                //   ],
                // ),

                if (selectedMockService?.serviceType !=
                    WorkLocation.remote) ...[
                  addVerticalSpacing(8),
                  PlacesAutocompletionField(
                    label: "Address",
                    hintText: "Start typing address...",
                    isFollowerTop: false,
                    onItemSelected: (value) {
                      if (!mounted) return;
                      _selectedLocation = value;
                    },
                    postOnChanged: (String value) {},
                  ),
                ],
                addVerticalSpacing(10),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                  child: TableCalendar(
                    availableGestures: AvailableGestures.horizontalSwipe,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2040),
                    focusedDay: _focusedDay,
                    enabledDayPredicate: (day) {
                      var date =
                          DateTime.parse(day.toIso8601String().split("T")[0]);
                      if (unavailableDates!.isNotEmpty) {
                        return !unavailableDates!.contains(date);
                      } else {
                        return true;
                      }
                    },
                    eventLoader: (val) => [], //_getEventsForDay,
                    selectedDayPredicate: (day) {
                      // return _selectedDays.contains(day);
                      // return mySelectedDates.contains(day);
                      return ref
                          .read(selectedDateTimeAndDurationProvider.notifier)
                          .containsDateTime(day);
                    },
                    onDaySelected: (date, fdate) {
                      // priceType == ServicePeriod.service
                      // ? _singleDateSelection(date, fdate)
                      // : _onDaySelected(date, fdate);
                      setState(() {});
                      ref
                          .read(selectedDateTimeAndDurationProvider.notifier)
                          .add(
                              dateTime: date,
                              start: timeOptions[18], //9:00am
                              end: timeOptions[34], //5:00pm
                              priceType: priceType);

                      // Future.delayed(Duration(seconds: 1), () {
                      //   setState(() {});
                      // });
                    },

                    // _onDaySelected,
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    headerStyle: HeaderStyle(
                      titleTextStyle:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                // color: Theme.of(context).primaryColor,
                              ), // VWidgetsDropDownTextField(
                      //   fieldLabel: "Delivery date type",
                      //   hintText: "",
                      //   onChanged: (val) {
                      //     setState(() {
                      //       deliveryDateType = val;
                      //     });
                      //   },
                      //   value: deliveryDateType,
                      //   options: const ["Range", "Range 2"],
                      //   getLabel: (String value) => value,
                      // ),
                      leftChevronIcon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        // color: VmodelColors.primaryColor,
                        size: 20,
                      ),
                      formatButtonVisible: false,
                      titleCentered: true,
                      rightChevronIcon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        // color: VmodelColors.primaryColor,
                        size: 20,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      todayTextStyle:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          // color: VmodelColors.primaryColor,
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: Theme.of(context).textTheme.bodyMedium!,
                      weekendStyle: Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
                ),
                addVerticalSpacing(16),
                if (mySelectedDates.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Expected delivery",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      addVerticalSpacing(25),
                    ],
                  ),
                // Padding(
                //     padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                //     child: ListView.builder(
                //       // key: UniqueKey(),
                //       physics: const NeverScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       // cacheExtent: 1000,
                //       itemCount: _selectedDays!.length,
                //       itemBuilder: (context, index) {
                //         //Date Formats
                //         final selectedDate = _selectedDays!.toList()[index];
                //         final date = DateFormat("MMMM dd, y")
                //             .format(_selectedDays!.toList()[index]);
                //         final weekDay = DateFormat("EEEE")
                //             .format(_selectedDays!.toList()[index]);

                //         return VWidgetsSelectedDateWidget(
                //             selectedDate: date,
                //             selectedDateDay: weekDay,
                //             onTapCancel: () {
                //               setState(() {
                //                 _removeSelectedDate(selectedDate);
                //               });
                //             });
                //       },
                //     )),
                //just now
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                  child: Column(
                    // key: UniqueKey(),
                    // physics: const NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    // cacheExtent: 1000,
                    // itemCount: _selectedDays!.length,
                    // itemBuilder: (context, index) {
                    mainAxisSize: MainAxisSize.min,
                    //Date Formats
                    children: List.generate(mySelectedDates.length, (index) {
                      final selectedDate = mySelectedDates[index];
                      final date = DateFormat("MMMM dd, y")
                          .format(mySelectedDates[index].date);
                      final weekDay = DateFormat("EEEE")
                          .format(mySelectedDates[index].date);

                      return VWidgetsSelectedDateWidget(
                          selectedDate: date,
                          selectedDateDay: weekDay,
                          onTapCancel: () {
                            // setState(() {
                            //   _removeSelectedDate(selectedDate);
                            // });
                          });
                    }),
                    // },
                  ),
                ),
                addVerticalSpacing(16),
                const Divider(thickness: 1),
                addVerticalSpacing(16),
                // Padding(
                //     padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                //     child: ListView.builder(
                //       // key: UniqueKey(),
                //       physics: const NeverScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       // cacheExtent: 1000,
                //       itemCount: _selectedDays.length,
                //       itemBuilder: (context, index) {
                //         //Date Formats
                //         final date = DateFormat("MMMM dd, y")
                //             .format(_selectedDays.toList()[index]);
                //         final weekDay = DateFormat("EEEE")
                //             .format(_selectedDays.toList()[index]);

                //         return VWidgetsSelectedDateTimeDurationWidget(
                //           dateTimeInMilliseconds:
                //               _selectedDays.toList()[index].millisecondsSinceEpoch,
                //           selectedDate: date,
                //           selectedDateDay: weekDay,
                //           durationForDate: (value) {
                //             // print(
                //             //     'DDDDDDDDDDDDDDDDDDDdduration difference is ${value}');
                //             // _dateTimeRes = value;
                //             // setState(() {});
                //           },
                //         );
                //       },
                //     )),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                  child: Column(
                      // key: UniqueKey(),
                      mainAxisSize: MainAxisSize.min,
                      // cacheExtent: 1000,
                      // itemCount: _selectedDays.length,
                      // itemBuilder: (context, index) {
                      //Date Formats
                      children: List.generate(mySelectedDates.length, (index) {
                        final selectedDate = mySelectedDates[index];
                        final date = DateFormat("MMMM dd, y")
                            .format(mySelectedDates[index].date);
                        final weekDay = DateFormat("EEEE")
                            .format(mySelectedDates[index].date);

                        return VWidgetsSelectedDateTimeDurationWidget(
                          key: ValueKey(
                              selectedDate.date.millisecondsSinceEpoch),
                          jobDeliveryDate: selectedDate,
                          dt: selectedDate.date,
                          startTime: selectedDate.startTime,
                          endTime: selectedDate.endTime,
                          dateTimeInMilliseconds: 2,
                          selectedDate: date,
                          selectedDateDay: weekDay,
                          durationForDate: (value) {
                            // print(
                            //     'DDDDDDDDDDDDDDDDDDDdduration difference is ${value}');
                            // _dateTimeRes = value;
                            // setState(() {});
                          },
                        );
                      })
                      // },
                      ),
                ),
                addVerticalSpacing(0),
                if (mySelectedDates.isNotEmpty)
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: mySelectedDates.isEmpty ? 0 : null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: context.theme.colorScheme.onPrimary
                                .withOpacity(0.2),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const RenderSvgWithoutColor(
                              svgPath: VIcons.timer,
                              svgWidth: 28,
                              svgHeight: 28,
                            ),
                            addHorizontalSpacing(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                  addVerticalSpacing(2),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      children: List.generate(
                                          mySelectedDates.length, (index) {
                                        final dateDuration =
                                            mySelectedDates[index]
                                                .dateDuration
                                                .dayHourMinuteSecondFormatted();
                                        if (index ==
                                            mySelectedDates.length - 1) {
                                          return TextSpan(text: dateDuration);
                                        }
                                        return TextSpan(
                                          text: "$dateDuration + ",
                                        );
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            addHorizontalSpacing(16),
                            Text(
                              // '19',
                              calculatedDuration.dayHourMinuteSecondFormatted(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                      color: Theme.of(context).primaryColor),
                            ),
                            addHorizontalSpacing(4),
                            Text(
                              'HRS',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                addVerticalSpacing(32),
                VWidgetsPrimaryButton(
                  enableButton: true,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    // if (!_formKey.currentState!.validate()) {
                    //   VWidgetShowResponse.showToast(ResponseEnum.warning,
                    //       message: 'Please fill required fields');
                    //   return;
                    // } else if (mySelectedDates.isEmpty) {
                    //   VWidgetShowResponse.showToast(ResponseEnum.warning,
                    //       message: 'Please select a booking date');
                    //   return;
                    // }
                    // final temp = ref
                    //     .read(jobDataProvider.notifier)
                    //     .state
                    //     .copyWith(
                    //       jobTitle: _titleController.text.trim(),
                    //       jobType: jobType,
                    //       preferredGender: gender,
                    //       priceOption: priceType.simpleName,
                    //       priceValue: double.parse(_priceController.text.trim()),
                    //       talents: [
                    //         {
                    //           "talentType": talentType,
                    //           // "numOfTalent": int.parse(
                    //           //   _talentNumberController.text.trim(),
                    //           "numOfTalent": 1
                    //         }
                    //       ],
                    //       shortDescription: _shortDescriptionController.text,
                    //       brief: _briefTextController.text,
                    //       briefLink: _briefLinkController.text,
                    //     );
                    // ref.read(jobDataProvider.notifier).state = temp;
                    navigateToRoute(
                        context, CreateBookingSecondPage(jobType: jobType));
                  },
                  buttonTitle: "Continue",
                ),
                addVerticalSpacing(50)
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getTotalPrice(Duration duration) {
    final price = double.tryParse(_priceController.text) ?? 0;
    return (duration.inMinutes / 60) * price;
  }
}
