import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/blue-tick_homepage.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../widgets/settings_submenu_tile_widget.dart';
import 'verification/views/verify_identity_view.dart';

class VerificationSettingPage extends StatelessWidget {
  const VerificationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List verificationSettingsItems = [
      VWidgetsSettingsSubMenuTileWidget(
          title: "ID Verification",
          onTap: () {
            navigateToRoute(context, const VerifyYourIdentity());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Blue tick",
          onTap: () {
            navigateToRoute(context, const BlueTickHomepage());
          }),
    ];
    return Scaffold(
        appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(),
          appbarTitle: "Verification",
        ),
        body: Container(
            margin: const EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    verificationSettingsItems[index],
                separatorBuilder: (context, index) => const Divider(),
                itemCount: verificationSettingsItems.length))
        // body: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       addVerticalSpacing(30),
        //       Center(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             SvgPicture.asset(
        //               VIcons.securityUserIcon,
        //               width: 39.42,
        //               height: 45.83,
        //             ),
        //             addVerticalSpacing(20),
        //             Text(
        //               "Verifying your identity",
        //               style: Theme.of(context).textTheme.displayMedium?.copyWith(
        //                   fontWeight: FontWeight.w600,
        //                   fontSize: 18,
        //                   color: VmodelColors.primaryColor),
        //             ),
        //             addVerticalSpacing(15),
        //             Padding(
        //               padding: const VWidgetsPagePadding.horizontalSymmetric(20),
        //               child: Text(
        //                 "We need to check that you are who you say you are. Here’s how it works",
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .displayMedium
        //                     ?.copyWith(
        //                         fontWeight: FontWeight.w500,
        //                         fontSize: 14,
        //                         color: VmodelColors.primaryColor),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       addVerticalSpacing(50),
        //       Padding(
        //         padding: const VWidgetsPagePadding.horizontalSymmetric(20),
        //         child: Column(
        //           children: [
        //             const VerifyOption(
        //               text:
        //                   "Take a picture of a valid photo ID To check your personal information is correct",
        //               iconPath: VIcons.user3Icon,
        //             ),
        //             addVerticalSpacing(20),
        //             const VerifyOption(
        //               text:
        //                   "Record a short video of yourself to match your face to your ID photos",
        //               iconPath: VIcons.recordIcon,
        //             ),
        //             addVerticalSpacing(40),
        //             VWidgetsPrimaryButton(
        //               buttonTitle: "Get started",
        //               onPressed: () {
        //                 navigateToRoute(context, const VerifyYourIdentity());
        //               },
        //               enableButton: true,
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
