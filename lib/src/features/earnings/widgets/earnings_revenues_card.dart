import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsEarningsRevenuesCard extends StatelessWidget {
  final String? paymentsCleared;
  final String? earningsToDate;
  final String? expensesToDate;
  final String? withdrawnToDate;
  final VoidCallback? onTapPaymentsCleared;
  final VoidCallback? onTapEarningsToDate;
  final VoidCallback? onTapExpensesToDate;
  final VoidCallback? onTapWithdrawnToDate;
  final bool showArrow;

  const VWidgetsEarningsRevenuesCard(
      {required this.paymentsCleared,
      this.showArrow = true,
      required this.earningsToDate,
      required this.expensesToDate,
      required this.withdrawnToDate,
      required this.onTapPaymentsCleared,
      required this.onTapEarningsToDate,
      required this.onTapExpensesToDate,
      required this.onTapWithdrawnToDate,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // GestureDetector(
        //   onTap: onTapPaymentsCleared,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Payment being Cleared",
        //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //               color: VmodelColors.primaryColor,
        //             ),
        //       ),
        //       Row(
        //         children: [
        //           Text(
        //             "£$paymentsCleared",
        //             style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //                   color: VmodelColors.primaryColor,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //           ),
        //           addHorizontalSpacing(10),
        //           RenderSvg(
        //             svgPath: VIcons.forwardIcon,
        //             svgWidth: 15,
        //             svgHeight: 15,
        //             color: VmodelColors.primaryColor.withOpacity(0.5),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // addVerticalSpacing(15),
        GestureDetector(
          onTap: onTapEarningsToDate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Earnings to date",
                style: Theme.of(context).textTheme.displayMedium!,
              ),
              Row(
                children: [
                  Text(
                    "£ $earningsToDate",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  addHorizontalSpacing(10),
                  if(showArrow)
                  RenderSvg(
                    svgPath: VIcons.forwardIcon,
                    svgWidth: 15,
                    svgHeight: 15,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              )
            ],
          ),
        ),
        // addVerticalSpacing(15),
        // GestureDetector(
        //   onTap: onTapExpensesToDate,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Expenses to date",
        //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //               color: VmodelColors.primaryColor,
        //             ),
        //       ),
        //       Row(
        //         children: [
        //           Text(
        //             "£$expensesToDate",
        //             style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //                   color: VmodelColors.primaryColor,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //           ),
        //           addHorizontalSpacing(10),
        //           RenderSvg(
        //             svgPath: VIcons.forwardIcon,
        //             svgWidth: 15,
        //             svgHeight: 15,
        //             color: VmodelColors.primaryColor.withOpacity(0.5),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // addVerticalSpacing(15),
        // GestureDetector(
        //   onTap: onTapWithdrawnToDate,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Withdrawn to date",
        //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //               color: VmodelColors.primaryColor,
        //             ),
        //       ),
        //       Row(
        //         children: [
        //           Text(
        //             "£$withdrawnToDate",
        //             style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //                   color: VmodelColors.primaryColor,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //           ),
        //           addHorizontalSpacing(10),
        //           RenderSvg(
        //             svgPath: VIcons.forwardIcon,
        //             svgWidth: 15,
        //             svgHeight: 15,
        //             color: VmodelColors.primaryColor.withOpacity(0.5),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
