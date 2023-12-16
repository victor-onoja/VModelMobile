import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../res/icons.dart';
import '../../../../../shared/rend_paint/render_svg.dart';
import '../controller/business_edit_extras_controller.dart';
import '../controller/business_open_times_controller.dart';
import '../models/simple_open_time.dart';
import '../widgets/opening_times_selector.dart';
import '../widgets/business_info_tags_field.dart';

class OpeningTimesHomepage extends ConsumerStatefulWidget {
  const OpeningTimesHomepage({super.key});

  @override
  ConsumerState<OpeningTimesHomepage> createState() =>
      _OpeningTimesHomepageState();
}

class _OpeningTimesHomepageState extends ConsumerState<OpeningTimesHomepage> {
  final daysOfWeek = [
    'Sundays',
    'Mondays',
    'Tuesdays',
    'Wednesdays',
    'Thursdays',
    'Fridays',
    'Saturdays',
  ];

  List<SimpleOpenTime> selectedWorkingDaysAndHours = [];
  final showButtonLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    // final openTimes = ref.watch(localOpenTimesNotifier);
    final openTimes = ref.watch(businessOpenTimesProvider(null));
    // final initialExtras = ref.watch(initailExtrasProvider);
    // final initialSafetyRules = ref.watch(initailSafetyRulesProvider);
    final initialExtras = ref.watch(businessInfoTag(VMString.businessExtraKey));
    final initialSafetyRules =
        ref.watch(businessInfoTag(VMString.businessSafetyRulesKey));
    print('[iEx] ${initialExtras}');
    print('[iSf] ${initialSafetyRules}');
    print('[iki] ${openTimes.valueOrNull}');
    print('[iki8] ${selectedWorkingDaysAndHours}');

