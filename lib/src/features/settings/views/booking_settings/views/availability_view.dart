import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/event_class.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/views/view_all_dates.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/widgets/unavailable_dates.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

import '../controllers/unavailable_days_controller.dart';

class AvailabilityView extends ConsumerStatefulWidget {
  const AvailabilityView({Key? key}) : super(key: key);

  @override
  _AvailabilityViewState createState() => _AvailabilityViewState();
}

class _AvailabilityViewState extends ConsumerState<AvailabilityView> {
  DateTime _focusedDay = DateTime.now();

  Set<DateTime>? _selectedDays;

  ValueNotifier<List<Event>>? _selectedEvents;
  bool _showFAB = true;
  bool _showLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
    _selectedDays = LinkedHashSet<DateTime>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
  }

  @override
  void dispose() {
    _selectedEvents!.dispose();
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays!.contains(selectedDay)) {
        _selectedDays!.remove(selectedDay);
      } else {
        _selectedDays!.add(selectedDay);
      }
    });
    _selectedEvents!.value = _getEventsForDays(_selectedDays!);
    _focusedDay = focusedDay;
  }

  Future<void> _saveDay() async {
    if (_selectedDays!.isNotEmpty) {
      var dayList = _selectedDays!.toList();
      List<Unavailable> unavailableList = dayList.map((dateTime) {
        return Unavailable(date: dateTime);
      }).toList();
      setState(() => _showLoading = true);
      await ref.read(unavailableDaysProvider(null).notifier).saveUnavailableDays(
            dates: unavailableList,
          );
      setState(() => _showLoading = false);
      goBack(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final unavailableDays = ref.watch(unavailableDaysProvider(null));
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Unavailable Days",
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),
        trailingIcon: [
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 0),
            child: SizedBox(
                // height: 30,
                width: 90,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await _saveDay();
                    },
                    child: _showLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          )
                        : Text(
                            "Save",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                          ),
                  ),
                )),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showFAB
          ? VWidgetsPrimaryButton(
              butttonWidth: 118,
              enableButton: true,
              buttonTitle: "View all dates",
              onPressed: () {
                navigateToRoute(
                    context,
                    AllDates(
                      selectedDays: _selectedDays!,
                    ));
              },
            )
          : null,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.horizontal) return true;
          _handleFABVisibility(notification);
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpacing(16),
              // Padding(
              //   padding: const VWidgetsPagePadding.horizontalSymmetric(20),
              //   child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Flexible(
              //           child: Text(
              //             "Pick your “unavailable” dates below. No one will be able to book you on an unavailable date.",
              //             textAlign: TextAlign.center,
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .displayMedium
              //                 ?.copyWith(
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 13,
              //                     color: VmodelColors.primaryColor),
              //           ),
              //         ),
              //         const Icon(
              //           Icons.close,
              //           color: VmodelColors.primaryColor,
              //         )
              //       ]),
              // ),
              // const Divider(
              //   height: 30,
              // ),
              unavailableDays.maybeWhen(data: (values) {
                return Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(20),
                  child: TableCalendar(
                    availableGestures: AvailableGestures.horizontalSwipe,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2040),
                    focusedDay: _focusedDay,
                    eventLoader: _getEventsForDay,
                    selectedDayPredicate: (day) {
                      final wwx = ref
                          .read(unavailableDaysProvider(null).notifier)
                          .containsDateTime(day);
                      return wwx || _selectedDays!.contains(day);
                    },
                    onDaySelected: _onDaySelected,
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    headerStyle: HeaderStyle(
                      titleTextStyle:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      formatButtonVisible: false,
                      titleCentered: true,
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
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
                );
              }, orElse: () {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }),
              const Divider(height: 40),
              if (_selectedDays!.isEmpty)
                Text(
                  "Dates unavailable",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                ),
              if (_selectedDays!.isEmpty) addVerticalSpacing(30),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(20),
                  child: Text(
                    _selectedDays!.isNotEmpty ? "This Month" : "",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(20),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _selectedDays!.length,
                    itemBuilder: (context, index) {
                      final date = DateFormat("MMMM dd, yyy")
                          .format(_selectedDays!.toList()[index]);
                      final day = DateFormat("EEEE")
                          .format(_selectedDays!.toList()[index]);

                      return UnavailableDates(
                        date: date,
                        day: day,
                        removeFunc: () {
                          setState(() {
                            _selectedDays!
                                .remove(_selectedDays!.toList()[index]);
                          });
                        },
                      );
                    }),
              ),
              // addVerticalSpacing(10),
              // AllDates(
              //   selectedDays: _selectedDays!,
              // ),
              addVerticalSpacing(45),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFABVisibility(UserScrollNotification notification) {
    final ScrollDirection direction = notification.direction;

    switch (direction) {
      case ScrollDirection.forward:
        _showFAB = true;
        break;
      case ScrollDirection.reverse:
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          _showFAB = true;
        } else {
          _showFAB = false;
        }
        break;
      case ScrollDirection.idle:
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          _showFAB = true;
        }
        break;
    }
    if (mounted) setState(() {});
  }
}
