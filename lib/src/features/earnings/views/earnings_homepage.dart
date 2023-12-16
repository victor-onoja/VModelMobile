import 'package:intl/intl.dart';
import 'package:vmodel/src/features/earnings/widgets/earnings_analytics_card.dart';
import 'package:vmodel/src/features/earnings/widgets/earnings_revenues_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/costants.dart';
import '../../../res/icons.dart';
import '../../../shared/modal_pill_widget.dart';
import '../../../shared/rend_paint/render_svg.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  String getMonthName() {
    final monthFormat = DateFormat
        .MMMM(); // 'MMMM' gives you the full month name, 'MMM' for abbreviated name
    return monthFormat.format(DateTime.now());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Earnings",
        trailingIcon: [
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
              ))
        ],
      ),
      body: SingleChildScrollView(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpacing(25),
              Center(
                  child: Column(
                children: [
                  Text(
                    "£0.00",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 25.sp),
                  ),
                  addVerticalSpacing(5),
                  Text(
                    "Total earnings",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.color
                            ?.withOpacity(0.5)),
                  ),
                ],
              )),
              Divider(
                thickness: 1,
                height: 50,
                color: Theme.of(context).dividerColor,
              ),
              addVerticalSpacing(10),
              Text(
                "Analytics",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              addVerticalSpacing(20),
              VWidgetsEarningsAnalyticsCard(
                earningsInCurrentMonth: "0",
                averageSellingPrice: "100",
                completedOrders: "0",
                availableForWithdrawal: "0",
                activeOrders: "0",
                month: getMonthName(),
              ),
              Divider(
                thickness: 1,
                height: 50,
                color: Theme.of(context).dividerColor,
              ),
              addVerticalSpacing(10),
              Text(
                "Revenues",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              addVerticalSpacing(20),
              VWidgetsEarningsRevenuesCard(
                  showArrow: false,
                  paymentsCleared: "0",
                  earningsToDate: "0",
                  expensesToDate: "0",
                  withdrawnToDate: "0",
                  onTapPaymentsCleared: () {},
                  onTapEarningsToDate: () {},
                  onTapExpensesToDate: () {},
                  onTapWithdrawnToDate: () {}),
            ],
          )),
    );
  }
}