    return Scaffold(
        appBar: const VWidgetsAppBar(
          appbarTitle: "Opening times",
          leadingIcon: VWidgetsBackButton(),
        ),
        body: openTimes.maybeWhen(loading: () {
          return Center(child: CircularProgressIndicator.adaptive());
        }, orElse: () {
          selectedWorkingDaysAndHours =
              openTimes.valueOrNull?.openingTimes ?? [];
          print('[bhsh] $selectedWorkingDaysAndHours');

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 25, 18, 0),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedWorkingDaysAndHours.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tap on day to specify working hours',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 10,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.5)),
                    ),
                  ),
                Container(
                  height: 60,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(daysOfWeek.length, (index) {
                            // return null;
                            return _circledDayOfWeek(
                                context,
                                index,
                                daysOfWeek[index][0],
                                containsDay(daysOfWeek[index]));
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
                addVerticalSpacing(24),
                ...List.generate(selectedWorkingDaysAndHours.length, (index) {
                  final item = selectedWorkingDaysAndHours[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OpeningTimesSelectorWidget(
                      key: ValueKey(item.toString()),
                      dayOfWeek: item.day,
                      openTime: item,
                      onChanged: (val) {
                        // print('[ojdk] $valusinessWorkingInfoTag(id: 13, title: Live Band)');
                        updateSelectedWorkingDayAndHours(index, val);
                      },
                    ),
                  );
                }).toList(),
                addVerticalSpacing(16),
                BusinessOtherInfoSection(
                  data: openTimes.valueOrNull?.extrasInfo ?? [],
                  sectionTitle: 'Extras',
                  onAddTag: (tag) {
                    ref
                        .read(businessOpenTimesProvider(null).notifier)
                        .addBusinessExtras(tag);
                  },
                  onRemoveTag: (tagId) {
                    ref
                        .read(businessOpenTimesProvider(null).notifier)
                        .removeExtraInfo(tagId);
                  },
                  icon: RenderSvg(
                    svgPath: VIcons.businessExtras,
                    svgHeight: 10,
                    svgWidth: 10,
                  ),
                ),
                addVerticalSpacing(24),
                BusinessOtherInfoSection(
                  isSafety: true,
                  onAddTag: (tag) {
                    ref
                        .read(businessOpenTimesProvider(null).notifier)
                        .addBusinessSafetyRule(tag);
                  },
                  onRemoveTag: (tagId) {
                    ref
                        .read(
                            businessInfoTag(VMString.businessExtraKey).notifier)
                        .onSave(VMString.businessExtraKey);
                    // ref
                    //     .read(businessOpenTimesProvider(null).notifier)
                    //     .removeSafetyRule(tagId);
                  },
                  data: openTimes.valueOrNull?.safetyInfo ?? [],
                  sectionTitle: 'Health and safety rules',
                  icon: RenderSvgWithoutColor(
                    svgPath: VIcons.businessSafety,
                    svgHeight: 14,
                    svgWidth: 14,
                  ),
                ),
                addVerticalSpacing(48),
                ValueListenableBuilder(
                    valueListenable: showButtonLoading,
                    builder: (context, value, _) {
                      return VWidgetsPrimaryButton(
                        showLoadingIndicator: value,
                        buttonTitle: 'Save',
                        onPressed: () async {
                          final existingExtraData =
                              openTimes.valueOrNull?.extrasInfo ?? [];
                          final existingSafetyData =
                              openTimes.valueOrNull?.extrasInfo ?? [];
                          showButtonLoading.value = true;
                          await ref
                              .read(businessOpenTimesProvider(null).notifier)
                              .updateWorkingTimes(selectedWorkingDaysAndHours);
                          // if (existingExtraData.isEmpty) {
                          // await ref
                          //     .read(
                          //         businessOpenTimesProvider(null).notifier)
                          //     .addBusinessExtras(initialExtras
                          //         .map((e) => e.title)
                          //         .toList());

                          await ref
                              .read(businessInfoTag(VMString.businessExtraKey)
                                  .notifier)
                              .onSave(VMString.businessExtraKey);
                          // }
                          // if (existingSafetyData.isEmpty) {
                          await ref
                              .read(businessInfoTag(
                                      VMString.businessSafetyRulesKey)
                                  .notifier)
                              .onSave(VMString.businessSafetyRulesKey);
                          // await ref
                          //     .read(
                          //         businessOpenTimesProvider(null).notifier)
                          //     .addBusinessSafetyRule(initialSafetyRules
                          //         .map((e) => e.title)
                          //         .toList());
                          // }
                          print('[iki99] ${selectedWorkingDaysAndHours}');
                          showButtonLoading.value = false;
                        },
                      );
                    }),
                addVerticalSpacing(24),
              ],
            ),
          );
        }));
  }

  void addOrRemoveSelectedDayIndex(String day) {
    if (containsDay(day)) {
      selectedWorkingDaysAndHours.removeWhere((element) => element.day == day);
    } else {
      selectedWorkingDaysAndHours.add(SimpleOpenTime.defaultFromDay(day));
    }
    print('[iki990] ${selectedWorkingDaysAndHours}');
    // selectedDaysIndex.sort();
    setState(() {});
  }

  void updateSelectedWorkingDayAndHours(
      int index, SimpleOpenTime workingHours) {
    print('[iki88] ${daysOfWeek[index]} $workingHours');

    // if (containsDay(daysOfWeek[index])) {
    selectedWorkingDaysAndHours.removeAt(index);
    selectedWorkingDaysAndHours.insert(index, workingHours);
    print('[iki999] ${selectedWorkingDaysAndHours}');
    // }
    // selectedDaysIndex.sort();
    setState(() {});
  }

  bool containsDay(String day) {
    return selectedWorkingDaysAndHours
        .any((element) => element.day.toLowerCase() == day.toLowerCase());
  }

  Widget _circledDayOfWeek(
      BuildContext context, int index, String day, bool isSeleceted) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        height: 36,
        width: 36,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: () {
            addOrRemoveSelectedDayIndex(daysOfWeek[index]);
          },
          style: OutlinedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            side: BorderSide(color: Colors.white),
            backgroundColor: isSeleceted ? Colors.white : null,
          ),
          child: Text(
            day,
            style: TextStyle(
              color: isSeleceted
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
