import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/core/utils/shared.dart';

class CheckOutInfo extends StatelessWidget {
  const CheckOutInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const VWidgetsPagePadding.horizontalSymmetric(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 511,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: VmodelColors.contractBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 62,
                  width: 62,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/backgrounds/payment_bg.jpeg"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter)),
                ),
                addHorizontalSpacing(18),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Sarah Tierney",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: VmodelColors.textColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          addHorizontalSpacing(8),
                          SvgPicture.asset(
                            VIcons.flag,
                            width: 20,
                            height: 14.29,
                          ),
                          addHorizontalSpacing(30),
                          Text(
                            "£155.00",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: VmodelColors.textColor),
                          ),
                        ],
                      ),
                      addVerticalSpacing(8),
                      Text(
                        "Commercial, Glamour, Runway",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: VmodelColors.lightText),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 40,
              color: VmodelColors.borderColor,
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date and time",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: VmodelColors.boldGreyText),
                ),
                addVerticalSpacing(10),
                Row(
                  children: [
                    Text(
                      "Monday, August 30 at 10:00",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.unselectedText),
                    ),
                    addHorizontalSpacing(4),
                    Text(
                      "GMT +1:00",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.boldGreyText),
                    ),
                  ],
                ),
                addVerticalSpacing(12),
                Text(
                  "Location",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: VmodelColors.boldGreyText),
                ),
                addVerticalSpacing(10),
                Text(
                  "1 Castle Ln, London \nSW1E 6DR",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: VmodelColors.unselectedText),
                )
              ],
            ),
            Divider(
              height: 40,
              color: VmodelColors.borderColor,
              thickness: 1,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service details",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: VmodelColors.boldGreyText),
                    ),
                    Text(
                      "Price per hour",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.boldGreyText),
                    ),
                  ],
                ),
                addVerticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.unselectedText),
                    ),
                    Text(
                      "£155.00",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.unselectedText),
                    ),
                  ],
                ),
                addVerticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount (10%)",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.unselectedText),
                    ),
                    Text(
                      "£5.00",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.unselectedText),
                    ),
                  ],
                ),
              ],
            ),
            VWidgetsPrimaryTextFieldWithTitle(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: SvgPicture.asset(
                    VIcons.promo,
                    width: 16.67,
                    height: 13.57,
                  ),
                ),
                hintText: "Promo code",
                suffixIcon: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                    child: Text(
                      "Apply",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: VmodelColors.boldGreyText,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                    ))),
            Divider(
              color: VmodelColors.borderColor,
              thickness: 1,
            ),
            addVerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: VmodelColors.unselectedText),
                ),
                Text(
                  "£155.00",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: VmodelColors.unselectedText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
