import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../repository/password_change_repo.dart';

final passChangeProvider = FutureProvider.autoDispose
    .family<bool, PasswordChangeModel>((ref, args) async {
  var res = await PasswordChangeRepository.instance.passwordChange(
      oldPassword: args.oldPassword,
      newPassword1: args.newPassword1,
      newPassword2: args.newPassword2);
  return res.fold((left) {
    print('Failed to updage password ${left.message}');
    VWidgetShowResponse.showToast(ResponseEnum.failed,
        message: "Failed to update password");
    return false;
  }, (right) {
    final success = (right['success'] as bool?) ?? false;
    print('[aab] is success $success');
    if (!success) {
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Failed to update password");
      return success;
    }
    VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        message: "Password change successful");
    return success;
  });
});

class PasswordChangeModel {
  final String oldPassword;
  final String newPassword1;
  final String newPassword2;

  PasswordChangeModel({
    required this.oldPassword,
    required this.newPassword1,
    required this.newPassword2,
  });

  PasswordChangeModel copyWith({
    String? oldPassword,
    String? newPassword1,
    String? newPassword2,
  }) {
    return PasswordChangeModel(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword1: newPassword1 ?? this.newPassword1,
      newPassword2: newPassword2 ?? this.newPassword2,
    );
  }

  @override
  String toString() =>
      'PasswordChangeModel(oldPassword: $oldPassword, newPassword1: $newPassword1, newPassword2: $newPassword2)';

  @override
  bool operator ==(covariant PasswordChangeModel other) {
    if (identical(this, other)) return true;

    return other.oldPassword == oldPassword &&
        other.newPassword1 == newPassword1 &&
        other.newPassword2 == newPassword2;
  }

  @override
  int get hashCode =>
      oldPassword.hashCode ^ newPassword1.hashCode ^ newPassword2.hashCode;
}
