import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';

class ReportABugHomePage extends StatelessWidget {
  const ReportABugHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Report a bug",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  VWidgetsDescriptionTextFieldWithTitle(
                    hintText: "Share as much details as possible...",
                    minLines: 7,
                  ),
                  addVerticalSpacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VWidgetsPrimaryTextFieldWithTitle2(
                        label: "Phone Type",
                        hintText: "iPhone 13 Pro Max",
                        minWidth: MediaQuery.of(context).size.width * .4,
                        maxLines: 1,
                      ),
                      VWidgetsPrimaryTextFieldWithTitle2(
                        label: "OS verison",
                        hintText: "iOS verion 15.4",
                        minWidth: MediaQuery.of(context).size.width * .4,
                        maxLines: 1,
                      ),
                    ],
                  )
                ],
              ),
            )),
            addVerticalSpacing(10),
            VWidgetsPrimaryButton(
              onPressed: () {},
              buttonTitle: "Submit",
              enableButton: true,
            ),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
