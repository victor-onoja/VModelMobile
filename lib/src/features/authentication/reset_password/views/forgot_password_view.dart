import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/reset_password/provider/reset_password_provider.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/login_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class ForgotPasswordView extends ConsumerStatefulWidget with VValidatorsMixin {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.watch(resetProvider);

    //
    final resetNotifier = ref.watch(resetProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: VmodelColors.background,
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        titleWidget: SizedBox.shrink(),
        elevation: 0,
        // iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.35),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    'Forgot Password',
                    // style: textFieldTitleTextStyle,
                    style: context.textTheme.displayMedium,
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                    child: VWidgetsLoginTextField(
                      hintText: "Ex. email@example.com",
                      onChanged: (val) {
                        val.isEmail;
                        resetNotifier.changeButtonState();
                      },
                      validator: (value) =>
                          VValidatorsMixin.isEmailValid(value?.trim()),
                      controller: resetNotifier.forgetController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                    ),
                  ),
                  Visibility(
                    visible: resetNotifier.getProviderState.makeMessageVisible!,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.036,
                          left: SizeConfig.screenWidth * 0.086,
                          right: SizeConfig.screenWidth * 0.086),
                      child: Center(
                        child: Text(
                          'If you created an account with us, we’ll send you an email containing a link to reset your password.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: VmodelColors.hintColor.withOpacity(0.5),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            VWidgetsPrimaryButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                resetNotifier.forgetPasswordFunction(context);
              },
              buttonTitle: resetNotifier.getProviderState.enableButton == true
                  ? 'Confirm Email'
                  : 'Continue',
              buttonTitleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: VModelTypography1.primaryfontName),
              enableButton:
                  resetNotifier.getProviderState.enableButton ?? false,
              buttonHeight: SizeConfig.screenHeight * 0.05,
              butttonWidth: SizeConfig.screenWidth * 0.87,
            ),
            addVerticalSpacing(SizeConfig.screenHeight * 0.07),
          ],
        ),
      ),
    );
  }
}
