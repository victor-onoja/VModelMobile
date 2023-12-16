import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/2fa_repo.dart';

final twoStepVerificationProvider =
    AsyncNotifierProvider.autoDispose<TwoStepVerificationNotifier, bool?>(
        TwoStepVerificationNotifier.new);

class TwoStepVerificationNotifier extends AutoDisposeAsyncNotifier<bool?> {
  // TwoStepVerificationNotifier() : super();
  TwoStepVerificationRepository? _repository;

  @override
  Future<bool?> build() async {
    _repository = TwoStepVerificationRepository.instance;

    // print("8888888888888 calling build with username $arg");
    // state = const AsyncLoading();
    final response = await _repository!.getTwoStepVerificationStatus();
    bool? initialState;
    response.fold((left) {
      print(
          "8888888888888 () error in build ${left.message} ${StackTrace.current}");
      // return AsyncError(left.message, StackTrace.current);
    }, (right) {
      print("[2fa] +++++++\n ${right} \n");
      try {
        final newState = right['use2fa'] ?? false;

        initialState = newState;
        print("[2fa] +++++++\n ${newState} \n");
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
    });

    return initialState;
  }

  Future<void> update2FA({
    required bool use2FA,
  }) async {
    // final data = state.value!;
    try {
      final response = await _repository!.updateProfile(
        use2fa: use2FA,
      );

      response.fold((left) {
        return null;
      }, (right) async {
        print('[jji] =================>>>>>>>>>>>>>>============= $right');
        print('[crd] Auth token new is ${right["token"]}');
        final isUse2FA = right['use2fa'] ?? false;
        // final temp = state.value?.copyWith(username: user['username']);
        state = AsyncData(isUse2FA);

        // if (username != null) {
        // await ref
        //     .read(authenticationStatusProvider.notifier)
        //     .updateCredentials(authToken: right['token']);
        // }
        return null;
      });
    } catch (e) {
      print(
          '******************************************* $e \n ${StackTrace.current}');
    }
  }
}
