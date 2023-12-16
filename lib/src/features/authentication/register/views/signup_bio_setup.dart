import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/utils/costants.dart';
import '../../../../core/utils/validators_mixins.dart';
import '../../../../res/res.dart';
import '../../../../shared/appbar/appbar.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../../../shared/text_fields/description_text_field.dart';
import '../../../../vmodel.dart';
import '../provider/user_types_controller.dart';
import 'upload_photo_page.dart';

class SignUpBioSetup extends ConsumerStatefulWidget {
  const SignUpBioSetup({super.key});

  @override
  ConsumerState<SignUpBioSetup> createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends ConsumerState<SignUpBioSetup> {
  final TextEditingController textController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  bool _enableButton = false;
  final isShowButtonIndicator = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBusinessAccount = ref.watch(isAccountTypeBusinessProvider);
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: //isBusinessAccount ? "Business Description" :
            "Bio",
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(0),
            Expanded(
                child: SingleChildScrollView(
              child: Form(
                key: _formState,
                child: Column(
                  children: [
                    // widget.purpose == '_bio'
                    VWidgetsDescriptionTextFieldWithTitle(
                      // controller: widget.bio,
                      controller: textController,
                      // label: widget.title,
                      // helperText: 'Maximum of 2000 characters',
                      hintText: isBusinessAccount
                          ? "Tell us a bit about your business..."
                          : "Tell us a bit about yourself...",
                      maxLength: VConstants.maxBioLength,
                      showCounter: true,
                      maxLines: 10,
                      onChanged: (value) {
                        //Todo find better way of enbling button
                        final validation =
                            VValidatorsMixin.isNotEmpty(value, field: 'bio');

                        _enableButton = validation == null ? true : false;
                        setState(() {});
                      },
                      validator: (String? value) {
                        final fieldName = isBusinessAccount
                            ? "Business Description"
                            : "A little about you";
                        final validation = VValidatorsMixin.isNotEmpty(value,
                            field: fieldName);

                        return validation;
                      },
                      labelStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor),
                      // controller: ,
                    )
                    // : widget.purpose != '_username'
                  ],
                ),
              ),
            )),
            addVerticalSpacing(12),
            ValueListenableBuilder(
              valueListenable: isShowButtonIndicator,
              builder: ((context, value, child) {
                return VWidgetsPrimaryButton(
                  buttonTitle: "Continue",
                  showLoadingIndicator: value,
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    dismissKeyboard();
                    if (!_formState.currentState!.validate()) {
                      return;
                    }
                    // VLoader.changeLoadingState(true);
                    isShowButtonIndicator.value = true;
                    await ref
                        .read(appUserProvider.notifier)
                        .updateProfile(bio: textController.text.trim());
                    // VLoader.changeLoadingState(false);
                    isShowButtonIndicator.value = false;

                    if (mounted) {
                      navigateToRoute(
                          context,
                          // isBusinessAccount
                          // ? SignUpWebSiteView()
                          // //: const SignUpPriceViews());
                          // :
                          const SignUpUploadPhotoPage());
                    }
                    // if (context.mounted) {
                    //   navigateToRoute(context, const DashBoardView());
                    // }
                  },
                  enableButton: _enableButton,
                );
              }),
            ),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
