import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/reviews/views/booking_details.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/page_padding/page_padding.dart';


class BookingItems extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String dateRange;
  final String timeRemaining;

  const BookingItems({
    Key? key,
    required this.image,
    required this.title,
    required this.location,
    required this.dateRange,
    required this.timeRemaining,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const VWidgetsPagePadding.verticalSymmetric(10),
      child: GestureDetector(
        onTap: () => navigateToRoute(context, const BookingDetailsView()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            addHorizontalSpacing(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                addVerticalSpacing(4),
                Text(
                  location,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                Text(
                  dateRange,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.primaryColor,
                      ),
                ),
                Text(
                  timeRemaining,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: VmodelColors.text3,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
