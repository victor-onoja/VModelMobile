import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/repository/local_services_repo.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';

import '../repository/saved_jobs_repo.dart';

final savedSearchTextProvider = StateProvider.autoDispose<String?>((ref) => '');

final savedServicesProvider = AsyncNotifierProvider.autoDispose<
    SavedServicesNotifier,
    List<ServicePackageModel>?>(SavedServicesNotifier.new);

class SavedServicesNotifier
    extends AutoDisposeAsyncNotifier<List<ServicePackageModel>?> {
  final _repository = SavedServicesRepository.instance;
  int _pageCount = 15;
  int _currentPage = 1;
  int savedJobsTotalNumber = 0;
  @override
  Future<List<ServicePackageModel>?> build() async {
    state = AsyncLoading();
    await getAllSavedServices(pageNumber: null);
    return state.value!;
  }

  Future<void> getAllSavedServices({int? pageNumber}) async {
    final response = await _repository.getSavedServices(
      pageNumber: null,
      pageCount: null,
    );
    return response.fold(
      (left) {
        print("error: ${left.message}");
        return [];
      },
      (right) {
        try {
          savedJobsTotalNumber = right['savedServicesTotalNumber'];
          final List jobList = right['savedServices'];
          print("nciejnciosdc:${right}");
          final newState = jobList.map((e) {
            print("${e['service']}");
            return ServicePackageModel.fromMap(e['service']);
          });

          state = AsyncData(newState.toList());
        } on Exception catch (e) {
          print(e.toString());
        }
      },
    );
  }

  // Future<void> fetchMoreData() async {
  //   final canLoadMore = (state.valueOrNull?.length ?? 0) < savedJobsTotalNumber;

  //   if (canLoadMore) {
  //     await getAllSavedServices(
  //       pageNumber: _currentPage + 1,
  //     );
  //   }
  // }

  // Future<void> fetchMoreHandler() async {
  //   final canLoadMore = (state.valueOrNull?.length ?? 0) < savedJobsTotalNumber;
  //   // print("[55]  Fetching page:${currentPage + 1} no bounce");
  //   if (canLoadMore) {
  //     await fetchMoreData();
  //   }
  // }

  // bool canLoadMore() {
  //   return (state.valueOrNull?.length ?? 0) < savedJobsTotalNumber;
  // }
}

final searchSavedServicesProvider = AsyncNotifierProvider.autoDispose<
    SearchSavedServicesNotifier,
    List<ServicePackageModel>?>(SearchSavedServicesNotifier.new);

class SearchSavedServicesNotifier
    extends AutoDisposeAsyncNotifier<List<ServicePackageModel>?> {
  final _repository = SavedServicesRepository.instance;

  @override
  FutureOr<List<ServicePackageModel>?> build() async {
    final queryString = ref.watch(savedSearchTextProvider);
    state = AsyncLoading();
    await getAllSavedServices(search: queryString);
    return state.value!;
  }

  Future<void> getAllSavedServices({String? search}) async {
    final response = await _repository.searchSavedServices(
      pageNumber: null,
      pageCount: null,
      search: search,
    );
    return response.fold(
      (left) {
        print("error: ${left.message}");
        return [];
      },
      (right) {
        try {
          final List jobList = right['searchSavedServices'];

          final newState = jobList.map((e) {
            return ServicePackageModel.fromMap(e);
          });

          state = AsyncData(newState.toList());
        } on Exception catch (e) {
          print(e.toString());
        }
      },
    );
  }
}

final savedJobsProvider =
    AsyncNotifierProvider.autoDispose<SavedJobNotifier, List<JobPostModel>?>(
        SavedJobNotifier.new);

class SavedJobNotifier extends AutoDisposeAsyncNotifier<List<JobPostModel>?> {
  final _repository = SavedJobsRepository.instance;
  int _pageCount = 15;
  int _currentPage = 1;
  int savedJobsTotalNumber = 0;
  @override
  Future<List<JobPostModel>?> build() async {
    state = AsyncLoading();
    await getAllSavedJobs(pageNumber: _currentPage);
    return state.value!;
  }

  Future<void> getAllSavedJobs({int? pageNumber, String? search}) async {
    final response = await _repository.getSavedJobs(
      pageNumber: _currentPage,
      pageCount: _pageCount,
    );
    return response.fold(
      (left) {
        print("error: ${left.message}");
        return [];
      },
      (right) {
        try {
          savedJobsTotalNumber = right['savedJobsTotalNumber'];
          final List jobList = right['savedJobs'];
          final newState = jobList.map((e) => JobPostModel.fromMap(e['job']));
          // final currentState = state.valueOrNull ?? [];
          // if (pageNumber == 1) {
          state = AsyncData(newState.toList());
          // } else {
          //   if (currentState.isNotEmpty &&
          //       newState.any((element) => currentState.last.id == element.id)) {
          //     return;
          //   }

          //   state = AsyncData([...currentState, ...newState]);
          // }
          // _currentPage = pageNumber!;
        } on Exception catch (e) {
          print(e.toString());
        }
      },
    );
  }

  Future<void> fetchMoreData() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < savedJobsTotalNumber;

    if (canLoadMore) {
      await getAllSavedJobs(
        pageNumber: _currentPage + 1,
      );
    }
  }

  Future<void> fetchMoreHandler() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < savedJobsTotalNumber;
    // print("[55]  Fetching page:${currentPage + 1} no bounce");
    if (canLoadMore) {
      await fetchMoreData();
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < savedJobsTotalNumber;
  }
}
