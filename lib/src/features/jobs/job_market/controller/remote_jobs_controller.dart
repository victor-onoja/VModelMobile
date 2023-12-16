import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/job_post_model.dart';
import '../repository/jobs_repo.dart';

final remoteJobsProvider =
    AsyncNotifierProvider<RemoteJobsController, List<JobPostModel>>(
        () => RemoteJobsController());

class RemoteJobsController extends AsyncNotifier<List<JobPostModel>> {
  final _repository = JobsRepository.instance;
  // List<JobPostModel> popularJobs = [];
  final _pageCount = 5;

  @override
  Future<List<JobPostModel>> build() async {
    final res = await _repository.getJobs(remote: 'yes', pageCount: _pageCount);

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      // print('in AsyncBuild rieght is .............. $res');
      // final jobsCount = right['jobsTotalNumber'];
      final List jobsData = right['jobs'];

      if (jobsData.isNotEmpty) {
        print(jobsData);
        return jobsData
            .map<JobPostModel>(
                (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }
}
