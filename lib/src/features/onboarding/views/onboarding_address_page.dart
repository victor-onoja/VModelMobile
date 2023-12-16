import 'package:flutter/services.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class OnboardingAddressPage extends StatelessWidget {
  const OnboardingAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.04),
            child: VWidgetsTextButton(
              text: 'Skip',
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: screenSize.height * 0.25),
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Where are you based?',
                  style: promptTextStyle,
                )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: const VWidgetsPrimaryTextFieldWithTitle(
                      hintText: "Ex. London, UK",
                      //add other functionality here
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const Spacer(),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: VWidgetsPrimaryButton(
              onPressed: () {},
              enableButton: true,
              buttonTitle: 'Detect Automatically',
            ),
          ),
          addVerticalSpacing(5),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: VWidgetsPrimaryButton(
              onPressed: () { HapticFeedback.lightImpact();},
              enableButton: true,
              buttonTitle: 'Continue',
            ),
          ),
          addVerticalSpacing(40),
        ],
      ),
    );
  }
}
