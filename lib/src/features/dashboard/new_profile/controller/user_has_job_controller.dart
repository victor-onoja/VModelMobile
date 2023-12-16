import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../jobs/job_market/repository/jobs_repo.dart';

final userHasJobProvider = AsyncNotifierProvider.autoDispose
    .family<UserHasJobNotifier, bool, String>(UserHasJobNotifier.new);

class UserHasJobNotifier extends AutoDisposeFamilyAsyncNotifier<bool, String> {
  @override
  Future<bool> build(arg) async {
    final res = await JobsRepository.instance.userHasJob(username: arg);
    return res.fold((left) {
      print("[zz] Error checking if user ($arg) has jobs ${left.message}");
// VWidgetShowResponse.returnStringBasedOnResponse(responseEnum)
      return false;
    }, (right) {
      final hasJob = right['createdJob'] ?? false;
      print("[zz] user ($arg) has jobs $hasJob");
      return hasJob;
    });
    return false;
  }
}
