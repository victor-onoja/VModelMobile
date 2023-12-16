import 'package:flutter/services.dart';
import 'package:vmodel/src/features/onboarding/controller/onboarding_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/text_fields/signup_text_field.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';

class OnboardingAddress extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  OnboardingAddress({
    Key? key,
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
                  OnboardingInteractor.onBusinessAddressSubmitted(context);
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.20),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Please enter your business address',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13.sp),
                          ),
                        ),
                        addVerticalSpacing(26),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'First line of address',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: VmodelColors.mainColor,
                                      fontSize: 16),
                                ),
                              ),
                              addVerticalSpacing(5),
                              VWidgetsSignUpTextField(
                                obscureText: false,
                                hintText: 'Ex: 393 Dagenham Heathway',
                                onSaved: (p0) {
                                  Get.find<OnboardingController>()
                                      .streetAddress(p0);
                                },
                                validator: (v) => VValidatorsMixin.isNotEmpty(
                                  v,
                                  field: 'Address',
                                ),
                              ),
                            ],
                          ),
                        ),
                        addVerticalSpacing(SizeConfig.screenHeight * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'City',
                                  style: TextStyle(
                                      color: VmodelColors.mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              addVerticalSpacing(5),
                              VWidgetsSignUpTextField(
                                obscureText: false,
                                hintText: 'Ex: 393 Dagenham Heathway',
                                onSaved: (p0) {
                                  Get.find<OnboardingController>().city(p0);
                                },
                                validator: (v) => VValidatorsMixin.isNotEmpty(
                                  v,
                                  field: 'City',
                                ),
                              ),
                            ],
                          ),
                        ),
                        addVerticalSpacing(SizeConfig.screenHeight * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Postcode',
                                        style: TextStyle(
                                            color: VmodelColors.mainColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    addVerticalSpacing(5),
                                    VWidgetsSignUpTextField(
                                      obscureText: false,
                                      hintText: 'Ex: RM95AG',
                                      onSaved: (p0) {
                                        Get.find<OnboardingController>()
                                            .postCode(p0);
                                      },
                                      validator: (v) =>
                                          VValidatorsMixin.isNotEmpty(
                                        v,
                                        field: 'Postcode',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              addHorizontalSpacing(10),
                              Flexible(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'State',
                                        style: TextStyle(
                                            color: VmodelColors.mainColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    addVerticalSpacing(5),
                                    VWidgetsSignUpTextField(
                                      obscureText: false,
                                      hintText: 'Ex: London',
                                      onSaved: (p0) {
                                        Get.find<OnboardingController>()
                                            .state(p0);
                                      },
                                      validator: (v) =>
                                          VValidatorsMixin.isNotEmpty(
                                        v,
                                        field: 'State',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              addVerticalSpacing(SizeConfig.screenHeight * 0.24),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                child: VWidgetsPrimaryButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    if (formKey.currentState?.validate() ?? false) {
                      OnboardingInteractor.onBusinessAddressSubmitted(context);
                    }
                  },
                  enableButton: true,
                  buttonTitle: "Continue",
                ),
              ),
              addVerticalSpacing(40),
            ],
          ),
        ));
  }
}
