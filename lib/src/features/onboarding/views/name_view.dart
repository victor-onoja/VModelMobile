import 'package:flutter/services.dart';
import 'package:vmodel/src/features/onboarding/controller/onboarding_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/text_fields/signup_text_field.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';

class OnboardingName extends StatelessWidget {
  final String selectedIndustry;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  OnboardingName({
    Key? key,
    required this.selectedIndustry,
  }) : super(key: key);

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
              onPressed: () {
                OnboardingInteractor.onNameSubmitted(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: screenSize.height * 0.35),
            child: Column(
              children: [
                Center(
                    child: Text(
                  selectedIndustry == 'Business'
                      ? 'Please enter your business name'
                      : 'Please enter your name',
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
                        hintText: selectedIndustry == 'Business'
                            ? 'Ex: Matt’s Kitchen'
                            : 'Ex: Jane Cooper',
                        validator: VValidatorsMixin.isNameValid,
                        controller:
                            Get.find<OnboardingController>().nameController,
                      )),
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
                  OnboardingInteractor.onNameSubmitted(context);
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
