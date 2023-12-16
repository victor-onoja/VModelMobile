


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';

import '../../../../shared/buttons/primary_button.dart';
import 'offer_accepted.dart';

class VerifyNationalID extends StatefulWidget {
  final XFile image;
  const VerifyNationalID({Key? key,required this.image}) : super(key: key);

  @override
  State<VerifyNationalID> createState() => _VerifyNationalIDState();
}

class _VerifyNationalIDState extends State<VerifyNationalID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: VmodelColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center(
            //   child: Center(
            //     child: Container(
            //       height: 237,
            //       width: 339,
            //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //       child: ClipRRect(
            //           borderRadius: BorderRadius.circular(20),
            //           child: Image.file(File(widget.image.path), fit: BoxFit.cover)),
            //     ),
            //   ),
            // ),
            // addVerticalSpacing(20),
            Text(
              "Verifying...",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  // fontSize: 14,
                  color: VmodelColors.white),
              textAlign: TextAlign.center,
            ),
            addVerticalSpacing(15),
            Text(
              "We’re now checking your details to make sure everything is right. Please give us a moment...",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: VmodelColors.white),
              textAlign: TextAlign.start,
            ),
            addVerticalSpacing(20),
            VWidgetsPrimaryButton(onPressed: () {
              navigateAndReplaceRoute(context, const JobMarketOfferAccepted());
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

