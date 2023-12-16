import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/booking/controller/calendar_event.dart';
import 'package:vmodel/src/features/jobs/create_jobs/model/job_data.dart';
import 'package:vmodel/src/features/jobs/create_jobs/views/create_job_view_second.dart';
import 'package:vmodel/src/features/jobs/create_jobs/widgets/selected_date_time_slots_widget.dart';
import 'package:vmodel/src/features/jobs/create_jobs/widgets/selected_date_widget.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/shared/switch/primary_switch.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_normal.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/gender_enum.dart';
import '../../../../core/utils/enum/service_pricing_enum.dart';
import '../../../../res/ui_constants.dart';
import '../../../../shared/popup_dialogs/popup_without_save.dart';
import '../../../authentication/register/provider/user_types_controller.dart';
import '../../job_market/model/job_post_model.dart';
import '../controller/create_job_controller.dart';

class CreateJobFirstPage extends ConsumerStatefulWidget {
  const CreateJobFirstPage({
    super.key,
    this.job,
    this.isEdit = false,
  });
  final JobPostModel? job;
  final bool isEdit;

  @override
  ConsumerState<CreateJobFirstPage> createState() => _CreateJobFirstPageState();
}

class _CreateJobFirstPageState extends ConsumerState<CreateJobFirstPage> {
  double slideValue = 18;
  double amountSlide = 0;
  bool creativeBriefSwitchValue = false;
  String? jobType;
  String? categoryType;
  late ServicePeriod priceType;
  String talentType = "Model";
  String duration = "Full-Day";
  String arrivalTime = "Morning";
  String ethinicity = "Asian";
  String budget = "Per Day";
  String identifiedGender = "Indentified Gender";
  String height = "5'11";
  String weight = "XL";
  String complexion = "Dark/Melanin";
  String deliveryDateType = "Range";

  Gender preferredGender = Gender.values.first;
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
  bool _isMultipleApplicants = false;
  bool _isPopupClosed = false;
  List<JobDeliveryDate> mySelectedDates = [];
  String lastValidInput = '';

  // List<Duration> startTimes = [];

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
    _selectedDays = LinkedHashSet<DateTime>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    // getSavedJobTemp();

    // if (!jobType.contains('On-Location')){
    //   Future.delayed(Duration.zero, () => jobDialog(context));
    // }
    // Future.delayed(Duration.zero, () => jobDialog(context));

    // if (!jobType.contains('On-Location')) {
    //   return showDialog(
    //     context: context,
    //     builder: (context) => VWidgetsConfirmationPopUp(
    //       popupTitle: "",
    //       popupDescription: "Only ID Verified members can book on site jobs",
    //       onPressedYes: () async {},
    //       onPressedNo: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //   );
    // }

    // startTimes =
    //     List.generate(48, (index) => Duration(minutes: index * 30)).toList();
    // startTimeDurationValue = startTimes[18];
    // endTimeDurationValue = startTimes[34];
    priceType = ServicePeriod.values.last;
    // final startT = DateTime.now();
    // final endT = startT.add(Duration(hours: 8));
    // _dateTimeRes = endT.difference(startT);

    if (widget.job != null) initJobDetails();

