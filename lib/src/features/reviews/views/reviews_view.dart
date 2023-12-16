import 'package:flutter/services.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/interest_dialog.dart';
import 'package:vmodel/src/features/faq_s/views/faqs_homepage.dart';
import 'package:vmodel/src/features/reviews/views/reviews_listview.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/network/urls.dart';
import '../../../core/utils/costants.dart';
import '../../../shared/modal_pill_widget.dart';
import '../../dashboard/profile/view/webview_page.dart';

class ReviewsUI extends StatefulWidget {
  const ReviewsUI({super.key});

  @override
  State<ReviewsUI> createState() => _ReviewsUIState();
}

enum Fruit { apple, banana }

class _ReviewsUIState extends State<ReviewsUI> {
  bool _isMostRecent = false;
  bool _isBestReview = false;
  bool _isHighestPaid = false;

  final List<Map<String, dynamic>> buttonList = [
    {"name": "All", "selected": true},
    {"name": "Seller reviews", "selected": false},
    {"name": "Buyer reviews", "selected": false},
    {"name": "Automatic reviews", "selected": false},
  ];

  Future<void> reloadData() async {}

  @override
  Widget build(BuildContext context) {
    int numOfReviews = 6;
    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appbarTitle: "My Reviews",
        // Text('My Reviews', style: VmodelTypography2.kTopTextStyle),
        trailingIcon: [
          PopupMenuButton<int>(
            tooltip: "Filter",
            color: Theme.of(context).scaffoldBackgroundColor,
            shadowColor: VmodelColors.greyColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            icon: RenderSvg(
              svgPath: VIcons.filterIcon,
              svgHeight: 24,
              svgWidth: 24,
              color: Theme.of(context).iconTheme.color,
            ),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                onTap: () {
                  setState(() {
                    _isMostRecent = !_isMostRecent;
                    _isBestReview = false;
                    _isHighestPaid = false;
                  });
                },
                // row with 2 children
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Most recent",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _isMostRecent != false
                        ? Icon(
                            Icons.radio_button_checked_rounded,
                            color: Theme.of(context).iconTheme.color,
                          )
                        : Icon(
                            Icons.radio_button_off_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 2,
                onTap: () {
                  // setState(() {
                  //   _isDeliveryDate = !_isDeliveryDate;
                  //   _isOrderDate = false;
                  // });
                },
                // row with two children
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Best review ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _isBestReview != false
                        ? Icon(
                            Icons.radio_button_checked_rounded,
                            color: Theme.of(context).iconTheme.color,
                          )
                        : Icon(
                            Icons.radio_button_off_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                  ],
                ),
              ),

              PopupMenuItem(
                value: 3,
                onTap: () {
                  // setState(() {
                  //   _isDeliveryDate = !_isDeliveryDate;
                  //   _isOrderDate = false;
                  // });
                },
                // row with two children
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Highest paid",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _isHighestPaid != false
                        ? Icon(
                            Icons.radio_button_checked_rounded,
                            color: Theme.of(context).iconTheme.color,
                          )
                        : Icon(
                            Icons.radio_button_off_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 40),
            elevation: Theme.of(context).brightness == Brightness.dark ? 5 : 0,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                // if value 2 show dialog
              } else if (value == 2) {}
            },
          ),
          GestureDetector(
              onTap: () {
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
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: const RenderSvg(
                  svgPath: VIcons.sort,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () {
            HapticFeedback.lightImpact();
            return reloadData();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "5.0",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w700),
                            ),
                            addVerticalSpacing(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var index = 0; index < 5; index++)
                                  RenderSvg(svgPath: VIcons.star),
                              ],
                            ),
                            addVerticalSpacing(13),
                            Text(
                              "(32)",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                            ),
                            addVerticalSpacing(40),
                            _widgetList(
                                context, "Verified seller reviews", "(15)"),
                            addVerticalSpacing(15),
                            _widgetList(
                                context, "Verified buyer reviews", "(10)"),
                            addVerticalSpacing(15),
                            _widgetList(context, "Automatic reviews", "(7)"),
                          ],
                        ),
                        addVerticalSpacing(40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  // navigateToRoute(context, FAQsHomepage()),
                                  navigateToRoute(context,
                                      const WebViewPage(url: VUrls.faqUrl)),
                              child: Text(
                                "How reviews work",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                            addVerticalSpacing(20),
                            Wrap(
                              children:
                                  List.generate(buttonList.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 0),
                                  child: VWidgetsInterestsButton(
                                      butttonWidth: 20,
                                      enableButton: buttonList[index]
                                          ['selected'],
                                      buttonTitle: buttonList[index]['name'],
                                      onPressed: () {
                                        onItemTap(index);
                                      }),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    )),
                addVerticalSpacing(20),
                Container(
                  margin: const EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 10.0, bottom: 5),
                  child: Column(
                    children: [
                      Text(
                        '$numOfReviews Reviews',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10),
                  child: DemoListTile(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _widgetList(
    BuildContext context,
    String text,
    String braceText,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: "$text ",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                  text: braceText,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400))
            ],
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "5.0",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            addHorizontalSpacing(5),
            RenderSvg(
              svgPath: VIcons.star,
              svgHeight: 13,
            ),
          ],
        ),
      ],
    );
  }

  void onItemTap(int interest) {
    for (var index = 0; index < buttonList.length; index++) {
      buttonList[index]['selected'] = false;
    }
    buttonList[interest]['selected'] = true;

    setState(() {});
  }
}
