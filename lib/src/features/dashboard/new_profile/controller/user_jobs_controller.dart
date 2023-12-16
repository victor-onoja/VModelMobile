import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../jobs/job_market/model/job_post_model.dart';
import '../../../jobs/job_market/repository/jobs_repo.dart';
import '../repository/user_job_repo.dart';

final hasJobsProvider =
    Provider.autoDispose.family<bool, String?>((ref, username) {
  final jobs = ref.watch(userJobsProvider(username)).valueOrNull ?? [];
  return jobs.isNotEmpty;
});

final userJobsProvider = AsyncNotifierProvider.autoDispose
    .family<UserJobsNotifier, List<JobPostModel>, String?>(
        UserJobsNotifier.new);

class UserJobsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<JobPostModel>, String?> {
  final UserJobsRepository _repository = UserJobsRepository.instance;

  int _pgCount = 15;

  @override
  Future<List<JobPostModel>> build(arg) async {
    print('[dd] getting jobs for $arg');
    final isCurrentUser = arg == null;
    final res =
        //  isCurrentUser
        //     ?
        await JobsRepository.instance
            .getJobs(myJobs: isCurrentUser, username: arg, pageCount: _pgCount);
    // : await _repository.getUserJobs(arg);

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      // print('in AsyncBuild rieght is .............. $res');
      // final jobsCount = right['jobsTotalNumber'];
      // final List jobsData = right[isCurrentUser ? 'jobs' : 'jobSet'];
      final List jobsData = right['jobs'];

      if (jobsData.isNotEmpty) {
        print(jobsData);

        final List<JobPostModel> activeJobs = [];
        for (Map<String, dynamic> item in jobsData) {
          final isDeleted = item['deleted'] ?? false;
          if (isDeleted) continue;
          activeJobs.add(JobPostModel.fromMap(item));
        }
        return activeJobs;
        // final rsss = jobsData.map<JobPostModel>((e) {
        //   return JobPostModel.fromMap(e as Map<String, dynamic>);
        // }).toList();
      }
      return [];
    });
  }

  Future<bool> deleteJob(String? jobId) async {
    final List<JobPostModel>? currentState = state.value;
    // print('[pd] The id to delete is $packageId');
    if (jobId == null) return false;

    final makeRequest = await _repository.deleteJob(jobId: int.parse(jobId));

    return makeRequest.fold((onLeft) {
      print('Failed to delete job ${onLeft.message}');
      return false;
      // run this block when you have an error
    }, (onRight) async {
      final success = onRight['success'] ?? false;
      if (success) {
        state = AsyncValue.data([
          for (final job in currentState!)
            if (job.id != jobId) job,
        ]);
      }

      // print('[pd] $onRight');
      print('successfully deleted job');
      return success;
      // if the success field in the mutation response is true
    });
  }
}
