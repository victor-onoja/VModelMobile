import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/reset_password/repository/reset_repository.dart';
import 'package:vmodel/src/features/authentication/reset_password/views/reset_password_otp.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

final resetProvider = StateNotifierProvider((ref) => ResetProvider(ref));

class ResetProvider extends StateNotifier<ResetModel> {
  ResetProvider(this.ref) : super(ResetModel());

  final Ref ref;

  ResetModel get getProviderState => state;
  TextEditingController forgetController = TextEditingController();
  TextEditingController otPController = TextEditingController();
  String? resetToken;

  changeButtonState() {
    bool isEmail =
        VValidatorsMixin.isEmailValid(forgetController.text.trim()) == null
            ? true
            : false;

    state = state.copyWith(
      enableButton: isEmail,
    );
  }

  //
  forgetPasswordFunction(BuildContext context) async {
    dismissKeyboard();

    // navigateToRoute(context, ResetVerificationCodePage());
    // return;

    //               if (_formKey.currentState!.validate() == false) {
    //                 Fluttertoast.showToast(
    //                     msg: "Please fill all the fields",
    //                     gravity: ToastGravity.TOP,
    //                     timeInSecForIosWeb: 1,
    //                     backgroundColor: VmodelColors.error.withOpacity(0.6),
    //                     textColor: Colors.white,
    //                     fontSize: 16.0);
    //               } else {
    //                 _formKey.currentState?.save();
    //                 progress?.show();
    //                 final authNotifier = ref.read(authProvider.notifier);
    //                 await authNotifier.resetLink(controller.text.trim());
    //                 if (authNotifier.state.status ==
    //                     AuthStatus.authenticated) {
    //                   progress?.dismiss();
    //                   if (mounted) {

    //                   }
    //                 } else {
    //                   progress?.dismiss();
    //                   Fluttertoast.showToast(
    //                       msg: "Email account not found",
    //                       gravity: ToastGravity.TOP,
    //                       timeInSecForIosWeb: 1,
    //                       backgroundColor:
    //                           VmodelColors.black.withOpacity(0.6),
    //                       textColor: Colors.white,
    //                       fontSize: 16.0);
    //                 }
    //               }
    VLoader.changeLoadingState(true);
    final makeForgetPasswordRequest =
        await resetRepoInstance.resestPassword(forgetController.text);

    makeForgetPasswordRequest.fold((onLeft) {
      VLoader.changeLoadingState(false);
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: onLeft.message.toString());
    }, (onRight) {
      print('[wow] $onRight');
      VLoader.changeLoadingState(false);
      // if (onRight['sendPasswordResetEmail']['errors']['errors'] == null) {
      //   resetToken = onRight['sendPasswordResetEmail']['errors']['token'];
      //   navigateToRoute(
      //       context,
      //       ResetVerificationCodePage(
      //           otp: onRight['sendPasswordResetEmail']['errors']['otp'],
      //           link: ""));
      //   // navigateToRoute(context, CreatePasswordView(link: _graphQLService.link));
      // } else {
      //   VWidgetShowResponse.showToast(ResponseEnum.failed,
      //       message: "Please input a valid email");
      // }
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: onRight["message"]);

      navigateToRoute(
          context,
          ResetVerificationCodePage(
              // otp: onRight['sendPasswordResetEmail']['errors']['otp'],
              // link: "",
              ));
    });
  }

  Future<bool> resetOldPassword(
    BuildContext context, {
    required String otpCode,
    required String newPassword1,
    // required String newPassword2,
  }) async {
    dismissKeyboard();
    VLoader.changeLoadingState(true);

    final String userEmail =
        ref.read(resetProvider.notifier).forgetController.text.trim();

    print('[wow] reset old password token is --- $resetToken');
    final makeForgetPasswordRequest = await resetRepoInstance.resetUserPassword(
      email: userEmail,
      otpCode: otpCode,
      newPassword1: newPassword1,
      // newPassword2: newPassword2,
    );

    return makeForgetPasswordRequest.fold((onLeft) {
      VLoader.changeLoadingState(false);
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: onLeft.message.toString());
      return false;
    }, (onRight) {
      print('[wwq] reset old password right--- $onRight');
      VLoader.changeLoadingState(false);

      final String token = onRight['token'] ?? '';
      // return true;
      if (!token.isEmptyOrNull) {
        // navigateToRoute(
        //     context,
        //     ResetVerificationCodePage(
        //         otp: onRight['sendPasswordResetEmail']['errors']['otp'],
        //         link: ""));
        // navigateToRoute(context, CreatePasswordView(link: _graphQLService.link));
        // return onRight['success'];
        VWidgetShowResponse.showToast(ResponseEnum.sucesss,
            message: "${onRight['message']}");
        return true;
      } else {
        VWidgetShowResponse.showToast(ResponseEnum.warning,
            message: "${onRight['message']}");
        return false;
      }
    });
  }
}

class ResetModel {
  bool? enableButton;
  bool? makeMessageVisible;
  String? otp;
  ResetModel(
      {this.enableButton = false, this.makeMessageVisible = false, this.otp});

  ResetModel copyWith(
      {bool? enableButton, bool? makeMessageVisible, String? otp}) {
    return ResetModel(
        enableButton: enableButton ?? this.enableButton,
        makeMessageVisible: makeMessageVisible ?? this.makeMessageVisible,
        otp: otp ?? this.otp);
  }
}
