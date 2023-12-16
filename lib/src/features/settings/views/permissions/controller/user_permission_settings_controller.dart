import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/user_permissions.dart';
import '../../../../../core/repository/app_user_repository.dart';
import '../repository/user_permission_settings_repo.dart';
import '../../../../../core/utils/enum/permission_enum.dart';
import '../../../../../core/controller/app_user_controller.dart';

final userPermissionsProvider = AsyncNotifierProvider.autoDispose
    .family<UserPermissionsNotifier, UserPermissionsSettings?, String?>(
        () => UserPermissionsNotifier());

class UserPermissionsNotifier
    extends AutoDisposeFamilyAsyncNotifier<UserPermissionsSettings?, String?> {
  // UserPermissionsNotifier() : super();
  final _repository = UserPermissionsRepository.instance;
  final _userRepository = AppUserRepository.instance;

  @override
  Future<UserPermissionsSettings?> build(arg) async {
    return null;
  }

  Future<void> updateUserPermissionSettings({
    required UserPermissionsSettings settings,
  }) async {
    final userProfile = await _repository.updatePermission(
      whoCanViewMyNetwork: settings.whoCanViewMyNetwork.name,
      whoCanMessageMe: settings.whoCanMessageMe.name,
      whoCanFeatureMe: settings.whoCanFeatureMe.name,
      whoCanConnectMe: settings.whoCanConnectWithMe.name,
    );
    // UserPermissionsSettings initialState;
    userProfile.fold((left) {
      // return AsyncError(left.message, StackTrace.current);
      print("left ${left.message}");
    }, (right) {
      print("response ${right}");
      ref.invalidate(appUserProvider);
    });
  }
}
