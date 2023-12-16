import 'package:flutter/services.dart';
import 'package:vmodel/src/features/onboarding/views/onboarding_name_page.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class OnboardingEmailPage extends StatelessWidget {
  const OnboardingEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.35),
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Please enter your email',
                  style: promptTextStyle,
                )),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: const VWidgetsPrimaryTextFieldWithTitle(
                    hintText: 'Ex: email@example.com',
                    //validator: ,
                    //onSaved: ,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: VWidgetsPrimaryButton(
              onPressed: () { HapticFeedback.lightImpact();
                navigateToRoute(context, const OnboardingNamePage());
              },
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
