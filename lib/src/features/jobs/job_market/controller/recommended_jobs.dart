import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/job_post_model.dart';
import '../repository/jobs_repo.dart';

final recommendedJobsProvider =
    AsyncNotifierProvider<RecommendedJobsController, List<JobPostModel>>(
        () => RecommendedJobsController());

class RecommendedJobsController extends AsyncNotifier<List<JobPostModel>> {
  final _repository = JobsRepository.instance;

  int _pgCount = 5;

  @override
  Future<List<JobPostModel>> build() async {
    print('sssssssssssssss building recommended jobs again');
    return await getRecommendedJobs(count: _pgCount);
    // print('resssssssssssssssssssssssss');
  }

  Future<List<JobPostModel>> getRecommendedJobs({required int count}) async {
    final response = await _repository.getRecommendedJobs(dataCount: count);

    return response.fold(
      (left) {
        print('failed to create service ${left.message}');
        // run this block when you have an error
        return [];
      },
      (right) async {
        // print('successful create service $right');
        // print();
        // print('recommendedJobsss ${right['recommendedJobs']}');

        print('[ukwEkk] $right');
        final jobsData = right['recommendedJobs'] as List?;

        if (jobsData == null) return [];
        if (jobsData.isNotEmpty) {
          List<JobPostModel> models = [];
          print('[ukwEkk] 2');
          try {
            models = jobsData
                .map<JobPostModel>(
                    (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
                .toList();
          } catch (e, st) {
            print('[ukwEkk] $e $st');
          }
          // print(' ${models.length}');
          print('[ukwEkk] 3');
          return models;
          // RecommendedJobs = Recommended;
        }
        print('[ukwEkk] 4');
        return [];
        // return RecommendedJobs;
        // if the success field in the mutation response is true
      },
    );
  }
}
