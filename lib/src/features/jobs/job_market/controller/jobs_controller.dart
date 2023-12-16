// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_applications_model.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../model/job_post_model.dart';
import '../repository/jobs_repo.dart';

// final popularJobsProvider =
//     Provider.family<List<JobPostModel>, int>((ref, count) async {
//   return await ref.read(jobsProvider.notifier).getPopularJobs(count: count);
//   // return;
// });

final jobsProvider =
    AutoDisposeAsyncNotifierProvider<JobsController, List<JobPostModel>>(
        () => JobsController());

class JobsController extends AutoDisposeAsyncNotifier<List<JobPostModel>> {
  final _repository = JobsRepository.instance;
  // List<JobPostModel> popularJobs = [];

  @override
  Future<List<JobPostModel>> build() async {
    // state = const AsyncLoading();
    // print('in AsyncBuild..............');
    // List<JobPostModel>? jobs;

    final res = await _repository.getJobs();
    // print('resssssssssssssssssssssssss');

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      // print('in AsyncBuild rieght is .............. $res');
      final jobsCount = right['jobsTotalNumber'];
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

  Future<JobPostModel?> getJobDetails(
      {required int jobId, required double proposedPrice}) async {
    final response = await _repository.getJob(jobId: jobId);

    return response.fold(
      (left) {
        print('failed to create service ${left.message}');
        // run this block when you have an error
        return null;
      },
      (right) async {
        print('successful create service');
        print(right);

        final application = right['application'];
        if (application == null) {
          VWidgetShowResponse.showToast(ResponseEnum.failed,
              message: "Application unsuccessful");
        } else {
          VWidgetShowResponse.showToast(ResponseEnum.sucesss,
              message: "Application successful");
        }

        // if (jobsData.isNotEmpty) {
        //   final popular = jobsData
        //       .map<JobPostModel>(
        //           (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
        //       .toList();
        // }
        return null;
        // if the success field in the mutation response is true
      },
    );
  }

  Future<void> applyForJob(
      {required int jobId, required double proposedPrice}) async {
    final response = await _repository.applyToJob(
        jobId: jobId, proposedPrice: proposedPrice);

    return response.fold(
      (left) {
        print('failed to create service ${left.message}');
        // run this block when you have an error
        return;
      },
      (right) async {
        print('successful create service');
        print(right);

        final application = right['application'];
        if (application == null) {
          VWidgetShowResponse.showToast(ResponseEnum.failed,
              message: "Application unsuccessful");
        } else {
          VWidgetShowResponse.showToast(ResponseEnum.sucesss,
              message: "Application successful");
        }

        // if (jobsData.isNotEmpty) {
        //   final popular = jobsData
        //       .map<JobPostModel>(
        //           (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
        //       .toList();
        // }
        return;
        // if the success field in the mutation response is true
      },
    );
  }
  // Future<List<JobPostModel>> getPopularJobs({required int count}) async {
  //   final response = await _repository.getPopularJobs(dataCount: count);

  //   return response.fold(
  //     (left) {
  //       print('failed to create service ${left.message}');
  //       // run this block when you have an error
  //       return [];
  //     },
  //     (right) async {
  //       print('successful create service');
  //       print(right);

  //       final jobsData = right['popularJobs'] as List;

  //       if (jobsData.isNotEmpty) {
  //         final popular = jobsData
  //             .map<JobPostModel>(
  //                 (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
  //             .toList();
  //         popularJobs = popular;
  //       }
  //       return popularJobs;
  //       // if the success field in the mutation response is true
  //     },
  //   );
  // }
}

final popularJobsProvider =
    AutoDisposeAsyncNotifierProvider<PopularJobsController, List<JobPostModel>>(
        () => PopularJobsController());

class PopularJobsController
    extends AutoDisposeAsyncNotifier<List<JobPostModel>> {
  final _repository = JobsRepository.instance;

  int _pgCount = 5;

  @override
  Future<List<JobPostModel>> build() async {
    print('sssssssssssssss building popular jobs again');
    return await getPopularJobs(count: _pgCount);
    // print('resssssssssssssssssssssssss');
  }

  Future<List<JobPostModel>> getPopularJobs({required int count}) async {
    final response = await _repository.getPopularJobs(dataCount: count);

    return response.fold(
      (left) {
        print('failed to create service ${left.message}');
        // run this block when you have an error
        return [];
      },
      (right) async {
        print('successful create service $right');
        // print();
        print('popularJobsss ${right['popularJobs']}');

        final jobsData = right['popularJobs'] as List?;

        if (jobsData == null) return [];
        if (jobsData.isNotEmpty) {
          List<JobPostModel> models = [];
          try {
            models = jobsData
                .map<JobPostModel>(
                    (e) => JobPostModel.fromMap(e as Map<String, dynamic>))
                .toList();
          } catch (e, st) {
            print('[ukwErr] $e $st');
          }
          // print(' ${models.length}');
          return models;
          // popularJobs = popular;
        }
        return [];
        // return popularJobs;
        // if the success field in the mutation response is true
      },
    );
  }
}

final popularServicesProvider =
    AsyncNotifierProvider<PopularServicesController, List<ServicePackageModel>>(
        () => PopularServicesController());

class PopularServicesController
    extends AsyncNotifier<List<ServicePackageModel>> {
  final _repository = JobsRepository.instance;
  int _pgCount = 5;

  @override
  Future<List<ServicePackageModel>> build() async {
    print('sssssssssssssss building popular jobs again');
    return await getPopularServices(count: _pgCount);
    // print('resssssssssssssssssssssssss');
  }

  Future<List<ServicePackageModel>> getPopularServices(
      {required int count}) async {
    final response = await _repository.getPopularJobs(dataCount: count);

    return response.fold(
      (left) {
        print('[ukwExx] failed to get popular services ${left.message}');
        // run this block when you have an error
        return [];
      },
      (right) async {
        print('[ukwExx] successful fetched popular services');
        print(right);

        final servicesData = right['popularServices'] as List?;

        // print(' ${servicesData.length}');

        if (servicesData == null) return [];
        if (servicesData.isNotEmpty) {
          List<ServicePackageModel> models = [];
          try {
            models = servicesData
                .map<ServicePackageModel>((e) =>
                    ServicePackageModel.fromMiniMap(e as Map<String, dynamic>))
                .toList();
          } catch (e, st) {
            print('[ukwExx] $e $st');
          }
          // print(' ${models.length}');
          return models;
          // popularJobs = popular;
        }
        return [];
        // return popularJobs;
        // if the success field in the mutation response is true
      },
    );
  }
}

final jobApplicationProvider = AsyncNotifierProvider.autoDispose
    .family<JobApplicationsController, List<JobApplicationsModel>?, int?>(
        JobApplicationsController.new);

class JobApplicationsController
    extends AutoDisposeFamilyAsyncNotifier<List<JobApplicationsModel>?, int?> {
  final _repository = JobsRepository.instance;

  @override
  Future<List<JobApplicationsModel>?> build(jobId) async {
    return await getJobApplications(jobId!);
  }

  Future<List<JobApplicationsModel>> getJobApplications(int jobId) async {
    final response = await _repository.getJobApplications(jobId: jobId);

    return response.fold(
      (left) {
        print('failed load applications ${left.message}');
        // run this block when you have an error
        return [];
      },
      (right) async {
        print('successfully loaded job applications');
        print(right);

        final jobApplications = right['jobApplications'] as List;

        if (jobApplications.isNotEmpty) {
          return jobApplications
              .map<JobApplicationsModel>((e) =>
                  JobApplicationsModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
    );
  }

  Future<List<JobApplicationsModel>> acceptApplicationOffer({
    required int applicationId,
    required bool acceptApplication,
  }) async {
    final response = await _repository.acceptApplicationOffer(
      acceptApplication: acceptApplication,
      rejectApplication: false,
      applicationId: applicationId,
    );

    return response.fold(
      (left) {
        print('failed to accept offer ${left.message}');
        // run this block when you have an error
        return [];
      },
      (right) async {
        print('successfully accepted offer');
        print(right);

        final jobApplications = right['jobApplications'] as List;

        if (jobApplications.isNotEmpty) {
          return jobApplications
              .map<JobApplicationsModel>((e) =>
                  JobApplicationsModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
    );
  }
}
