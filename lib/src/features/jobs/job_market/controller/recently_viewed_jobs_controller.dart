import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/repository/jobs_repo.dart';

final recentlyViewedJobsProvider = AsyncNotifierProvider.autoDispose<
    RecenltyViewedJobsController,
    List<JobPostModel>>(() => RecenltyViewedJobsController());

class RecenltyViewedJobsController
    extends AutoDisposeAsyncNotifier<List<JobPostModel>> {
  final _repository = JobsRepository.instance;
  @override
  FutureOr<List<JobPostModel>> build() async {
    final res = await _repository.getRecentlyViewedJobs();
    // print('resssssssssssssssssssssssss');

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      // final List jobsData = right['jobs'];

      if (right.isNotEmpty) {
        print(right);
        return right
            .map<JobPostModel>(
                (e) => JobPostModel.fromMap(e['job'] as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }
}
