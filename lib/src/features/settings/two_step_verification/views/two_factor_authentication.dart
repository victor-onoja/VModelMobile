import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/settings/widgets/cupertino_switch_card.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/cache/credentials.dart';
import '../../../../core/cache/local_storage.dart';
import '../../../../res/gap.dart';
import '../../../../shared/appbar/appbar.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../controller/2fa_controller.dart';

class TwoFactorAuthentication extends ConsumerStatefulWidget {
  const TwoFactorAuthentication({Key? key}) : super(key: key);

  @override
  ConsumerState<TwoFactorAuthentication> createState() =>
      _TwoFactorAuthenticationState();
}

class _TwoFactorAuthenticationState
    extends ConsumerState<TwoFactorAuthentication> {
  bool usebiometrics = false;
  bool usemessage = false;
  bool useemail = false;

  @override
  void initState() {
    super.initState();
    usebiometrics = BiometricService.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    final user2FA = ref.watch(twoStepVerificationProvider);
    return Scaffold(
        appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(),
          appbarTitle: "2-step verification",
        ),
        body: Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Column(children: [
              addVerticalSpacing(25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    VWidgetsCupertinoSwitchWithText(
                      titleText: "Biometrics",
                      value: usebiometrics,
                      onChanged: ((value) {
                        BiometricService.authenticateUser()
                            .then((authenticated) async {
                          if (authenticated) {
                            final res = await VModelSharedPrefStorage()
                                .putBool(VSecureKeys.biometricEnabled, value);
                            print(
                                'Puuuuuuuuuutttttttttttttt is $res and value: $value');
                            if (res) {
                              BiometricService.isEnabled = value;
                            }
                            setState(() {
                              usebiometrics = !usebiometrics;
                            });
                          } else {
                            VWidgetShowResponse.showToast(ResponseEnum.failed,
                                message: usebiometrics
                                    ? "Failed to disable biometric lock"
                                    : "Failed to enable biometric lock");
                            VModelSharedPrefStorage()
                                .putBool(VSecureKeys.biometricEnabled, false);
                          }
                        });
                      }),
                    ),
                    addVerticalSpacing(6),
                    VWidgetsCupertinoSwitchWithText(
                      titleText: "Text Message",
                      value: usemessage,
                      onChanged: ((p0) {
                        setState(() {
                          usemessage = !usemessage;
                        });
                      }),
                    ),
                    addVerticalSpacing(6),
                    VWidgetsCupertinoSwitchWithText(
                      titleText: "Email",
                      value: user2FA.valueOrNull ?? false,
                      onChanged: ((newValue) async {
                        await ref
                            .read(twoStepVerificationProvider.notifier)
                            .update2FA(use2FA: newValue);
                        // setState(() {
                        //   useemail = !useemail;
                        // });
                      }),
                    ),
                    addVerticalSpacing(40),
                  ]),
                ),
              )
            ])));
  }
}
