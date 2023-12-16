import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/settings/views/account_settings/repository/account_security_repo.dart';

final accountDeactivationProvider =
    StateNotifierProvider<AccountDeactivationNotifier, AsyncValue<bool>>(
        (ref) => AccountDeactivationNotifier());

class AccountDeactivationNotifier extends StateNotifier<AsyncValue<bool>> {
  late AccountSecurityRepository repository;
  AccountDeactivationNotifier() : super(const AsyncData(false)) {
    repository = AccountSecurityRepository.instance;
  }

  Future<void> deactivateAccount(String userPassword) async {
    state = const AsyncLoading();
    var res = await repository.deactivateAccount(password: userPassword);
    res.fold((left) {
      state = AsyncError(left.message, StackTrace.current);
      state = const AsyncData(false);
    }, (right) => state = AsyncData(right));
  }
}
