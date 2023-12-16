import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';

import '../../settings/views/verification/views/blue-tick/widgets/text_field.dart';

class ReportIllegalPage extends StatelessWidget {
  const ReportIllegalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Report something illegal",
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
                  addVerticalSpacing(24),
                  const VWidgetsTextFieldNormal(
                    hintText: "Type in a name or username ...",
                  ),
                  VWidgetsDescriptionTextFieldWithTitle(
                    hintText: "Share as much details as possible...",
                    minLines: 5,
                  ),
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
