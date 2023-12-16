import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/settings/views/account_settings/provider/password_setting_provider.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../provider/password_change_provider.dart';

class PasswordSettingsPage extends ConsumerStatefulWidget {
  const PasswordSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordSettingsPageState();
}

class _PasswordSettingsPageState extends ConsumerState<PasswordSettingsPage>
    with VValidatorsMixin {
  final TextEditingController currrentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final showButtonLoading = ValueNotifier(false);

  @override
  void dispose() {
    showButtonLoading.dispose();
    currrentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordSettingNotifier = ref.read(passwordSettingProvider.notifier);
    PasswordSettingStateModel model = ref.watch(passwordSettingProvider);
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Password",
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
                VWidgetsPrimaryTextFieldWithTitle2(
                  label: "Current Password",
                  hintText: "Enter your current password",
                  keyboardType: TextInputType.visiblePassword,
                  controller: currrentPasswordController,
                  obscureText: model.oldPasswordObscure,
                  suffixIcon: _suffixIcon(
                      () => passwordSettingNotifier.toggleOldPasswordObscure(),
                      model.oldPasswordObscure),
                ),
                VWidgetsPrimaryTextFieldWithTitle2(
                  label: "New Password",
                  hintText: "Enter your new password",
                  keyboardType: TextInputType.visiblePassword,
                  controller: newPasswordController,
                  obscureText: model.newPasswordObscure,
                  suffixIcon: _suffixIcon(
                      () => passwordSettingNotifier.toggleNewPasswordObscure(),
                      model.newPasswordObscure),
                  validator: (val) {
                    return model.validateNewPassword!.isEmpty
                        ? null
                        : model.validateNewPassword;
                  },
                  onChanged: (val) =>
                      passwordSettingNotifier.checkNewPasswordIsValid(val),
                ),
                VWidgetsPrimaryTextFieldWithTitle2(
                  label: "Confirm new Password",
                  hintText: "Confirm your new password",
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
                  obscureText: model.confirmPasswordObscure,
                  validator: (val) {
                    if (newPasswordController.text == val) return null;
                    return 'Passwords do not match';
                  },
                  suffixIcon: _suffixIcon(
                      () => passwordSettingNotifier
                          .toggleConfirmPasswordObscure(),
                      model.confirmPasswordObscure),
                ),
              ]),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
            child: Consumer(builder: (_, ref, __) {
              // final authNotifier = ref.read(authProvider.notifier);
              return ValueListenableBuilder(
                  valueListenable: showButtonLoading,
                  builder: (context, value, _) {
                    return VWidgetsPrimaryButton(
                      showLoadingIndicator: value,
                      onPressed: () async {
                        if (newPasswordController.text !=
                            confirmPasswordController.text) {
                          VWidgetShowResponse.showToast(ResponseEnum.failed,
                              message:
                                  'Your new password do not match with confirm password');
                        } else {
                          // VLoader.changeLoadingState(true);
                          showButtonLoading.value = true;
                          // final token =
                          //     await VModelSharedPrefStorage().getString('token');

                          final success = await ref.read(passChangeProvider(
                                  PasswordChangeModel(
                                      oldPassword:
                                          currrentPasswordController.text,
                                      newPassword1: newPasswordController.text,
                                      newPassword2:
                                          confirmPasswordController.text))
                              .future);

                          if (success) {
                            VWidgetShowResponse.showToast(ResponseEnum.sucesss,
                                message: "Password changed successful");
                            currrentPasswordController.clear();
                            newPasswordController.clear();
                            confirmPasswordController.clear();
                          }

                          // await authNotifier.passwordChange(
                          //     token: token!,
                          //     oldPassword: currrentPasswordController.text,
                          //     newPassword1: newPasswordController.text,
                          //     newPassword2: confirmPasswordController.text);
                          showButtonLoading.value = false;
                          // VLoader.changeLoadingState(false);
                          // if (authNotifier.state.status == AuthStatus.authenticated) {
                          //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
                          //       message: 'Password changed successfully');
                          // } else {
                          //   VWidgetShowResponse.showToast(ResponseEnum.failed,
                          //       message: 'Invalid old password');
                          // }
                        }

                        // popSheet(context);
                      },
                      buttonTitle: "Done",
                      enableButton: true,
                    );
                  });
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
