import 'package:flutter/services.dart';
import 'package:vmodel/src/features/onboarding/controller/onboarding_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/signup_text_field.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';

class OnboardingEmail extends StatelessWidget with VValidatorsMixin {
  final String selectedIndustry;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  OnboardingEmail({Key? key, required this.selectedIndustry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController(selectedIndustry));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
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
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                      fontSize: 13.sp),
                )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: formKey,
                    child: VWidgetsSignUpTextField(
                      obscureText: false,
                      onSaved: (String? value) {},
                      hintText: 'Ex: email@example.com',
                      validator: VValidatorsMixin.isEmailValid,
                      controller:
                          Get.find<OnboardingController>().emailController,
                    ),
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
                if (formKey.currentState?.validate() ?? false) {
                  OnboardingInteractor.onEmailSubmitted(context);
                } else {
                  // Get.snackbar('Invalid Email', 'Please enter a valid email');
                }
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
