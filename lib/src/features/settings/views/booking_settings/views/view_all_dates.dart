import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/core/utils/extensions/theme_extension.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/models/unavailable_days_model.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/widgets/unavailable_dates.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';

import '../../../../../shared/shimmer/shimmerItem.dart';
import '../controllers/availability_provider.dart';
import '../controllers/unavailable_days_controller.dart';

class AllDates extends ConsumerStatefulWidget {
  const AllDates({Key? key, required this.selectedDays}) : super(key: key);

  final Set<DateTime> selectedDays;
  @override
  ConsumerState<AllDates> createState() => _AllDatesState();
}

class _AllDatesState extends ConsumerState<AllDates> {
  Set selectedDays = {};
  Set<int> _selectedYears = {};
  List<Widget> _listItems = [];
  Map<int, List<DateTime>> mMap = {};
  final _dateFormatter = DateFormat("MMMM dd, yyy");
  final _dayFormatter = DateFormat("EEEE");
  final _monthFormatter = DateFormat("MMMM");

  @override
  void initState() {
    setState(() {
      selectedDays = widget.selectedDays;
    });
    var sorted = selectedDays.toList() as List<DateTime>;
    sorted.sort();
    selectedDays = sorted.toSet();

    _selectedYears = sorted.map((e) => e.year).toSet();

    if (_selectedYears.isNotEmpty) {
      filterDateByYearIntoMap(_selectedYears.first);
    }

    super.initState();
  }

  void filterDateByYearIntoMap(int filterYear) {
    mMap.clear();
    for (var i in selectedDays) {
      var date = i as DateTime;
      if (date.year != filterYear) continue;
      if (mMap.keys.contains(date.month)) {
        (mMap[date.month] as List<DateTime>).add(date);
        continue;
      } else {
        mMap[date.month] = [date];
      }
    }
    buildListFromMap();
  }

  void buildListFromMap() {
    _listItems.clear();
    if (mMap.isEmpty) return;
    List<Widget> items = [];
    for (var element in mMap.keys) {
      // final date = DateFormat("MMMM dd, yyy").format(element);
      var elementValues = mMap[element];
      items.add(_headerItem(
          _monthFormatter.format(elementValues!.first), elementValues.length));
      items.addAll(
        List<Widget>.generate(
          elementValues.length,
          (index) => UnavailableDates(
            date: _dateFormatter.format(elementValues[index]),
            day: _dayFormatter.format(elementValues[index]),
            removeFunc: () {},
          ),
        ),
      );
    }
    _listItems = items;
  }

  @override
  Widget build(BuildContext context) {
    final selectedYear = ref.watch(selectedYearProvider);
    ref.listen(selectedYearProvider, (previous, current) {
      filterDateByYearIntoMap(_selectedYears.elementAt(current));
    });
    final unavailableDays = ref.watch(unavailableDaysProvider(null));

    return Scaffold(
        appBar: VWidgetsAppBar(
          appbarTitle: "Dates Unavailable",
          appBarHeight: 50,
          leadingIcon: const VWidgetsBackButton(),
          trailingIcon: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Save",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor.withOpacity(0.2)),
              ),
            ),
          ],
        ),
        body: unAvailableWidget(unavailableDays).when(data: (data) {
          // data.sort((a, b) => a.date!.compareTo(b.date!));
          print(data.length);
          groupJobApplications(data);
          Map<int, Map<int, List<UnavailableDaysModel>>>
              groupItemsByYearAndMonth() {
            Map<int, Map<int, List<UnavailableDaysModel>>> groupedItems = {};

            for (var item in data) {
              int year = item.date!.year;
              int month = item.date!.month;

              if (!groupedItems.containsKey(year)) {
                groupedItems[year] = {};
              }

              if (!groupedItems[year]!.containsKey(month)) {
                groupedItems[year]![month] = [];
              }

              groupedItems[year]![month]!.add(item);
            }
            print("dataaaa ${groupedItems.length}");
            return groupedItems;
          }

          Map<int, Map<int, List<UnavailableDaysModel>>> groupedItems =
              groupItemsByYearAndMonth();

          return RefreshIndicator.adaptive(
            onRefresh: () async {
              HapticFeedback.lightImpact();
              ref.refresh(unavailableDaysProvider(null).future);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                  itemCount: groupedItems.length,
                  itemBuilder: (context, yearIndex) {
                    final year = groupedItems.keys.elementAt(yearIndex);
                    final yearMonths = groupedItems[year]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${year}',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        for (int month in yearMonths.keys)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _headerItem(
                                DateFormat('MMMM')
                                    .format(DateTime(year, month, 1)),
                                yearMonths[month]!.length,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       DateFormat('MMMM')
                              //           .format(DateTime(year, month, 1)),
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .displayMedium
                              //           ?.copyWith(
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 14,
                              //             color: Theme.of(context).primaryColor,
                              //           ),
                              //     ),
                              //     Text(
                              //       yearMonths.keys.length.toString(),
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .displayMedium
                              //           ?.copyWith(
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 14,
                              //             color: Theme.of(context).primaryColor,
                              //           ),
                              //     ),
                              //   ],
                              // ),
                              // Divider(),
                              for (var index = 0;
                                  index < yearMonths[month]!.length;
                                  index++) ...[
                                UnavailableDates(
                                    date:
                                        "${_dateFormatter.format(yearMonths[month]![index].date!)}",
                                    day:
                                        "${_dayFormatter.format(yearMonths[month]![index].date!)}",
                                    removeFunc: () async {
                                      if (yearMonths[month]![index].id ==
                                          null) {
                                        context
                                            .showSnackbar('An errror occurred');
                                        return;
                                      }
                                      VLoader.changeLoadingState(true);
                                      final success = await ref
                                          .read(unavailableDaysProvider(null)
                                              .notifier)
                                          .deleteUnavailableDay(
                                              id: yearMonths[month]![index]
                                                  .id!);
                                      VLoader.changeLoadingState(false);
                                      if (context.mounted && success) {
                                        context.showSnackbar(
                                            'Successfully deleted day');
                                      }
                                    })
                              ],
                            ],
                            // },
                          ),
                      ],
                    );
                    // const Divider(),
                  }),
            ),
          );
        }, error: (error, stackTrace) {
          return Scaffold(body: Center(child: Text("Error: $error")));
        }, loading: () {
          return shimmerItem(context: context, numOfItem: 5);
        }));
  }

  AsyncValue<List<UnavailableDaysModel>> unAvailableWidget(
          AsyncValue<List<UnavailableDaysModel>> unavailableDays) =>
      unavailableDays;

  Column _headerItem(String month, int number) {
    return Column(
      // key: ValueKey(index),
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(month),
            const Spacer(),
            Text(
                '$number day${number == 1 ? '' : 's'}'), //Todo use localisation to handle plurals
          ],
        ),
        const Divider(thickness: 0.5),
        const SizedBox(height: 8),
      ],
    );
  }

