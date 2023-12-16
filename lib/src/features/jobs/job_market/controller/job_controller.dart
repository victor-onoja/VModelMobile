import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/response_widgets/toast.dart';
import '../../../dashboard/new_profile/controller/user_jobs_controller.dart';
import '../model/job_post_model.dart';
import '../repository/jobs_repo.dart';

final jobDetailProvider = AsyncNotifierProvider.autoDispose
    .family<JobDetailNotifier, JobPostModel?, String?>(JobDetailNotifier.new);

class JobDetailNotifier
    extends AutoDisposeFamilyAsyncNotifier<JobPostModel?, String?> {
  final _repository = JobsRepository.instance;

  @override
  Future<JobPostModel?> build(jobId) async {
    final id = int.parse(jobId!);

    final response = await _repository.getJob(jobId: id);

    return response.fold(
      (left) {
        print('failed to create service ${left.message}');
        // run this block when you have an error
        return null;
      },
      (right) async {
        print('successful create service');
        print('FFFFFFFFFFFFFFFFFFFFF $right');

        final id = right['id'];

        if (id != null) {
          final job = JobPostModel.fromMap(right);
          // print('jobbbbbbbbbbbbb ${job}');
          return job;
        }
        return null;
        // if the success field in the mutation response is true
      },
    );
  }

  Future<bool> pauseOrResumeJob(String jobId) async {
    final bool isPaused = state.value?.paused ?? false;
    // print('[pd] The id to delete is $packageId');

    final action = isPaused ? "resume" : "pause";
// final sss = packageList.any((element) => element.id ==)
//     print('[kkm] ${}')

    final makeRequest = isPaused
        ? await _repository.resumeJob(
            int.parse(jobId),
          )
        : await _repository.pauseJob(
            int.parse(jobId),
          );

    return makeRequest.fold((onLeft) {
      print('Failed to $action job ${onLeft.message}');
      return false;
      // run this block when you have an error
    }, (onRight) async {
      final success = onRight['success'] ?? false;
      if (!success) return false;

      state = AsyncData(await update(
          (state) => state?.copyWith(paused: isPaused ? false : true)));
      VWidgetShowResponse.showToast(
        ResponseEnum.sucesss,
        message: 'Job ${action}d',
      );
      // print('[pd] $onRight');
      print('successfully $action job');
      return success;
      // if the success field in the mutation response is true
    });
  }

  Future<bool> closeJob(String jobId) async {
    // final bool isPaused = state.value?.paused ?? false;
    // print('[pd] The id to delete is $packageId');

    final makeRequest = await _repository.closeJob(
      int.parse(jobId),
    );

    return makeRequest.fold((onLeft) {
      print('Failed to job ${onLeft.message}');
      return false;
      // run this block when you have an error
    }, (onRight) async {
      final success = onRight['success'] ?? false;
      if (!success) return false;

      VWidgetShowResponse.showToast(
        ResponseEnum.sucesss,
        message: 'Job closed',
      );
      // print('[pd] $onRight');

      ref.invalidate(userJobsProvider(null));
      print('successfully closed job');
      return success;
      // if the success field in the mutation response is true
    });
  }

  Future<bool> saveJob(String saveJob) async {
    final makeRequest = await _repository.saveJob(
      int.parse(saveJob),
    );

    return makeRequest.fold((onLeft) {
      print('Failed to save service ${onLeft.message}');
      return false;
      // run this block when you have an error
    }, (onRight) async {
      final success = onRight['success'] ?? false;

      var currentState = state.value;
      if (success) {
        print('successfully saved job');
        state = AsyncData(currentState!.copyWith(
          userSaved: true,
          saves: currentState.saves! + 1,
        ));

        return success;
      }
      return success;
    });
  }
}
