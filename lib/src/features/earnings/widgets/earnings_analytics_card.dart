import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsEarningsAnalyticsCard extends StatelessWidget {
  final String? earningsInCurrentMonth;
  final String? averageSellingPrice;
  final String? activeOrders;
  final String? availableForWithdrawal;
  final String? completedOrders;
  final String? month;

  const VWidgetsEarningsAnalyticsCard({
    required this.earningsInCurrentMonth,
    required this.averageSellingPrice,
    required this.completedOrders,
    required this.availableForWithdrawal,
    required this.activeOrders,
    required this.month,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Earnings in $month",
              style: Theme.of(context).textTheme.displayMedium!,
            ),
            Text(
              "£ $earningsInCurrentMonth",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            )
          ],
        ),
        // addVerticalSpacing(15),
        // Row(
        //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Avg. Selling Price",
        //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //             color: VmodelColors.primaryColor,
        //           ),
        //     ),
        //     Text(
        //       "£$averageSellingPrice",
        //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //             color: VmodelColors.primaryColor,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     )
        //   ],
        // ),
        addVerticalSpacing(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Active Bookings",
                style: Theme.of(context).textTheme.displayMedium!),
            Text(
              "$activeOrders (£ 0)",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            )
          ],
        ),
        // addVerticalSpacing(15),
        // Row(
        //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Available for withdrawal",
        //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //             color: VmodelColors.primaryColor,
        //           ),
        //     ),
        //     Text(
        //       "£$availableForWithdrawal",
        //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //             color: VmodelColors.primaryColor,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     )
        //   ],
        // ),
        addVerticalSpacing(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Completed orders",
              style: Theme.of(context).textTheme.displayMedium!,
            ),
            Text(
              "$completedOrders (£ 0)",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
