import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/features/settings/views/verification/views/verify_identity_view.dart';
import 'package:vmodel/src/features/settings/views/verification/widget/verify_option.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class GetStartedWithVerification extends StatelessWidget {
  const GetStartedWithVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "",
        appBarHeight: 50,
        elevation: 0.0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(30),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    VIcons.securityUserIcon,
                    width: 39.42,
                    height: 45.83,
                  ),
                  addVerticalSpacing(20),
                  Text(
                    "Verifying your identity",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: VmodelColors.primaryColor),
                  ),
                  addVerticalSpacing(15),
                  Padding(
                    padding: const VWidgetsPagePadding.horizontalSymmetric(20),
                    child: Text(
                      "We need to check that you are who you say you are. Here’s how it works",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: VmodelColors.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpacing(50),
            Padding(
              padding: const VWidgetsPagePadding.horizontalSymmetric(20),
              child: Column(
                children: [
                  const VerifyOption(
                    text:
                        "Take a picture of a valid photo ID To check your personal information is correct",
                    iconPath: VIcons.user3Icon,
                  ),
                  addVerticalSpacing(20),
                  const VerifyOption(
                    text:
                        "Record a short video of yourself to match your face to your ID photos",
                    iconPath: VIcons.recordIcon,
                  ),
                  addVerticalSpacing(40),
                  VWidgetsPrimaryButton(
                    buttonTitle: "Get started",
                    onPressed: () {
                      navigateToRoute(context, const VerifyYourIdentity());
                    },
                    enableButton: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
