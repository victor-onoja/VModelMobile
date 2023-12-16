import 'package:vmodel/src/features/authentication/views/forgot_password_view.dart';
import 'package:vmodel/src/features/authentication/views/create_password_view.dart';
import 'package:vmodel/src/vmodel.dart';

class PasswordInteractor {
  static void onForgotPasswordClicked(BuildContext context) {
    navigateToRoute(context, ForgotPasswordView());
  }

  static void onCreatePassword(BuildContext context) {
    navigateToRoute(context, CreatePasswordView());
  }
}
