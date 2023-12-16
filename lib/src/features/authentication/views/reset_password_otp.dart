import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/loader/full_screen.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/extensions/custom_text_input_formatters.dart';
import 'create_password_view.dart';

class ResetVerificationCodePage extends StatefulWidget {
  final String otp, link;
  const ResetVerificationCodePage(
      {super.key, required this.otp, required this.link});

  @override
  State<ResetVerificationCodePage> createState() =>
      _ResetVerificationCodePageState();
}

class _ResetVerificationCodePageState extends State<ResetVerificationCodePage> {
  final TextEditingController _otpController = TextEditingController();
  // final GraphQlService _graphQlService = GraphQlService();
  String _err = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.white,
        appbarTitle: "",
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          children: [
            Text(
              "OTP Verification",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: VmodelColors.primaryColor),
            ),
            addVerticalSpacing(40),
            ProgressHUD(
                child: Padding(
              padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              child: PinCodeTextField(
                controller: _otpController,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context,
                length: 4,
                keyboardType: TextInputType.text,

                animationCurve: Curves.easeIn,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                // inputFormatters:
                // <TextInputFormatter>[FilteringTextInputFormatter.],
                // textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                //   fontWeight: FontWeight.w600,
                //   color: VmodelColors.primaryColor.withOpacity(1),
                // ),
                pastedTextStyle:
                    Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.primaryColor.withOpacity(1),
                        ),
                pinTheme: PinTheme(
                  activeColor: VmodelColors.primaryColor,
                  inactiveColor: VmodelColors.primaryColor.withOpacity(0.5),
                  selectedColor: VmodelColors.primaryColor,
                ),
                onChanged: (value) {},
              ),
            )),
            Text(
              "If you have an account with us, an OTP will be sent to your email, enter the OTP to reset your password",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: VmodelColors.primaryColor.withOpacity(0.5),
                  ),
            ),
            addVerticalSpacing(40),
            Text(
              _err,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500, color: VmodelColors.error),
            ),
            VWidgetsPrimaryButton(
                buttonTitle: "Verify Code",
                enableButton: true,
                onPressed: () {
                  if (_otpController.text.trim().toLowerCase() ==
                      widget.otp.toLowerCase()) {
                    navigateToRoute(
                        context, CreatePasswordView(link: widget.link));
                  } else {
                    setState(() {
                      _err = 'Incorrect OTP';
                    });
                  }
                  // navigateToRoute(context, const DashBoardView());
                }),
          ],
        ),
      ),
    );
  }
}
