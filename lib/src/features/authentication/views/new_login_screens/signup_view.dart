import 'package:flutter/services.dart';
import 'package:vmodel/src/features/authentication/controller/signup_controller.dart';
import 'package:vmodel/src/features/authentication/controller/signup_interactor.dart';
import 'package:vmodel/src/features/onboarding/views/onboarding_photo_page.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/res/res.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isSelected = false;
  final List userTypes = const [
    "Virtual Model/ Influencer",
    "",
    "Model/ Digital Creator",
    "",
    "Photographer",
    "",
    "Business",
    "",
    "Just a normal user",
    "",
    "Beautician",
    "",
    "Pet Model"
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
                // SignupInteractor.onContinueClicked(context);
                //navigateToRoute(context, const PhoneVerificationPage());
                navigateToRoute(context, const OnboardingPhotoPage());
              },
              buttonTitle: 'Continue',
              // buttonTitleTextStyle: const TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.w500,
              //     fontSize: 16,
              //     fontFamily: VModelTypography1.primaryfontName),
              enableButton: isSelected,
              // buttonHeight: SizeConfig.screenHeight * 0.05,
              // butttonWidth: SizeConfig.screenWidth * 0.87,
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
    if (type != "Pet Model" && type != "\"Just a normal user\"") {
      SignupController controller = Get.find();
      if (controller.selectedIndustry.value == type) {
        fontWeight = FontWeight.w600;
        opacity = 1;
      }

      return GestureDetector(
        onTap: () {
          setState(() {
            isSelected = true;
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
