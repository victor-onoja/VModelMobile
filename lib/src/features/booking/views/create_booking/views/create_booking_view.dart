import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vmodel/src/features/booking/controller/calendar_event.dart';
import 'package:vmodel/src/features/booking/views/create_booking/views/booking_payment_view.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

import '../../../../../shared/text_fields/places_autocomplete_field.dart';
import '../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';

final dates = StateProvider.autoDispose<List>((ref) => []);

@Deprecated('Use newer BookingView instead')
class BookingViewOld extends ConsumerStatefulWidget {
  const BookingViewOld({Key? key}) : super(key: key);

  @override
  ConsumerState<BookingViewOld> createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingViewOld>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  List bookingImages = [
    'assets/images/create_booking_images/anna.png',
    'assets/images/create_booking_images/booking_polaroid2.png',
    'assets/images/create_booking_images/booking_polaroid1.png',
  ];

  @override
  bool get wantKeepAlive => true;

  DateTime _focusedDay = DateTime.now();

  Set<DateTime>? _selectedDays;

  ValueNotifier<List<Event>>? _selectedEvents;

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

  @override
  Widget build(BuildContext context) {
    final servicePackages = ref.watch(servicePackagesProvider(null));
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        appbarTitle: "Book Anna",
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        trailingIcon: [
          IconButton(
            onPressed: () {},
            icon: const RenderSvg(
              svgPath: VIcons.setting,
              svgHeight: 24,
              svgWidth: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 8),
            /* child: InkWell(
              onTap: (() {}),
              child: SvgPicture.asset(VIcons.sendWitoutNot),
            ), */
            child: GestureDetector(
              onTap: () {},
              child: const RenderSvg(
                svgPath: VIcons.sendWitoutNot,
                svgHeight: 24,
                svgWidth: 24,
              ),
            ),
          ),
        ],
      ),
      body: Portal(
        child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    /* Image.asset(
                        'assets/images/create_booking_images/anna.png',
                        width: SizeConfig.screenWidth,
                        // height: SizeConfig.screenWidth,
                      ), */

                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          items: List.generate(
                            3,
                            (index) => Image.asset(
                              bookingImages[index],
                              width: double.infinity,
                              height: SizeConfig.screenWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            aspectRatio: 0,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            onPageChanged: (value, reason) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            height: screenSize.height * 0.45,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: bookingImages
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 3.0, horizontal: 4.5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .withOpacity(
                                                  currentIndex == entry.key
                                                      ? 1
                                                      : 0.2),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                      child: Row(
                        children: [
                          Text(
                            'Sarah Tierney',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: const Color(0xff503C3B)),
                          ),
                          addHorizontalSpacing(10),
                          Image.asset(
                            'assets/images/create_booking_images/flag.png',
                            width: 20,
                            height: 14,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21.0, top: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              //locationIcon,
                              const RenderSvg(
                                svgPath: VIcons.locationIcon,
                                svgHeight: 17.0,
                                svgWidth: 12.0,
                              ),
                              addHorizontalSpacing(8),
                              Expanded(
                                child: Text(
                                  "Los Angeles",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: VmodelColors.primaryColor,
                                        // color: Color(0xff5B5B5B),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpacing(4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              shotIcon,
                              addHorizontalSpacing(7),
                              Expanded(
                                child: Text(
                                  "Commercial, Glamour, Runway",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: VmodelColors.primaryColor,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpacing(10),
                    Divider(
                      indent: 18,
                      endIndent: 18,
                      color: VmodelColors.borderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 18),
                          children: [
                            Column(
                              children: [
                                Text(
                                  '22',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                                addVerticalSpacing(8),
                                Text(
                                  'Age',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            addHorizontalSpacing(20),
                            Column(
                              children: [
                                Text(
                                  "5'10",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                                addVerticalSpacing(8),
                                Text(
                                  'Height',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            addHorizontalSpacing(20),
                            Column(
                              children: [
                                Text(
                                  'Female',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                                addVerticalSpacing(8),
                                Text(
                                  'Birth Gender',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            addHorizontalSpacing(20),
                            Column(
                              children: [
                                Text(
                                  'Caucasian',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                                addVerticalSpacing(8),
                                Text(
                                  'Ethnicity',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            addHorizontalSpacing(20),
                            Column(
                              children: [
                                Text(
                                  'Brown',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                                addVerticalSpacing(8),
                                Text(
                                  'Hair',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            addHorizontalSpacing(20),
                            Column(
                              children: [
                                Text(
                                  'Brown',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w700),
                                ),
                                addVerticalSpacing(8),
                                Text(
                                  'Eyes',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      indent: 18,
                      endIndent: 18,
                      height: 10,
                      color: VmodelColors.borderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 16.0),
                      child: Text(
                        'Polaroid',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: const Color(0xff503C3B)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 15.0),
                      child: SizedBox(
                        height: 205,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              height: 200,
                              width: 160,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/create_booking_images/booking_polaroid1.png'),
                                ),
                              ),
                            ),
                            addHorizontalSpacing(10),
                            Container(
                              height: 200,
                              width: 160,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/create_booking_images/booking_polaroid2.png'),
                                ),
                              ),
                            ),
                            addHorizontalSpacing(10),
                            Container(
                              height: 200,
                              width: 160,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/create_booking_images/booking_polaroid1.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: VWidgetsPrimaryButton(
                        onPressed: () {
                          // navigateToRoute(
                          //     context,
                          //     const ProfileMainView(
                          //       profileTypeEnumConstructor:
                          //           ProfileTypeEnum.personal,
                          //     ));
                        },
                        buttonColor: VmodelColors.contractBackgroundColor,
                        enableButton: true,
                        //butttonWidth: SizeConfig.screenWidth * 0.91,
                        buttonTitle: 'More photos',
                        buttonTitleTextStyle: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    addVerticalSpacing(5),
                    if (servicePackages.value != null)
                      Padding(
                        padding:
                            const VWidgetsPagePadding.horizontalSymmetric(18),
                        //Todo fix overflow issue when title is very lengthy
                        child: VWidgetsDropDownTextField(
                          maxLength: 10,
                          fieldLabel: "Select Gig or Service",
                          hintText: servicePackages.value!.isNotEmpty
                              ? servicePackages.value![0].title
                              : "Commercial From £250",
                          options: servicePackages.value!
                              .map((package) => package.title)
                              .toList(),
                          getLabel: (String value) => value,
                        ),
                      ),
                    addVerticalSpacing(20),
                    Padding(
                      padding:
                          const VWidgetsPagePadding.horizontalSymmetric(18),
                      child: TableCalendar(
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        firstDay: DateTime(1990),
                        lastDay: DateTime(2040),
                        focusedDay: _focusedDay,
                        eventLoader: _getEventsForDay,
                        selectedDayPredicate: (day) {
                          return _selectedDays!.contains(day);
                        },
                        onDaySelected: _onDaySelected,
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        headerStyle: const HeaderStyle(
                          titleTextStyle: TextStyle(
                              color: VmodelColors.primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios,
                            color: VmodelColors.primaryColor,
                            size: 25,
                          ),
                          formatButtonVisible: false,
                          titleCentered: true,
                          rightChevronIcon: Icon(
                            Icons.arrow_forward_ios,
                            color: VmodelColors.primaryColor,
                            size: 25,
                          ),
                        ),
                        calendarStyle: const CalendarStyle(
                            isTodayHighlighted: false,
                            selectedDecoration: BoxDecoration(
                                color: VmodelColors.primaryColor,
                                shape: BoxShape.circle)),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: VmodelColors.black),
                          weekendStyle: TextStyle(color: VmodelColors.black),
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            const VWidgetsPagePadding.horizontalSymmetric(18),
                        child: ListView.builder(
                          key: UniqueKey(),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          cacheExtent: 1000,
                          itemCount: _selectedDays!.length,
                          itemBuilder: (context, index) {
                            //
                            final date = DateFormat("EE dd, MMMM")
                                .format(_selectedDays!.toList()[index]);
                            return DaysOption(index: index + 1, date: date);
                          },
                        )),
                    addVerticalSpacing(20),
                    // Padding(
                    //   padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                    //   child: VWidgetsPrimaryTextFieldWithTitle(
                    //     label: "Location",
                    //     hintText: "Ex. 12 Mayfield Rd",
                    //     suffixIcon: IconButton(
                    //       onPressed: () {},
                    //       padding: const EdgeInsets.only(right: 0),
                    //       icon: const RenderSvgWithoutColor(
                    //         svgPath: VIcons.searchNormal,
                    //         svgHeight: 20,
                    //         svgWidth: 20,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    addVerticalSpacing(20),
                    // const Padding(
                    //   padding: VWidgetsPagePadding.horizontalSymmetric(18),
                    //   child: VWidgetsPrimaryTextFieldWithTitle(
                    //     label: "Additional Address Details",
                    //     hintText: "Optional",
                    //   ),
                    // ),
                    // addVerticalSpacing(15),
                    // Padding(
                    //   padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Flexible(
                    //         child: VWidgetsPrimaryTextFieldWithTitle(
                    //           label: "Postal Code",
                    //           hintText: "Ex. E13 8ES",
                    //         ),
                    //       ),
                    //       addHorizontalSpacing(10),
                    //       const Flexible(
                    //         child: VWidgetsPrimaryTextFieldWithTitle(
                    //           label: "City",
                    //           hintText: "Ex. London",
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: PlacesAutocompletionField(
                        // locController: locController,
                        // placePredictions: placePredictions,
                        label: "Additional Address Details",
                        onItemSelected: (value) {
                          if (!mounted) return;
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            // setState(() {
                            // _isShowAddressPredictions = false;
                            // });
                          });
                        },
                        postOnChanged: (String value) {
                          if (!mounted) return;
                          // if (value == null || value.isEmpty) {
                          //   setState(() {
                          //     _isShowAddressPredictions = false;
                          //   });
                          // } else {
                          //   setState(() {
                          //     _isShowAddressPredictions = true;
                          //   });
                          // }
                        },
                      ),
                    ),
                    // AnimatedContainer(
                    //   height: _isShowAddressPredictions ? 210 : 100,
                    //   // color: Colors.red[100],
                    //   padding: VWidgetsPagePadding.horizontalSymmetric(18),
                    //   duration: Duration(milliseconds: 500),
                    //   curve: Curves.fastLinearToSlowEaseIn,
                    //   child: AutoCompleteLocationField(
                    //     // locController: locController,
                    //     // placePredictions: placePredictions,
                    //     onItemSelected: () {
                    //       if (!mounted) return;
                    //       WidgetsBinding.instance
                    //           .addPostFrameCallback((timeStamp) {
                    //         setState(() {
                    //           _isShowAddressPredictions = false;
                    //         });
                    //       });
                    //     },
                    //     postOnChanged: (String value) {
                    //       if (!mounted) return;
                    //       if (value == null || value.isEmpty) {
                    //         setState(() {
                    //           _isShowAddressPredictions = false;
                    //         });
                    //       } else {
                    //         setState(() {
                    //           _isShowAddressPredictions = true;
                    //         });
                    //       }
                    //     },
                    //   ),
                    // ),
                    addVerticalSpacing(20),
                    Padding(
                      padding:
                          const VWidgetsPagePadding.horizontalSymmetric(18),
                      child: VWidgetsPrimaryButton(
                        onPressed: () {
                          navigateToRoute(
                              context, const BookingCheckoutPaymentView());
                        },
                        buttonTitle: 'Continue to payment',
                        enableButton: true,
                      ),
                    ),
                    addVerticalSpacing(20),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DaysOption extends StatefulWidget {
  const DaysOption({Key? key, required this.index, required this.date})
      : super(key: key);

  final int index;
  final String date;

  @override
  State<DaysOption> createState() => _DaysOptionState();
}

class _DaysOptionState extends State<DaysOption> {
  bool isFullDay = false;

  final List dayHours = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ];

  final List dayMinutes = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addVerticalSpacing(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Day 0${widget.index}",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: VmodelColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
            addHorizontalSpacing(8),
            Text(
              widget.date,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: VmodelColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
        addVerticalSpacing(10),
        isFullDay
            ? Container(
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: VmodelColors.dividerColor)),
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
                                  color: VmodelColors.unselectedText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                          ),
                          addHorizontalSpacing(8),
                          Text(
                            "8HRS",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: VmodelColors.boldGreyText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 4),
                        child: FlutterSwitch(
                          width: 65.0,
                          height: 35.0,
                          activeColor: VmodelColors.primaryColor,
                          inactiveColor: VmodelColors.switchOffColor,
                          toggleSize: 30.0,
                          value: isFullDay,
                          borderRadius: 80.0,
                          // padding: 8.0,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              isFullDay = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 145,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: VmodelColors.dividerColor)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
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
                                      color: VmodelColors.unselectedText,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                              ),
                              addHorizontalSpacing(8),
                              Text(
                                "8HRS",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      color: VmodelColors.boldGreyText,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            child: FlutterSwitch(
                              width: 65.0,
                              height: 35.0,
                              // valueFontSize: 25.0,
                              activeColor: VmodelColors.primaryColor,
                              inactiveColor: VmodelColors.switchOffColor,
                              toggleSize: 30.0,
                              value: isFullDay,
                              borderRadius: 80.0,
                              // padding: 8.0,
                              showOnOff: false,
                              onToggle: (val) {
                                setState(() {
                                  isFullDay = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Starts",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: VmodelColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(
                            height: 31,
                            width: 180,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(8),
                            //   color: VmodelColors.switchOffColor,
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoTheme(
                                  data: CupertinoThemeData(
                                    textTheme: CupertinoTextThemeData(
                                      pickerTextStyle: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color: VmodelColors.primaryColor,
                                          ),
                                    ),
                                  ),
                                  child: Flexible(
                                    child: CupertinoTimerPicker(
                                      mode: CupertinoTimerPickerMode.hm,
                                      onTimerDurationChanged: (data) {},
                                    ),
                                  ),
                                ),

                                // Flexible(
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //     itemCount: dayHours.length,
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: 10.0),
                                //         child: Center(
                                //           child: Text(
                                //             dayHours[index],
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .displayMedium
                                //                 ?.copyWith(
                                //                   color: VmodelColors
                                //                       .unselectedText,
                                //                   fontWeight: FontWeight.w500,
                                //                   fontSize: 14,
                                //                 ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),

                                // addHorizontalSpacing(4),
                                // Text(
                                //   ":",
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .displayMedium
                                //       ?.copyWith(
                                //         color: VmodelColors.unselectedText,
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 14,
                                //       ),
                                // ),

                                // Flexible(
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //     itemCount: dayMinutes.length,
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical: 10.0),
                                //         child: Center(
                                //           child: Text(
                                //             dayMinutes[index],
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .displayMedium
                                //                 ?.copyWith(
                                //                   color: VmodelColors
                                //                       .unselectedText,
                                //                   fontWeight: FontWeight.w500,
                                //                   fontSize: 14,
                                //                 ),
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ends",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: VmodelColors.unselectedText,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                          ),
                          Container(
                            height: 31,
                            width: 68,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: VmodelColors.switchOffColor,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dayHours.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Center(
                                            child: Text(
                                              dayHours[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                    color: VmodelColors
                                                        .unselectedText,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  // addHorizontalSpacing(4),
                                  Text(
                                    ":",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          color: VmodelColors.unselectedText,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                  ),

                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dayMinutes.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Center(
                                            child: Text(
                                              dayMinutes[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                    color: VmodelColors
                                                        .unselectedText,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
