import 'package:vmodel/src/features/reviews/views/reviews_view.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/costants.dart';
import '../../../shared/modal_pill_widget.dart';

class BookingsMenuView extends StatefulWidget {
  const BookingsMenuView({super.key});

  @override
  State<BookingsMenuView> createState() => _BookingsMenuViewState();
}

enum Fruit { apple, banana }

class _BookingsMenuViewState extends State<BookingsMenuView> {
  final Fruit _fruit = Fruit.apple;
  bool _isOrderDate = false;
  bool _isDeliveryDate = false;
  bool hasBookings = false;
  bool hasPastBookings = false;
  bool sortByRecent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appbarTitle: "My Bookings",
          trailingIcon: [
            IconButton(
              onPressed: () {
                navigateToRoute(context, const ReviewsUI());
                // navigateToRoute(context, const BookingsTabbedView());
              },
              icon: RenderSvg(
                svgPath: VIcons.bookingStar,
                svgWidth: 20,
                svgHeight: 20,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            hasBookings
                ? PopupMenuButton<int>(
                    tooltip: "Filter",
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    icon: const RenderSvg(
                      svgPath: VIcons.setting,
                      svgHeight: 24,
                      svgWidth: 24,
                    ),
                    itemBuilder: (context) => [
                      // PopupMenuItem 1
                      PopupMenuItem(
                        value: 1,
                        onTap: () {
                          setState(() {
                            _isOrderDate = !_isOrderDate;
                            _isDeliveryDate = false;
                          });
                        },
                        // row with 2 children
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Date",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _isOrderDate != false
                                ? Icon(
                                    Icons.radio_button_checked_rounded,
                                    color: Theme.of(context).iconTheme.color,
                                    // color: VmodelColors.primaryColor,
                                  )
                                : Icon(
                                    Icons.radio_button_off_rounded,
                                    color: Theme.of(context).iconTheme.color,
                                    // color: VmodelColors.primaryColor,
                                  ),
                          ],
                        ),
                      ),
                      // PopupMenuItem 2
                      PopupMenuItem(
                        value: 2,
                        onTap: () {
                          setState(() {
                            _isDeliveryDate = !_isDeliveryDate;
                            _isOrderDate = false;
                          });
                        },
                        // row with two children
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Date",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _isDeliveryDate != false
                                ? Icon(
                                    Icons.radio_button_checked_rounded,
                                    color: Theme.of(context).iconTheme.color,
                                  )
                                : Icon(
                                    Icons.radio_button_off_rounded,
                                    color: Theme.of(context).iconTheme.color,
                                    // color: VmodelColors.primaryColor,
                                  ),
                          ],
                        ),
                      ),
                    ],
                    offset: const Offset(0, 40),
                    elevation: 1,
                    // on selected we show the dialog box
                    onSelected: (value) {
                      // if value 1 show dialog
                      if (value == 1) {
                        // if value 2 show dialog
                      } else if (value == 2) {}
                    },
                  )
                : const SizedBox.shrink(),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: VConstants.bottomPaddingForBottomSheets,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                addVerticalSpacing(15),
                                const Align(
                                    alignment: Alignment.center,
                                    child: VWidgetsModalPill()),
                                addVerticalSpacing(25),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: GestureDetector(
                                    child: Text('Most Recent',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ),
                                ),
                                const Divider(thickness: 0.5),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: GestureDetector(
                                    child: Text('Earliest',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ),
                                ),
                                addVerticalSpacing(40),
                              ],
                            ));
                      });
                },
                icon: const RenderSvg(
                  svgPath: VIcons.sort,
                )),
          ],
        ),
        body: const NoUpcomingBookings()
        // : Container(
        //     padding: const EdgeInsets.all(15),
        //     child: CustomScrollView(
        //       slivers: [
        //         SliverList(
        //           delegate: SliverChildListDelegate(
        //             [
        //               hasBookings
        //                   ? Text(
        //                       "Upcoming bookings",
        //                       style: Theme.of(context)
        //                           .textTheme
        //                           .displayMedium!
        //                           .copyWith(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w700,
        //                               color: VmodelColors.primaryColor),
        //                     )
        //                   : SizedBox.shrink(),
        //               hasBookings
        //                   ? const NoUpcomingBookings()
        //                   : UpcomingBookingsInfo(),
        //               addVerticalSpacing(20),
        //               Padding(
        //                 padding:
        //                     const VWidgetsPagePadding.horizontalSymmetric(18),
        //                 child: Text(
        //                   hasPastBookings ? "6 Bookings" : "Past Bookings",
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .displayMedium!
        //                       .copyWith(
        //                           fontSize: 14,
        //                           fontWeight: FontWeight.w700,
        //                           color: VmodelColors.primaryColor),
        //                 ),
        //               ),
        //               addVerticalSpacing(15),
        //               !hasPastBookings
        //                   ? SizedBox()
        //                   : Row(
        //                       mainAxisAlignment:
        //                           MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         LabeledRadio(
        //                           label: 'All',
        //                           padding: const EdgeInsets.symmetric(
        //                               horizontal: 5.0),
        //                           value: true,
        //                           groupValue: _isAllRadioSelected,
        //                           onChanged: (bool newValue) {
        //                             setState(() {
        //                               _isAllRadioSelected = newValue;
        //                               _isCancelledRadioSelected = false;
        //                               _isCompletedRadioSelected = false;
        //                             });
        //                           },
        //                         ),
        //                         LabeledRadio(
        //                           label: 'Completed',
        //                           padding: const EdgeInsets.symmetric(
        //                               horizontal: 5.0),
        //                           value: true,
        //                           groupValue: _isCompletedRadioSelected,
        //                           onChanged: (bool newValue) {
        //                             setState(() {
        //                               _isCompletedRadioSelected = newValue;
        //                               _isAllRadioSelected = false;
        //                               _isCancelledRadioSelected = false;
        //                             });
        //                           },
        //                         ),
        //                         LabeledRadio(
        //                           label: 'Cancelled',
        //                           padding: const EdgeInsets.symmetric(
        //                               horizontal: 5.0),
        //                           value: true,
        //                           groupValue: _isCancelledRadioSelected,
        //                           onChanged: (bool newValue) {
        //                             setState(() {
        //                               _isCancelledRadioSelected = newValue;
        //                               _isCompletedRadioSelected = false;
        //                               _isAllRadioSelected = false;
        //                             });
        //                           },
        //                         ),
        //                       ],
        //                     ),
        //               addVerticalSpacing(5),
        //               Padding(
        //                 padding:
        //                     const VWidgetsPagePadding.horizontalSymmetric(18),
        //                 child: ListView(
        //                   physics: const NeverScrollableScrollPhysics(),
        //                   shrinkWrap: true,
        //                   children: const [
        //                     BookingItems(
        //                       image: 'assets/images/profile-image.png',
        //                       title: 'Georgina Powell',
        //                       location: 'Yonkers, New York, USA',
        //                       dateRange: '12 Oct 2023 - 16 Oct 2023',
        //                       timeRemaining: 'In 5 weeks',
        //                     ),
        //                     //TODO (JEREMY): INTEGRATING BOOKING LIST TO BACKEND
        //                     //  ListView(
        //                     //    physics: const NeverScrollableScrollPhysics(),
        //                     //    shrinkWrap: true,
        //                     //    children: List.generate(
        //                     //      bookingData.length,
        //                     //          (index) => BookingItems(
        //                     //        image: bookingData[index]['image'],
        //                     //        title: bookingData[index]['title'],
        //                     //        location: bookingData[index]['location'],
        //                     //        dateRange: bookingData[index]['dateRange'],
        //                     //        timeRemaining: bookingData[index]['timeRemaining'],
        //                     //      ),
        //                     //    ),
        //                     //  )
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        );
  }
}