    _titleController.addListener(() {
      print("is text ${isText(_titleController.text)}");
      if (_titleController.text.isNotEmpty) {
        if (!containsEmoji(_titleController.text)) {
          print("is imojie");
          _titleController.clear();
        } else {
          print("Is text");
        }
      } else {
        lastValidInput = _titleController.text;
      }
      setState(() {});
    });
  }

  void initJobDetails() {
    _titleController.text = widget.job!.jobTitle;
    _priceController.text = '${widget.job!.priceValue.round()}';
    _shortDescriptionController.text = widget.job!.shortDescription;
    _briefTextController.text = widget.job!.brief ?? '';
    _briefLinkController.text = widget.job!.briefLink ?? '';
    jobType = widget.job!.jobType;

    preferredGender = Gender.genderByApiValue(widget.job!.preferredGender);
    priceType = widget.job!.priceOption;
    creativeBriefSwitchValue = widget.job!.hasBrief;
    talentType = widget.job!.talents.first;
    _isMultipleApplicants = widget.job!.acceptingMultipleApplicants;
    categoryType = widget.job!.category;

    //Set selected dates in calendar

    // Future.delayed(const Duration(seconds: 1), () {
    //   ref
    //       .read(selectedDateTimeAndDurationProvider.notifier)
    //       .setAll(widget.job!.jobDelivery);
    // });
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
    ref.invalidate(jobDataProvider);
    super.dispose();
  }

  void getSavedJobTemp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pref = VModelSharedPrefStorage();
    if (prefs.containsKey("temp_job")) {
      print("tempt");
      var data = await pref.getJson("temp_job");
      shoGetDraftPompt(data);
    } else {
      print("No draft");
    }
  }

  void saveJobTemp(var data) async {
    final pref = VModelSharedPrefStorage();
    await pref.putJson("temp_job", data);
  }

  void showSaveDraftPompt(JobDataModel tempJobData) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              height: SizerUtil.height * 0.25,
              width: SizerUtil.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  addVerticalSpacing(20),
                  VWidgetsPrimaryButton(
                    butttonWidth: MediaQuery.of(context).size.width / 1.8,
                    onPressed: () {
                      saveJobTemp(tempJobData);
                      goBack(context);
                      goBack(context);
                    },
                    enableButton: true,
                    buttonTitle: "Save Draft",
                  ),
                  addVerticalSpacing(10),
                  VWidgetsPrimaryButton(
                    butttonWidth: MediaQuery.of(context).size.width / 1.8,
                    onPressed: () {
                      goBack(context);
                      ref.invalidate(selectedDateTimeAndDurationProvider);
                      goBack(context);
                    },
                    enableButton: true,
                    buttonTitle: "Discard Changes",
                  ),
                  addVerticalSpacing(10),
                  VWidgetsPrimaryButton(
                    buttonColor: Colors.transparent,
                    butttonWidth: MediaQuery.of(context).size.width / 1.8,
                    onPressed: () {
                      goBack(context);
                    },
                    enableButton: true,
                    buttonTitle: "Go back",
                  ),
                ],
              ),
            ),
          );
        });
  }

  void shoGetDraftPompt(var data) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              height: SizerUtil.height * 0.25,
              width: SizerUtil.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  addVerticalSpacing(20),
                  VWidgetsPrimaryButton(
                    butttonWidth: MediaQuery.of(context).size.width / 1.8,
                    onPressed: () {
                      ref.read(jobDataProvider.notifier).state =
                          JobDataModel.fromJson(data);
                      goBack(context);
                    },
                    enableButton: true,
                    buttonTitle: "Load Saved Draft",
                  ),
                  addVerticalSpacing(10),
                  VWidgetsPrimaryButton(
                    butttonWidth: MediaQuery.of(context).size.width / 1.8,
                    onPressed: () {
                      goBack(context);
                      ref.invalidate(selectedDateTimeAndDurationProvider);
                      goBack(context);
                    },
                    enableButton: true,
                    buttonTitle: "Discard Draft",
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool isText(String input) {
    final alphanumericPattern = RegExp(r'^[A-Za-z0-9]+$');
    return alphanumericPattern.hasMatch(input);
  }

  bool containsEmoji(String text) {
    // Define a regular expression pattern to match emojis
    final RegExp regexEmoji = RegExp(
        r'(\\u00a9|\\u00ae|[\\u2000-\\u3300]|\\ud83c[\\ud000-\\udfff]|\\ud83d[\\ud000-\\udfff]|\\ud83e[\\ud000-\\udfff])');
    return regexEmoji.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    mySelectedDates = ref.watch(selectedDateTimeAndDurationProvider);
    final calculatedDuration = ref.watch(calculatedTotalDurationProvider);
    final timeOptions = ref.watch(timeOpProvider);
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;
    final tempJobData = ref.watch(jobDataProvider);
    print(tempJobData);

    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        leadingIcon: VWidgetsBackButton(
          onTap: () {
            if (tempJobData!.jobTitle.isEmpty) {
              goBack(context);
            } else {
              showSaveDraftPompt(tempJobData);
            }
          },
        ),
        appbarTitle: "Create a job",
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
              VWidgetsTextFieldNormal(
                labelText: 'Job Title',
                controller: _titleController,
                inputFormatters: [
                  UppercaseLimitTextInputFormatter(),
                ],
                textCapitalization: TextCapitalization.sentences,
                hintText: 'Eg. Vmodel',
                onChanged: (p0) {
                  final temp =
                      ref.read(jobDataProvider.notifier).state?.copyWith(
                            jobTitle: p0!.trim(),
                          );
                  ref.read(jobDataProvider.notifier).state = temp;
                  setState(() {});
                },
                validator: (value) => VValidatorsMixin.isNotEmpty(value),
              ),
              addVerticalSpacing(15),
              Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: VWidgetsDropdownNormal(
                          fieldLabel: "Job Type",
                          hintText: jobType == null ? "Select..." : null,
                          items: const ["On-Location", "Hybrid", "Remote"],
                          value: jobType,
                          validator: (val) {
                            if (val == null) {
                              return '';
                            }
                            return null;
                          },
                          itemToString: (val) => val,
                          onChanged: (val) {
                            setState(() {
                              // dropdownIdentifyValue = val;
                              jobType = val!;
                              if (!jobType!.contains('Remote')) {
                                Future.delayed(const Duration(milliseconds: 2),
                                    () => jobDialog(context));
                              }
                              final temp = ref
                                  .read(jobDataProvider.notifier)
                                  .state
                                  ?.copyWith(
                                    jobType: jobType,
                                  );
                              ref.read(jobDataProvider.notifier).state = temp;
                              print(tempJobData);
                            });
                          },
                        ),
                      ),
                      addHorizontalSpacing(10),
                      Flexible(
                        child: VWidgetsDropdownNormal(
                          fieldLabel: "Category",
                          isExpanded: true,
                          hintText: categoryType == null ? "Select..." : null,
                          items: VConstants.tempCategories,
                          value: categoryType,
                          validator: (val) {
                            if (val == null) {
                              return '';
                            }
                            return null;
                          },
                          itemToString: (val) => val,
                          onChanged: (val) {
                            setState(() {
                              // dropdownIdentifyValue = val;
                              categoryType = val!;
                            });
                            final temp = ref
                                .read(jobDataProvider.notifier)
                                .state
                                ?.copyWith(
                                  category: categoryType == null
                                      ? null
                                      : [categoryType!],
                                );
                            ref.read(jobDataProvider.notifier).state = temp;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              addVerticalSpacing(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: VWidgetsDropdownNormal(
                          fieldLabel: 'Price',
                          itemToString: (val) => val.toString(),
                          items: ServicePeriod.values,
                          onChanged: (val) {
                            if (priceType != val) {
                              ref.invalidate(
                                  selectedDateTimeAndDurationProvider);
                            }

                            setState(() {
                              priceType = val!;
                            });
                            final temp = ref
                                .read(jobDataProvider.notifier)
                                .state
                                ?.copyWith(
                                  priceOption: priceType.simpleName,
                                );
                            ref.read(jobDataProvider.notifier).state = temp;
                          },
                          value: priceType,
                          validator: (val) {
                            return null;
                          })),
                  addHorizontalSpacing(10),
                  Flexible(
                      child: Column(
                    children: [
                      VWidgetsTextFieldNormal(
                        labelText: '',
                        hintText: "${VMString.poundSymbol} 250",
                        controller: _priceController,
                        validator: VValidatorsMixin.isNotEmpty,
                        onChanged: (val) {
                          setState(() {});
                          final temp = ref
                              .read(jobDataProvider.notifier)
                              .state
                              ?.copyWith(
                                priceValue:
                                    double.parse(_priceController.text.trim()),
                              );
                          ref.read(jobDataProvider.notifier).state = temp;
                        },
                        inputFormatters: [
                          // FilteringTextInputFormatter.allow(
                          // RegExp(r'(^\d*\.?\d*)'))
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ))
                ],
              ),
              addVerticalSpacing(15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: VWidgetsDropdownNormal(
                          value: talentType,
                          fieldLabel: "Talent",
                          itemToString: (val) => val.toString(),
                          items: allUserTypes?.talents ?? [],
                          onChanged: (val) {
                            setState(() {
                              talentType = val!;
                            });
                            final temp = ref
                                .read(jobDataProvider.notifier)
                                .state
                                ?.copyWith(
                              talents: [talentType],
                            );
                            ref.read(jobDataProvider.notifier).state = temp;
                          },
                          validator: (val) {
                            return null;
                          })),
                  // Flexible(
                  //   child: VWidgetsDropDownTextField<String>(
                  //     hintText: "",
                  //     // options: const ["Model", "Artist", "Photographer"],
                  //     options: allUserTypes?.talents ?? [],
                  //     fieldLabel: "Talent",
                  //     onChanged: (val) {
                  //       setState(() {
                  //         talentType = val;
                  //       });
                  //     },
                  //     value: talentType,
                  //     getLabel: (String value) => value,
                  //   ),
                  // ),
                  addHorizontalSpacing(10),
                  Flexible(
                      child: VWidgetsDropdownNormal(
                          value: preferredGender,
                          fieldLabel: "Gender",
                          itemToString: (val) => val.toString(),
                          items: Gender.values,
                          onChanged: (val) {
                            setState(() {
                              preferredGender = val!;
                            });
                            final temp = ref
                                .read(jobDataProvider.notifier)
                                .state
                                ?.copyWith(
                                  preferredGender: preferredGender.apiValue,
                                );
                            ref.read(jobDataProvider.notifier).state = temp;
                          },
                          validator: (val) {
                            return null;
                          })),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Accepting multiple applicants",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  // CupertinoSwitch(value: value, onChanged: onChanged)
                  VWidgetsSwitch(
                    swicthValue: _isMultipleApplicants,
                    onChanged: (value) {
                      _isMultipleApplicants = value;
                      setState(() {});

                      final temp =
                          ref.read(jobDataProvider.notifier).state?.copyWith(
                                acceptMultiple: _isMultipleApplicants,
                              );
                      ref.read(jobDataProvider.notifier).state = temp;
                    },
                  ),
                ],
              ),
              addVerticalSpacing(5),
              addVerticalSpacing(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Delivery Date",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor.withOpacity(0.4)),
                  ),
                ],
              ),
              addVerticalSpacing(0),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                child: TableCalendar(
                  availableGestures: AvailableGestures.horizontalSwipe,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2040),
                  focusedDay: _focusedDay,
                  eventLoader: (val) => [], //_getEventsForDay,
                  selectedDayPredicate: (day) {
                    // return _selectedDays.contains(day);
                    // return mySelectedDates.contains(day);
                    final wwx = ref
                        .read(selectedDateTimeAndDurationProvider.notifier)
                        .containsDateTime(day);
                    return wwx;
                  },
                  onDaySelected: (date, fdate) {
                    // priceType == ServicePeriod.service
                    // ? _singleDateSelection(date, fdate)
                    // : _onDaySelected(date, fdate);
                    setState(() {});
                    ref.read(selectedDateTimeAndDurationProvider.notifier).add(
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
                              // color: Theme.of(context)
                            ),
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
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                        // color: VmodelColors.primaryColor,
                        // color: Theme.of(context).colorScheme.primary,
                        color: UIConstants.switchActiveColor(context),
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
                          "Selected Dates",
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
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //Date Formats
                  children: List.generate(mySelectedDates.length, (index) {
                    final selectedDate = mySelectedDates[index].date;

                    final date = DateFormat("MMMM dd, y")
                        .format(mySelectedDates[index].date);
                    final weekDay =
                        DateFormat("EEEE").format(mySelectedDates[index].date);

                    return VWidgetsSelectedDateWidget(
                        selectedDate: date,
                        selectedDateDay: weekDay,
                        onTapCancel: () {
                          ref
                              .read(
                                  selectedDateTimeAndDurationProvider.notifier)
                              .removeDateEntry(selectedDate);
                        });
                  }),
                  // },
                ),
              ),
              addVerticalSpacing(16),
              const Divider(thickness: 1),
              addVerticalSpacing(16),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(mySelectedDates.length, (index) {
                      final selectedDate = mySelectedDates[index];
                      final date = DateFormat("MMMM dd, y")
                          .format(mySelectedDates[index].date);
                      final weekDay = DateFormat("EEEE")
                          .format(mySelectedDates[index].date);

                      return VWidgetsSelectedDateTimeDurationWidget(
                        key: ValueKey(selectedDate.date.millisecondsSinceEpoch),
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
                          // color: VmodelColors.white,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.2),
                          border: Border.all(
                              width: 2, color: Theme.of(context).primaryColor),
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
                                      if (index == mySelectedDates.length - 1) {
                                        return TextSpan(
                                            text: '$dateDuration '
                                                '${getHoursPluralize(mySelectedDates[index].dateDuration)}');
                                      }
                                      return TextSpan(
                                          //   text: "$dateDuration hrs + ",
                                          // );
                                          text: '$dateDuration '
                                              '${getHoursPluralize(mySelectedDates[index].dateDuration)} + ');
                                    }),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor),
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
                            // 'HRS',
                            getHoursPluralize(calculatedDuration).toUpperCase(),
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
                    addVerticalSpacing(24),
                    const Divider(thickness: 1),
                  ],
                ),
              addVerticalSpacing(25),
              VWidgetsDescriptionTextFieldWithTitle(
                controller: _shortDescriptionController,
                label: "Add description",
                hintText: "Write a short overview of who you’re looking for...",
                minLines: 4,
                validator: VValidatorsMixin.isNotEmpty,
                onChanged: (p0) {
                  final temp =
                      ref.read(jobDataProvider.notifier).state?.copyWith(
                            shortDescription: p0,
                          );
                  ref.read(jobDataProvider.notifier).state = temp;
                },
                //onSaved: (){},
              ),
              addVerticalSpacing(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "I have a creative brief",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        // color: VmodelColors.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: VWidgetsSwitch(
                      swicthValue: creativeBriefSwitchValue,
                      onChanged: (p0) {
                        setState(() {
                          creativeBriefSwitchValue = !creativeBriefSwitchValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              addVerticalSpacing(15),
              if (creativeBriefSwitchValue)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VWidgetsDescriptionTextFieldWithTitle(
                      controller: _briefTextController,
                      label: "Create your brief (Optional)",
                      hintText: "Write in detail what work needs to be done",
                      minLines: 4,
                      onChanged: (p0) {
                        final temp =
                            ref.read(jobDataProvider.notifier).state?.copyWith(
                                  brief: p0,
                                );
                      },
                    ),
                    addVerticalSpacing(25),
                    Text(
                      "Attach brief (optional)",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                              // color: VmodelColors.primaryColor,
                              fontWeight: FontWeight.w600),
                    ),
                    addVerticalSpacing(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: VWidgetsPrimaryButton(
                            onPressed: () {},
                            buttonTitle: "Upload",
                            enableButton: true,
                          ),
                        ),
                        addHorizontalSpacing(10),
                        Flexible(
                            child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text("",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ],
                            ),
                          ),
                        )),
                        addHorizontalSpacing(10),
                        GestureDetector(
                          onTap: () {},
                          child: const RenderSvg(svgPath: VIcons.remove),
                        )
                      ],
                    ),
                    addVerticalSpacing(25),
                    VWidgetsPrimaryTextFieldWithTitle(
                      label: "Link to brief (Optional)",
                      hintText: "https://vmodel.app/brief-document.html",
                      controller: _briefLinkController,
                      //validator: ValidationsMixin.isNotEmpty(value),
                      //keyboardType: TextInputType.emailAddress,
                      //onSaved: (){},
                      onChanged: (p0) {
                        ref.read(jobDataProvider.notifier).state?.copyWith(
                              briefLink: _briefLinkController.text,
                            );
                      },
                    ),
                  ],
                ),
              addVerticalSpacing(40),
              VWidgetsPrimaryButton(
                enableButton: true,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  if (!_formKey.currentState!.validate()) {
                    VWidgetShowResponse.showToast(ResponseEnum.warning,
                        message: 'Please fill required fields');
                    return;
                  } else if (mySelectedDates.isEmpty) {
                    VWidgetShowResponse.showToast(ResponseEnum.warning,
                        message: 'Please select a booking date');
                    return;
                  }
                  final temp = ref
                      .read(jobDataProvider.notifier)
                      .state!
                      .copyWith(
                        jobTitle: _titleController.text.trim(),
                        jobType: jobType,
                        preferredGender: preferredGender.apiValue,
                        priceOption: priceType.simpleName,
                        priceValue: double.parse(_priceController.text.trim()),
                        talents: [talentType],
                        shortDescription: _shortDescriptionController.text,
                        acceptMultiple: _isMultipleApplicants,
                        brief: _briefTextController.text,
                        briefLink: _briefLinkController.text,
                        category: categoryType == null ? null : [categoryType!],
                      );
                  print(temp);
                  ref.read(jobDataProvider.notifier).state = temp;
                  navigateToRoute(
                      context,
                      CreateJobSecondPage(
                        isEdit: widget.isEdit,
                        jobType: jobType!,
                        job: widget.job,
                      ));
                },
                buttonTitle: "Continue",
              ),
              addVerticalSpacing(50)
            ],
          ),
        ),
      ),
    );
  }

  String getHoursPluralize(Duration duration) {
    if (duration.inMinutes == 60) {
      return 'hr';
    }
    return 'hrs';
  }

  double getTotalPrice(Duration duration) {
    final price = double.tryParse(_priceController.text) ?? 0;
    return (duration.inMinutes / 60) * price;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  jobDialog(BuildContext context) {
    _isPopupClosed = false;
    Future.delayed(const Duration(seconds: 3), () {
      if (!_isPopupClosed) goBack(context);
    });

    return showDialog(
      context: context,
      builder: (context) => VWidgetsPopUpWithoutSaveButton(
        // popupTitle: const Text(''),
        popupTitle: Text('Only ID Verified members can book on site jobs',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // fontWeight: FontWeight.w600,
                // color: Theme.of(context).primaryColor,
                )),
      ),
    ).then((value) => _isPopupClosed = true);
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
    if (mySelectedDates.contains(JobDeliveryDate.fromMap({
      "date": selectedDay.toIso8601String().split("T")[0],
      "startTime": selectedDay.toIso8601String().split("T")[1]
    }))) {
      print("object");
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
}
