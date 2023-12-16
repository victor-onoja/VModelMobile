import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/settings/views/account_settings/views/password_settings_page.dart';
import 'package:vmodel/src/features/settings/views/account_settings/views/verify_password.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/network/urls.dart';
import '../../../../../res/res.dart';
import '../../../../../shared/popup_dialogs/confirmation_popup.dart';
import '../../../../beta_dashboard/views/beta_dashboard_browser.dart';
import '../../../two_step_verification/controller/2fa_controller.dart';
import '../../../two_step_verification/views/two_factor_authentication.dart';

class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(twoStepVerificationProvider);
    List securityAndPrivacyItems = [
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: "Blocked Accounts",
      //     onTap: () {
      //       navigateToRoute(context, const BlockedListHomepage());
      //     }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "2-step verification",
          onTap: () {
            navigateToRoute(context, const TwoFactorAuthentication());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Password Settings",
          onTap: () {
            navigateToRoute(context, const PasswordSettingsPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Devices",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const BetaDashBoardWeb(
                    title: 'Devices', url: VUrls.privacyPolicyUrl)));
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Privacy Policies",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const BetaDashBoardWeb(
                    title: 'Privacy Policies', url: VUrls.privacyPolicyUrl)));
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Deactivate Account",
          onTap: () {
            showDialog(
                context: context,
                builder: ((context) => VWidgetsConfirmationPopUp(
                      popupTitle: "Deactivate account",
                      popupDescription:
                          "Are you sure you want to deactivate your account? You will not be able to access your account until you reactivate it.",
                      onPressedYes: () {
                        Navigator.pop(context);
                        navigateToRoute(context, const VerifyPasswordPage());
                      },
                      onPressedNo: () {
                        Navigator.pop(context);
                      },
                    )));
          }),
    ];
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Security & Privacy",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: ListView.separated(
              itemBuilder: ((context, index) => securityAndPrivacyItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: securityAndPrivacyItems.length),
        ),
      ),
    );
  }
}