// Padding(
//         padding: const VWidgetsPagePadding.horizontalSymmetric(20),
//         child: Column(
//           children: [
//             addVerticalSpacing(20),
//             SizedBox(
//               height: 38,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _selectedYears.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             ref.read(selectedYearProvider.notifier).state =
//                                 index;
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Text(
//                               _selectedYears.elementAt(index).toString(),
//                               style: index == selectedYear
//                                   ? Theme.of(context)
//                                       .textTheme
//                                       .displayMedium
//                                       ?.copyWith(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                         color: Theme.of(context).primaryColor,
//                                       )
//                                   : Theme.of(context)
//                                       .textTheme
//                                       .displayMedium
//                                       ?.copyWith(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14,
//                                         color: Theme.of(context)
//                                             .primaryColor
//                                             .withOpacity(0.2),
//                                       ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const Divider(),
//                 ],
//               ),
//             ),
//             addVerticalSpacing(20),
  // Text(
  //   "Dates unavailable",
  //   textAlign: TextAlign.center,
  //   style: Theme.of(context).textTheme.displayMedium?.copyWith(
  //       fontWeight: FontWeight.w500,
  //       fontSize: 14,
  //       color: VmodelColors.primaryColor),
  // ),
  // addVerticalSpacing(30),
  //           Expanded(
  //             child: ListView.builder(
  //                 // physics: const NeverScrollableScrollPhysics(),
  //                 shrinkWrap: true,
  //                 itemCount: _listItems.length,
  //                 itemBuilder: (context, index) {
  //                   // int dateMonth = (_filtedDays[index] as DateTime).month;
  //                   // bool isHeader =
  //                   //     previousMonth > 0 && previousMonth != dateMonth;
  //                   // previousMonth = dateMonth;
  //                   return _listItems[index];
  //                 }),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Map<String, List<UnavailableDaysModel>> groupJobApplications(
      List<UnavailableDaysModel> unavailableDays) {
    final groupedUnavailableDays = <String, List<UnavailableDaysModel>>{};

    for (final days in unavailableDays) {
      final dateCreated = days.date;
      if (dateCreated != null) {
        _addToGroup(groupedUnavailableDays, dateCreated.year.toString(), days);
      }
    }

    return groupedUnavailableDays;
  }

  void _addToGroup(
      Map<String, List<UnavailableDaysModel>> groupedUnavailableDays,
      String groupName,
      UnavailableDaysModel unavailableDays) {
    if (!groupedUnavailableDays.containsKey(groupName)) {
      groupedUnavailableDays[groupName] = [];
    }
    groupedUnavailableDays[groupName]!.add(unavailableDays);
  }
}
