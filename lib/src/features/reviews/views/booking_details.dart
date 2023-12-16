import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class BookingDetailsView extends StatefulWidget {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView> {
  final List imageList = [
    VmodelAssets2.bookingBgImage,
    VmodelAssets2.bookingBgImage,
    VmodelAssets2.bookingBgImage,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),
        
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appbarTitle: "Booking details",
        trailingIcon: [
           IconButton(
              onPressed: () {},
              icon: const RenderSvg(
                svgPath: VIcons.shareMessages,
                svgHeight: 24,
                svgWidth: 24,
              ),
            ),
          
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      items: List.generate(
                        imageList.length,
                        (index) => Image.asset(
                          imageList[index],
                          width: double.infinity,
                          height: double.infinity,
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
                        height: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            child: Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 2.525),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: VmodelColors.white.withOpacity(
                                    currentIndex == entry.key ? 1 : 0.6),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                addVerticalSpacing(25),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Text(
                    "Christopher M. Davies",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: VmodelColors.primaryColor),
                  ),
                ),
                addVerticalSpacing(25),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mon, 12 Oct, 2023\n13:00",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: VmodelColors.primaryColor),
                      ),
                      Container(
                        width: 1,
                        height: 45,
                        color: VmodelColors.borderColor,
                      ),
                      Text(
                        "Mon, 12 Oct, 2023 \n13:00",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: VmodelColors.primaryColor),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Divider(
                    height: 50,
                    color: VmodelColors.borderColor,
                    thickness: 1,
                  ),
                ),
                const RowText(
                  title: "Location",
                  subTitle: "Yonkers, New York, USA",
                ),
                const RowText(
                  title: "Gender",
                  subTitle: "Male",
                ),
                const RowText(
                  title: "Duration",
                  subTitle: "3:30hr",
                ),
                const RowText(
                  title: "Budget",
                  subTitle: "£450",
                ),
                addVerticalSpacing(40),
                const RowItemWithIcons(
                  title: "View booking description",
                  svgPath: VIcons.eyeIcon,
                ),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Divider(
                    height: 15,
                    color: VmodelColors.borderColor,
                    thickness: 1,
                  ),
                ),
                const RowItemWithIcons(
                  title: "Send message",
                  svgPath: VIcons.sendWitoutNot,
                ),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Divider(
                    height: 15,
                    color: VmodelColors.borderColor,
                    thickness: 1,
                  ),
                ),
                const RowItemWithIcons(
                  title: "See route",
                  svgPath: VIcons.routingIcon,
                ),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Divider(
                    height: 15,
                    color: VmodelColors.borderColor,
                    thickness: 1,
                  ),
                ),
                const RowItemWithIcons(
                  title: "Change Bookings",
                  svgPath: VIcons.pen,
                ),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Divider(
                    height: 15,
                    color: VmodelColors.borderColor,
                    thickness: 1,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) => VWidgetsConfirmationPopUp(
                              popupTitle: "Cancel Booking?",
                              popupDescription:
                                  "Are you sure you want to cancel this booking?",
                              onPressedYes: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              onPressedNo: () {
                                Navigator.pop(context);
                              },
                            )));
                  },
                  child: const RowItemWithIcons(
                    title: "Cancel Bookings",
                    svgPath: VIcons.closeIcon,
                  ),
                ),
                addVerticalSpacing(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: VmodelColors.text3),
          ),
          addHorizontalSpacing(15),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: VmodelColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

class RowItemWithIcons extends StatelessWidget {
  const RowItemWithIcons({Key? key, required this.title, required this.svgPath})
      : super(key: key);

  final String title;
  final String svgPath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              RenderSvg(
                svgPath: svgPath,
                svgWidth: 22,
                svgHeight: 22,
              ),
              addHorizontalSpacing(15),
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: VmodelColors.primaryColor),
              ),
            ],
          ),
          const Icon(
            CupertinoIcons.forward,
            color: VmodelColors.primaryColor,
          )
        ],
      ),
    );
  }
}
