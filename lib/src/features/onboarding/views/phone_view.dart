import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vmodel/src/features/onboarding/controller/onboarding_controller.dart';
import 'package:vmodel/src/features/onboarding/views/business_address_view.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';

class OnboardingPhone extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  OnboardingPhone({
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
                navigateToRoute(context, OnboardingAddress());
              },
            ),
          ),
        ],
      ),
      body: GetX<OnboardingController>(builder: (controller) {
        // controller.phone("");
        return controller.phone.string == '' ||
                controller.phone.string.length < 4
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.35),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'Please enter your phone number',
                          style: promptTextStyle,
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: VmodelColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Form(
                              key: formKey,
                              child: IntlPhoneField(
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                ),
                                showDropdownIcon: false,
                                flagsButtonMargin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      14.5, 8.5, 14.5, 8.5),
                                  errorMaxLines: 1,
                                  counter: Container(),
                                  hintText: 'Ex: 073 7799 991',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Avenir',
                                    color: VmodelColors.hintColor,
                                  ),
                                  errorStyle: TextStyle(
                                    fontFamily: 'Avenir',
                                    color: VmodelColors.error,
                                  ),
                                  border: InputBorder.none,
                                ),
                                initialCountryCode: 'GB',
                                onChanged: (phone) {
                                  Get.find<OnboardingController>()
                                      .phoneController
                                      .text = phone.completeNumber;
                                },
                                validator: (v) =>
                                    VValidatorsMixin.isPhoneValid(v!.number),
                              ),
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
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if (formKey.currentState?.validate() ?? false) {
                          OnboardingInteractor.onPhoneSubmitted(context);
                        }
                      },
                      enableButton: true,
                      buttonTitle: "Continue",
                    ),
                  ),
                  addVerticalSpacing(40),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'Please verify your phone number',
                          style: promptTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        controller.phone.string,
                        style: TextStyle(
                            color: VmodelColors.mainColor, fontSize: 16),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        'We\'ve sent you a PIN code, \nPlease enter your verification code here',
                        style: TextStyle(
                            color: VmodelColors.mainColor, fontSize: 12),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                  addVerticalSpacing(30),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      autoUnfocus: true,
                      length: 4,
                      pinTheme: PinTheme(
                          inactiveFillColor: Colors.green,
                          activeFillColor: Colors.green,
                          selectedFillColor: Colors.green,
                          borderWidth: 2,
                          fieldWidth: 45,
                          selectedColor: VmodelColors.buttonColor,
                          activeColor: Colors.transparent,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12)),
                      onChanged: (v) {
                        Get.find<OnboardingController>().pin(v);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    'Incorrect PIN, please try again',
                    style: TextStyle(color: VmodelColors.error, fontSize: 12),
                    textAlign: TextAlign.center,
                  )),
                  const Spacer(),
                  Padding(
                    padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                    child: VWidgetsPrimaryButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        OnboardingInteractor.onPinSubmitted(context);
                      },
                      enableButton: true,
                      buttonTitle: "Continue",
                    ),
                  ),
                  addVerticalSpacing(40),
                ],
              );
      }),
    );
  }
}
