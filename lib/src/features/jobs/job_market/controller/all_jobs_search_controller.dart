import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/job_post_model.dart';
import '../repository/jobs_repo.dart';

final allJobsSearchTermProvider = StateProvider.autoDispose<String?>((ref) => null);

final searchJobsProvider =
AutoDisposeAsyncNotifierProvider<SearchJobsController, List<JobPostModel>>(
        () => SearchJobsController());

class SearchJobsController extends AutoDisposeAsyncNotifier<List<JobPostModel>> {
  final _repository = JobsRepository.instance;
  // List<JobPostModel> popularJobs = [];

  @override
  Future<List<JobPostModel>> build() async {

    final searchTerm = ref.watch(allJobsSearchTermProvider);
    final res = await _repository.getJobs(search: searchTerm);

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
