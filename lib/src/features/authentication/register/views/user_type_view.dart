import 'package:flutter/services.dart';
import 'package:vmodel/src/features/authentication/register/provider/signup_controller.dart';
import 'package:vmodel/src/features/authentication/register/provider/signup_interactor.dart';
import 'package:vmodel/src/features/authentication/register/views/location_set_up.dart';
import 'package:vmodel/src/features/authentication/register/views/sign_up.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class SignUpSelectUserTypeView extends StatefulWidget {
  const SignUpSelectUserTypeView({Key? key}) : super(key: key);

  @override
  State<SignUpSelectUserTypeView> createState() =>
      _SignUpSelectUserTypeViewState();
}

class _SignUpSelectUserTypeViewState extends State<SignUpSelectUserTypeView> {
  bool isSelected = false;
  final List userTypes = const [
    "Model, Creator, Virtual Model",
    "",
    "Creative Director, Producer",
    "",
    "Business",
    "",
    "Booker",
    "",
    "Pet Models",
    ""
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());

    return Scaffold(
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addVerticalSpacing(40),
                Center(
                    child: Text(
                  'Select a user type',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                )),
                addVerticalSpacing(20),
                Center(
                  child: GetX<SignupController>(
                      init: SignupController(),
                      builder: (controller) {
                        return SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            padding: const EdgeInsets.only(top: 15, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: VmodelColors.borderColor),
                            ),
                            child: Column(
                              children: userTypes
                                  .map((e) => e == ""
                                      ? const Divider(
                                          indent: 15,
                                          endIndent: 15,
                                        )
                                      : typeWidget(e))
                                  .toList(),
                            ),
                          ),
                        );
                      }),
                ),

                // addVerticalSpacing(SizeConfig.screenHeight * 0.07),
              ],
            ),
          ),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: VWidgetsPrimaryButton(
              onPressed: () { HapticFeedback.lightImpact();
                navigateToRoute(context, const SignUpLocationViews());
              },
              buttonTitle: 'Continue',
              enableButton: isSelected,
            ),
          ),
          addVerticalSpacing(40),
        ],
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
            signUpUserType = type;
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