class UpcomingBookingsInfo extends StatelessWidget {
  const UpcomingBookingsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const VWidgetsPagePadding.horizontalSymmetric(18),
      child: Container(
          height: 264,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: VmodelColors.contractBackgroundColor,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 8,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(VmodelAssets2.bookingBgImage),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 26,
                            width: 83,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: VmodelColors.white),
                            child: Center(
                              child: Text(
                                "in 1 week",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: VmodelColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Christopher M. Davies",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: VmodelColors.white),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpacing(15),
                    Text(
                      "London, Uk",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor),
                    ),
                    addVerticalSpacing(6),
                    Text(
                      "12 Oct 2023 - 16 Oct 2023",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor),
                    ),
                    addVerticalSpacing(15),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            height: 37,
                            decoration: BoxDecoration(
                                color: VmodelColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: VmodelColors.mainColor)),
                            child: Center(
                              child: Text(
                                "Send message",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: VmodelColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                        addHorizontalSpacing(10),
                        Flexible(
                          child: Container(
                            height: 37,
                            decoration: BoxDecoration(
                                color: VmodelColors.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: VmodelColors.mainColor)),
                            child: Center(
                              child: Text(
                                "Route",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: VmodelColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    super.key,
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String? label;
  final EdgeInsets? padding;
  final bool? groupValue;
  final bool? value;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged!(value);
        }
      },
      child: Padding(
        padding: padding!,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value!,
              onChanged: (bool? newValue) {
                onChanged!(newValue);
              },
            ),
            Text(label!),
          ],
        ),
      ),
    );
  }
}

class NoUpcomingBookings extends StatelessWidget {
  const NoUpcomingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "You don't have any bookings",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w400, color: VmodelColors.greyColor),
            ),
          ),
          // addVerticalSpacing(20),
          // Image.asset(
          //   "assets/icons/no_bookings.png",
          // ),
          // addVerticalSpacing(20),
          // Text(
          //   "Time to start your new adventure!",
          //   style: Theme.of(context).textTheme.displayMedium!.copyWith(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w500,
          //       color: VmodelColors.primaryColor),
          // ),
          // addVerticalSpacing(20),
          // VWidgetsPrimaryButton(
          //     onPressed: () {},
          //     buttonTitle: 'Start exploring',
          //     enableButton: true,
          //     buttonColor: VmodelColors.primaryColor,
          //     buttonTitleTextStyle: const TextStyle(
          //         color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
