import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/repository/jobs_repo.dart';

final similarJobsProvider = AsyncNotifierProvider.autoDispose
    .family<SimilarJobController, List<JobPostModel>, int>(
        () => SimilarJobController());

class SimilarJobController
    extends AutoDisposeFamilyAsyncNotifier<List<JobPostModel>, int> {
  final _repository = JobsRepository.instance;
  @override
  FutureOr<List<JobPostModel>> build(int jobId) async {
    final res = await _repository.getSimilarJobs(jobId: jobId);
    // print('resssssssssssssssssssssssss');

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      print("bhcjwbes $right");
      if (right.isNotEmpty) {
        print(right);
        return right
            .map<JobPostModel>(
                (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }
}
