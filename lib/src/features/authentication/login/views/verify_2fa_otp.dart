import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vmodel/src/core/utils/extensions/custom_text_input_formatters.dart';
import 'package:vmodel/src/features/authentication/login/provider/login_provider.dart';
import 'package:vmodel/src/features/authentication/reset_password/provider/reset_password_provider.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class Verify2FAOtp extends ConsumerStatefulWidget {
  const Verify2FAOtp({super.key});

  @override
  ConsumerState<Verify2FAOtp> createState() => _Verify2FAOtpState();
}

class _Verify2FAOtpState extends ConsumerState<Verify2FAOtp> {
  String _err = "";
  TextEditingController otPController = TextEditingController();
  final showButtonLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    ref.watch(resetProvider);

    //
    final resetNotifier = ref.watch(resetProvider.notifier);
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(), // SizedBox.shrink(),
        backgroundColor: VmodelColors.white,
        appbarTitle: "",
        elevation: 0,
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OTP Verification",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    // color: VmodelColors.primaryColor,
                  ),
            ),
            Expanded(child: addVerticalSpacing(40)),
            Flexible(
              child: Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                child: PinCodeTextField(
                  controller: otPController,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  appContext: context,
                  length: 4,
                  keyboardType: TextInputType.text,

                  animationCurve: Curves.easeIn,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  cursorColor: context.theme.colorScheme.primary,
                  // inputFormatters:
                  // <TextInputFormatter>[FilteringTextInputFormatter.],
                  // textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  //   fontWeight: FontWeight.w600,
                  //   color: VmodelColors.primaryColor.withOpacity(1),
                  // ),
                  pastedTextStyle:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            // color: VmodelColors.primaryColor.withOpacity(1),
                          ),
                  pinTheme: PinTheme(
                    // activeColor: VmodelColors.primaryColor,
                    // activeColor: context.theme.colorScheme.primary,
                    // inactiveColor: VmodelColors.primaryColor.withOpacity(0.5),
                    // inactiveColor: context.theme.primaryColor.withOpacity(0.5),
                    // selectedColor: context.theme.colorScheme.primary,
                    // selectedColor: VmodelColors.primaryColor,

                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    selectedColor: Theme.of(context).primaryColor,
                    borderWidth: 2,
                    fieldHeight: 45,
                    fieldWidth: 45,
                    // selectedColor: VmodelColors.buttonColor,
                    // activeColor: Colors.transparent,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            addVerticalSpacing(24),
            Text(
              "We've just sent an OTP to your email, please enter the code here.",
              textAlign: TextAlign.center,
              style: context.textTheme.displayMedium!.copyWith(
                  // fontWeight: FontWeight.w500,
                  // color: VmodelColors.primaryColor.withOpacity(0.5),
                  // color:
                  //     context.textTheme.displayMedium!.color?.withOpacity(0.5),
                  fontSize: 14),
            ),
            addVerticalSpacing(40),
            RichText(
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: "Didn't receive a code? ",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          // fontWeight: FontWeight.w500, color: VmodelColors.error,
                          fontSize: 14,
                        ),
                  ),
                  TextSpan(
                    text: "Resend",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                  ),
                  TextSpan(
                    text: " code.",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
              // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //     fontWeight: FontWeight.w600,
              //     color: Theme.of(context).primaryColor),
              // ),
            ),
            Expanded(child: addVerticalSpacing(40)),
            ValueListenableBuilder(
                valueListenable: showButtonLoading,
                builder: (context, value, _) {
                  return VWidgetsPrimaryButton(
                      buttonTitle: "Verify",
                      showLoadingIndicator: value,
                      enableButton: true,
                      onPressed: () async {
                        // if (otPController.text.trim().toLowerCase() ==
                        //     widget.otp.toLowerCase()) {
                        // navigateToRoute(
                        //     context, CreatePasswordView(link: widget.link));
                        showButtonLoading.value = true;
                        await ref.read(loginProvider.notifier).verify2FACode(
                            context,
                            code: otPController.text.trim());
                        showButtonLoading.value = false;
                        // } else {
                        //   setState(() {
                        //     _err = 'Incorrect OTP';
                        //   });
                        // }
                        // navigateToRoute(context, const DashBoardView());
                      });
                }),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
