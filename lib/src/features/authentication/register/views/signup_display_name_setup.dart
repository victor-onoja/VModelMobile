import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/authentication/register/provider/register_provider.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../provider/user_types_controller.dart';
import 'signup_bio_setup.dart';

class SignUpDisplayNameSetup extends ConsumerStatefulWidget {
  const SignUpDisplayNameSetup({super.key});

  @override
  ConsumerState<SignUpDisplayNameSetup> createState() =>
      _SignUpDisplayNameSetupState();
}

class _SignUpDisplayNameSetupState
    extends ConsumerState<SignUpDisplayNameSetup> {
  final TextEditingController textController = TextEditingController();
  final isShowButtonLoading = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(registerProvider);
    final isBusinessAccount = ref.watch(isAccountTypeBusinessProvider);

    final _formKey = GlobalKey<FormState>();
    // String? websiteUrl;

    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "",
        elevation: 0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addVerticalSpacing(150),
                Text(
                  // isBusinessAccount
                  //     ? "What's your business name?"
                  // :
                  "What's your preferred display name?",
                  // style: VModelTypography1.promptTextStyle
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                addVerticalSpacing(28),
                VWidgetsTextFieldNormal(
                  controller: textController,
                  // maxLines: 1,
                  hintText:
                      isBusinessAccount ? 'Eg: Fashion House' : 'Bella Perfect',

                  // onSaved: (p0) {},
                  onChanged: (p0) {},
                  // onFieldSubmitted: (p0) {},
                  // validator: VValidatorsMixin.isURLValid,
                ),
                const Spacer(),
                SizedBox(
                  width: 120,
                  child: ValueListenableBuilder(
                    valueListenable: isShowButtonLoading,
                    builder: ((context, value, child) {
                      return Padding(
                        padding:
                            const VWidgetsPagePadding.horizontalSymmetric(0),
                        child: VWidgetsPrimaryButton(
                          showLoadingIndicator: value,
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            // VLoader.changeLoadingState(true);
                            if (!_formKey.currentState!.validate()) {
                              // VWidgetShowResponse.showToast(ResponseEnum.warning, message: "")
                              return;
                            }
                            isShowButtonLoading.value = true;

                            await ref
                                .read(appUserProvider.notifier)
                                .updateProfile(
                                    displayName: textController.text.trim());
                            // VLoader.changeLoadingState(false);
                            isShowButtonLoading.value = false;

                            if (context.mounted) {
                              navigateToRoute(context, const SignUpBioSetup());
                              // navigateToRoute(
                              //   context,
                              //   // signUpUserType == "Business"
                              //   Get.find<SignupController>().isBusinessAccount
                              //       ? const SignUpUploadPhotoPage()
                              //       : const SignUpPriceViews());
                            }
                          },
                          buttonTitle: 'Continue',
                        ),
                      );
                    }),
                  ),
                ),
                // vWidgetsInitialButton(
                //   () async {
                //     VLoader.changeLoadingState(true);
                //     await registerRepoInstance.updateWebsite(userIDPk!,
                //         notifierR.websiteController.text, signUpUserType);
                //     VLoader.changeLoadingState(false);

                //     if (context.mounted) {
                //       navigateToRoute(context, const DashBoardView());
                //       // navigateToRoute(
                //       //   context,
                //       //   // signUpUserType == "Business"
                //       //   Get.find<SignupController>().isBusinessAccount
                //       //       ? const SignUpUploadPhotoPage()
                //       //       : const SignUpPriceViews());
                //     }
                //   },
                //   'Continue',
                // ),
                addVerticalSpacing(15),
                TextButton(
                  onPressed: () {
                    navigateToRoute(context, const SignUpBioSetup());
                  },
                  child: const Text("Skip"),
                ),
                addVerticalSpacing(20),
              ]),
        ),
      ),
    );
  }
}
