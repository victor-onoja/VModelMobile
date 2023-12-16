import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/authentication/register/provider/signup_controller.dart';
import 'package:vmodel/src/features/authentication/register/provider/signup_interactor.dart';
import 'package:vmodel/src/features/authentication/register/views/location_set_up.dart';
import 'package:vmodel/src/features/authentication/register/views/sign_up.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../app_locator.dart';
import '../../../../core/utils/enum/account_types_enum.dart';
import '../../../../shared/loader/full_screen_dialog_loader.dart';
import '../../../../shared/text_fields/primary_text_field.dart';
import '../repository/register_repo.dart';

// enum GeneralUserAccountType { business, talent }

// final selectedGeneralUserAccountTypeProvider =
//     StateProvider<GeneralUserAccountType>(
//         (ref) => GeneralUserAccountType.talent);

class SignUpSelectUserTypeViewNew extends ConsumerStatefulWidget {
  const SignUpSelectUserTypeViewNew({Key? key, this.isBusinessAccount = false})
      : super(key: key);
  final bool isBusinessAccount;

  @override
  ConsumerState<SignUpSelectUserTypeViewNew> createState() =>
      _SignUpSelectUserTypeViewNewState();
}

class _SignUpSelectUserTypeViewNewState
    extends ConsumerState<SignUpSelectUserTypeViewNew> {
  bool isSelected = false;
  final TextEditingController inputController = TextEditingController();

  // final List userAccountTypes = const [
  //   'Model',
  //   'Influencer',
  //   'Digital creator',
  //   'Hair Stylist',
  //   'Make up Stylist',
  //   'Beautician',
  //   'DJ',
  //   'Other Please specify',
  // ];
  // final List businessAccountTypes = const [
  //   'Businesses',
  //   'Creative director',
  //   'Producer',
  //   'Other Please specify ',
  // ];

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignupController());
    // final selectedGeneralUserAccountTypeState =
    //     ref.watch(selectedGeneralUserAccountTypeProvider);

    return Scaffold(
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: VWidgetsBackButton(onTap: () {
          signUpController.resetSelectedIndustry();
          goBack(context);
        }),
        backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addVerticalSpacing(40),
            Center(
                child: Text(
              'Please specify account type',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
            )),
            addVerticalSpacing(20),
            Container(
              // height: 50.h,
              constraints: BoxConstraints(minHeight: 10.h, maxHeight: 47.h),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: VmodelColors.borderColor),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.isBusinessAccount
                    ? BusinessAccountType.values.length
                    : TalentAccountType.values.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    indent: 15,
                    endIndent: 15,
                  );
                },
                itemBuilder: (context, index) {
                  if (widget.isBusinessAccount) {
                    return typeWidget(
                        BusinessAccountType.values[index].displayName);
                  }
                  return typeWidget(
                      TalentAccountType.values[index].displayName);
                },
                // children: userAccountTypes
                //     .map((e) => e == ""
                //         ? const Divider(
                //             indent: 15,
                //             endIndent: 15,
                //           )
                //         : typeWidget(e))
                //     .toList(),
              ),
            ),
            addVerticalSpacing(20),
            AnimatedContainer(
              // padding: const EdgeInsets.all(16.0),
              height: signUpController.selectedIndustry.contains('Other')
                  ? 12.h
                  : 0,
              // scale:
              //     signUpController.selectedIndustry.contains('Other') ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
                child: VWidgetsPrimaryTextFieldWithTitle(
                  controller: inputController,
                  // isIncreaseHeightForErrorText: true,
                  // heightForErrorText:
                  // signUpController.selectedIndustry.contains('Other') ? 10.h : 0,
                  label: "Please specify",
                  hintText: widget.isBusinessAccount
                      ? 'Ex. Creative Agency'
                      : "Ex. Voice Actor",
                ),
              ),
            ),
            addVerticalSpacing(20),
            Padding(
              padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              child: VWidgetsPrimaryButton(
                onPressed: () async { HapticFeedback.lightImpact();
                  // print('XXXXXXXXXXXXXXx ${signUpController.selectedIndustry}');
                  signUpController.isBusinessAccount = widget.isBusinessAccount;
                  VLoader.changeLoadingState(true);
                  await registerRepoInstance.updateAccountType(
                    userIDPk!,
                    widget.isBusinessAccount,
                    signUpController.isUserSpecifiedType
                        ? inputController.text.trim()
                        : signUpController.selectedIndustry.value,
                  );
                  VLoader.changeLoadingState(false);
                  if (context.mounted) {
                    navigateToRoute(
                      context,
                      const SignUpLocationViews(),
                    );
                  }
                },
                buttonTitle: 'Continue',
                enableButton: isSelected,
              ),
            ),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }

  Widget typeWidget(String type) {
    var fontWeight = FontWeight.w500;
    var opacity = 0.5;
    if (type != "\"Just a normal user\"") {
      SignupController controller = Get.find();
      if (controller.selectedIndustry.value == type) {
        fontWeight = FontWeight.w600;
        opacity = 1;
      }

      return GestureDetector(
        onTap: () {
          setState(() {
            isSelected = true;
            signUpUserType = controller.isUserSpecifiedType
                ? inputController.text.trim()
                : type;
          });

          SignupInteractor.onIndustrySelected(type);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            alignment: Alignment.centerLeft,
            width: double.maxFinite,
            color: Colors.transparent,
            child: Text(
              type,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: fontWeight,
                  color: VmodelColors.hintColor.withOpacity(opacity)),
              //style: customWidthOpacityText(opacity, fontWeight),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.maxFinite,
          color: Colors.transparent,
          child: Text(
            type,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: VmodelColors.hintColor.withOpacity(opacity)),
            //style: customWidthOpacityText(opacity, FontWeight.w500),
          ),
        ),
      );
    }
  }
}
