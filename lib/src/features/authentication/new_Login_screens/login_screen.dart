import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/authentication/new_Login_screens/new_user_onboarding.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

class OnBoardingPage extends StatelessWidget {
  static const name = "onboarding";
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/loginscreen.png',
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              addVerticalSpacing(350),
              Text(
                "WELCOME TO VMODEL",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: VmodelColors.white, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: VWidgetsPrimaryButton(
                  buttonColor: VmodelColors.white,
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    navigateToRoute(context, LoginPage());
                  },
                  buttonTitle: "Sign In",
                  buttonTitleTextStyle: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(
                          color: VmodelColors.primaryColor,
                          fontWeight: FontWeight.w600),
                  enableButton: true,
                ),
              ),
              addVerticalSpacing(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: VWidgetsPrimaryButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    navigateToRoute(context, const UserOnBoardingPage());
                  },
                  buttonTitle: "Sign Up",
                  enableButton: true,
                ),
              ),
              addVerticalSpacing(60),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: VmodelColors.white),
                    color: VmodelColors.white),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    'BETA',
                    style: TextStyle(color: VmodelColors.primaryColor),
                  ),
                ),
              ),
              addVerticalSpacing(20),
            ],
          ),
        ),
      ),
    );
  }
}
