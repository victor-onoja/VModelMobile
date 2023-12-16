import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/register/provider/register_provider.dart';
import 'package:vmodel/src/features/authentication/register/repository/register_repo.dart';
import 'package:vmodel/src/features/authentication/register/views/sign_up.dart';
import 'package:vmodel/src/features/authentication/register/views/upload_photo_page.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/text_fields/initial_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class SignUpPriceViews extends ConsumerWidget {
  const SignUpPriceViews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registerProvider);

    final notifierR = ref.watch(registerProvider.notifier);

    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "",
        elevation: 0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addVerticalSpacing(150),
                Text(
                  'How much will you charge per hour? ',
                  style: VModelTypography1.promptTextStyle
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                addVerticalSpacing(8),
                addVerticalSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "£",
                      style: VModelTypography1.promptTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 35.sp,
                          color: VModelTypography1.promptTextStyle.color!
                              .withOpacity(0.5)),
                    ),
                    addHorizontalSpacing(10),
                    SizedBox(
                      height: 60,
                      width: 100,
                      child: VWidgetsTextFieldWithoutTitle(
                        controller: notifierR.priceController,
                        keyboardType: TextInputType.number,
                        // maxLines: 1,
                        hintText: 'Eg: 100',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) =>
                            VValidatorsMixin.isValidServicePrice(value,
                                field: 'Price'),
                        onSaved: (p0) {},
                        onChanged: (p0) {},
                        onFieldSubmitted: (p0) {},
                      ),
                    ),
                  ],
                ),
                addVerticalSpacing(8),
                Text(
                  'Don’t worry, you can change this later in settings',
                  style: VModelTypography1.promptTextStyle
                      .copyWith(fontWeight: FontWeight.w300, fontSize: 10.sp),
                ),
                const Spacer(),
                vWidgetsInitialButton(
                  () async {
                    HapticFeedback.lightImpact();
                    VLoader.changeLoadingState(true);
                    await registerRepoInstance.updatePrice(
                        globalUsername!,
                        double.parse(notifierR.priceController.text),
                        signUpUserType);
                    VLoader.changeLoadingState(false);

                    navigateToRoute(context, const SignUpUploadPhotoPage());
                  },
                  'Continue',
                ),
              ]),
        ),
      ),
    );
  }
}
