import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/settings/views/verification/views/verify_video.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

class CapturedDrivingLicence extends StatefulWidget {
  const CapturedDrivingLicence({Key? key, required this.image})
      : super(key: key);

  final XFile image;
  @override
  State<CapturedDrivingLicence> createState() => _CapturedDrivingLicenceState();
}

class _CapturedDrivingLicenceState extends State<CapturedDrivingLicence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Driving licence",
        appBarHeight: 50,
        elevation: 0.0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpacing(30),
              Text(
                "Is the front of your driving licence in the frame and easy to read? If so, you’re good to go!",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      // color: VmodelColors.primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
              addVerticalSpacing(60),
              Center(
                child: Center(
                  child: Container(
                    height: 237,
                    width: 339,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(widget.image.path),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              addVerticalSpacing(60),
              VWidgetsPrimaryButton(
                onPressed: () {
                  navigateToRoute(
                      context,
                      VerifyVideo(
                        image: widget.image,
                      ));
                },
                buttonTitle: "Use this picture",
                enableButton: true,
              ),
              addVerticalSpacing(20),
              GestureDetector(
                onTap: () {
                  goBack(context);
                },
                child: Text(
                  "Retake picture",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        // color: VmodelColors.primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
