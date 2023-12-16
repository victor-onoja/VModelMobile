import 'package:get/get.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/authentication/register/provider/signup_controller.dart';
import 'package:vmodel/src/features/onboarding/views/email_view.dart';

class SignupInteractor {
  static void onIndustrySelected(String type) {
    var controller = Get.find<SignupController>();
    controller.selectedIndustry(type);
  }

  static void onContinueClicked(context) {
    var controller = Get.find<SignupController>();
    navigateToRoute(
        context,
        OnboardingEmail(
          selectedIndustry: controller.selectedIndustry.string,
        ));
  }
}
