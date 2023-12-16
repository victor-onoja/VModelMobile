import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/loader/full_screen.dart';
import 'package:vmodel/src/vmodel.dart';




class PhoneVerificationCodePage extends StatelessWidget {
  const PhoneVerificationCodePage({super.key});

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
          ProgressHUD(
            child: Padding(
              padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              child: PinCodeTextField(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context, 
                length: 4, 
                keyboardType: TextInputType.number,
                
                animationCurve: Curves.easeIn,
                inputFormatters:  
                  <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: VmodelColors.primaryColor.withOpacity(1),
                      ),
                pastedTextStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
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
            )
            ),
 
           addVerticalSpacing(40),
            VWidgetsPrimaryButton(
                buttonTitle: "Verify Code",
                enableButton: true,
                onPressed: () {
                  navigateToRoute(context, const DashBoardView());
                }),
          ],
        ),
      ),
    );
  }
}