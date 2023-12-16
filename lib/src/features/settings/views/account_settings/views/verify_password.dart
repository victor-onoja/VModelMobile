import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/network/graphql_service.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/settings/views/account_settings/provider/account_deactivation_provider.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../authentication/new_Login_screens/login_screen.dart';

class VerifyPasswordPage extends ConsumerStatefulWidget {
  const VerifyPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyPasswordPageState();
}

class _VerifyPasswordPageState extends ConsumerState<VerifyPasswordPage>
    with VValidatorsMixin {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final obscurePassword = ValueNotifier(true);

  // @override
  // initState() {
  //   super.dispose();

  // }

  @override
  void dispose() {
    currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountDeactivationState = ref.watch(accountDeactivationProvider);
    ref.listen(accountDeactivationProvider, (prev, next) async {
      if (next.isRefreshing || next.isLoading) {
        VLoader.changeLoadingState(true);
      } else if (next.hasError) {
        VWidgetShowResponse.showToast(ResponseEnum.failed,
            message: '${next.error}');
      } else {
        VLoader.changeLoadingState(false);
        if (next.hasValue && next.value!) {
          VWidgetShowResponse.showToast(ResponseEnum.failed,
              message: 'Account deactivated successfully');
          ref.read(authProvider.notifier).logout();

          await VModelSharedPrefStorage().clearObject(VSecureKeys.userTokenKey);
          await VModelSharedPrefStorage().clearObject(VSecureKeys.username);
          if (!mounted) return;
          navigateAndRemoveUntilRoute(context, const OnBoardingPage());
        }
      }
    });
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Confirm account deactivation",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              child: Column(children: [
                addVerticalSpacing(25),
                // VWidgetsPrimaryTextFieldWithTitle2(
                ValueListenableBuilder(
                    valueListenable: obscurePassword,
                    builder: (context, value, _) {
                      return VWidgetsTextFieldNormal(
                        labelText: "Current Password",
                        hintText: "Enter your current password",
                        controller: currentPasswordController,
                        obscureText: value,
                        suffixIcon: _suffixIcon(() {
                          obscurePassword.value = !obscurePassword.value;
                        }, value),
                      );
                    }),
                // addVerticalSpacing(15),
                // VWidgetsPrimaryTextFieldWithTitle2(
                //   label: "Confirm new Password",
                //   hintText: "Confirm your new password",
                //   controller: confirmPasswordController,
                //   obscureText: model.confirmPasswordObscure,
                //   suffixIcon: _suffixIcon(
                //       () => passwordSettingNotifier
                //           .toggleConfirmPasswordObscure(),
                //       model.confirmPasswordObscure),
                // ),
              ]),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
            child: Consumer(builder: (_, ref, __) {
              final authNotifier = ref.read(authProvider.notifier);
              return VWidgetsPrimaryButton(
                onPressed: () async {
                  // VLoader.changeLoadingState(true);
                  // final token =
                  //     await VModelSharedPrefStorage().getString('token');
                  // await authNotifier.passwordChange(
                  //     token: token!,
                  //     oldPassword: currrentPasswordController.text,
                  //     newPassword1: newPasswordController.text,
                  //     newPassword2: confirmPasswordController.text);

                  ref
                      .read(accountDeactivationProvider.notifier)
                      .deactivateAccount(currentPasswordController.text);

                  // VLoader.changeLoadingState(false);
                  // if (authNotifier.state.status == AuthStatus.authenticated) {
                  //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
                  //       message: 'Password changed successfully');
                  // } else {
                  //   VWidgetShowResponse.showToast(ResponseEnum.failed,
                  //       message: 'Invalid old password');
                  // }

                  // popSheet(context);
                },
                buttonTitle: "Done",
                enableButton: true,
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _suffixIcon(Function() onPressed, bool isObscure) {
    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        icon: Icon(isObscure
            ? Icons.visibility_rounded
            : Icons.visibility_off_rounded));
  }
}
