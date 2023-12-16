import 'package:flutter/services.dart';
import 'package:vmodel/src/features/authentication/login/views/widgets/phone_verification_code_page.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/login_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  bool checkboxValue = false;
  bool _isPhoneNumberTyping = false;
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
              "Phone Verification",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: VmodelColors.primaryColor),
            ),
            addVerticalSpacing(40),
            VWidgetsLoginTextField(
              hintText: "Phone Number",
              keyboardType: TextInputType.number,
              formatter: FilteringTextInputFormatter.digitsOnly,
              onChanged: (p0) {
                setState(() {
                  _isPhoneNumberTyping = true;
                });
              },
            ),
            if (_isPhoneNumberTyping)
              Text(
                "Your phone number will be verified on the next screen.",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: VmodelColors.primaryColor.withOpacity(0.5),
                    ),
              ),
            addVerticalSpacing(25),
            VWidgetsPrimaryButton(
                buttonTitle: "Sign Up",
                enableButton: true,
                onPressed: () {
                  navigateToRoute(context, const PhoneVerificationCodePage());
                }),
          ],
        ),
      ),
    );
  }
}
