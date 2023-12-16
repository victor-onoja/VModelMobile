import 'package:vmodel/src/features/authentication/views/new_login_screens/signup_view.dart';
import 'package:vmodel/src/vmodel.dart';

class LoginInteractor {
  static void onSignupClicked(BuildContext context) {
    navigateToRoute(context, const SignupView());
  }
}
