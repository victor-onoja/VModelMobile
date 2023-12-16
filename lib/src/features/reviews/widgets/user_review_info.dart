import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class ReviewUserInfo extends StatelessWidget {
  const ReviewUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Location",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.primaryColor.withOpacity(0.5)),
            ),
            addHorizontalSpacing(20),
            Text(
              "London, UK",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.primaryColor),
            ),
          ],
        ),
        addVerticalSpacing(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Type",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.primaryColor.withOpacity(0.5)),
            ),
            addHorizontalSpacing(40),
            Text(
              "Commercial",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: VmodelColors.primaryColor),
            ),
          ],
        ),
      ],
    );
  }
}
