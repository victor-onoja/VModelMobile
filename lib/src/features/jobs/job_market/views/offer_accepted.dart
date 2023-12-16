import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';

import '../../../../res/colors.dart';
import '../../../../res/gap.dart';
import '../../../../shared/buttons/primary_button.dart';

class JobMarketOfferAccepted extends StatelessWidget {
  const JobMarketOfferAccepted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: VmodelColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
                child: Icon(Icons.check_circle_outline,color: VmodelColors.white,)),
            addVerticalSpacing(30),
            Text(
              "ID accepted and Verified!",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  // fontSize: 14,
                  color: VmodelColors.white),
              textAlign: TextAlign.center,
            ),
            addVerticalSpacing(15),
            Align(
              child: Text(
                "We’ve now Verified your ID, you can now send job offers, book jobs, get paid and more.",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: VmodelColors.white),
                textAlign: TextAlign.start,
              ),
            ),
            addVerticalSpacing(20),
            VWidgetsPrimaryButton(onPressed: () {
              navigateAndReplaceRoute(context, const DashBoardView());
            },    buttonTitle: "Okay",buttonTitleTextStyle:Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: VmodelColors.primaryColor),
                enableButton: true,buttonColor: VmodelColors.white,butttonWidth: MediaQuery.of(context).size.width /3),
          ],
        ),
      ),
    );
  }
}