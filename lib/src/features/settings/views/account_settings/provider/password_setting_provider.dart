import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

final passwordSettingProvider =
    StateNotifierProvider<PasswordSettingNotifier, PasswordSettingStateModel>(
        (ref) {
  return PasswordSettingNotifier();
});

class PasswordSettingNotifier extends StateNotifier<PasswordSettingStateModel>
    with VValidatorsMixin {
  PasswordSettingNotifier()
      : super(PasswordSettingStateModel(
            oldPasswordObscure: true,
            newPasswordObscure: true,
            confirmPasswordObscure: true,
            validateOldPassword: '',
            validateNewPassword: '',
            validateConfirmPassword: ''));
  PasswordSettingStateModel get getState => state;

  toggleOldPasswordObscure() {
    state = state.copyWith(
      oldPasswordObscure: !state.oldPasswordObscure,
    );
  }

  toggleNewPasswordObscure() {
    state = state.copyWith(
      newPasswordObscure: !state.newPasswordObscure,
    );
  }

  toggleConfirmPasswordObscure() {
    state = state.copyWith(
      confirmPasswordObscure: !state.confirmPasswordObscure,
    );
  }

  RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  bool isValid(String password) {
    return passwordValidator.hasMatch(password);
  }

  checkNewPasswordIsValid(String newPassword) {
    String? validatorResult(){
      if(newPassword.isEmpty){
       return 'Password is empty';
      } else if(!isValid(newPassword)){
        return 'Password should contain Capital, small letter & Number & Special';
      } else {
        return '' ;
      }
             
    }
    state = state.copyWith(
        validateNewPassword: validatorResult());
  }
}

class PasswordSettingStateModel {
  bool oldPasswordObscure;
  bool newPasswordObscure;
  bool confirmPasswordObscure;
  String? validateOldPassword;
  String? validateNewPassword;
  String? validateConfirmPassword;

  PasswordSettingStateModel(
      {required this.oldPasswordObscure,
      required this.newPasswordObscure,
      required this.confirmPasswordObscure,
      required this.validateOldPassword,
      required this.validateNewPassword,
      required this.validateConfirmPassword});

  PasswordSettingStateModel copyWith({
    bool? oldPasswordObscure,
    bool? newPasswordObscure,
    bool? confirmPasswordObscure,
    String? validateOldPassword,
    String? validateNewPassword,
    String? validateConfirmPassword,
  }) {
    return PasswordSettingStateModel(
      oldPasswordObscure: oldPasswordObscure ?? this.oldPasswordObscure,
      newPasswordObscure: newPasswordObscure ?? this.newPasswordObscure,
      confirmPasswordObscure:
          confirmPasswordObscure ?? this.confirmPasswordObscure,
      validateOldPassword: validateOldPassword ?? this.validateOldPassword,
      validateNewPassword: validateNewPassword ?? this.validateNewPassword,
      validateConfirmPassword:
          validateConfirmPassword ?? this.validateConfirmPassword,
    );
  }
}
