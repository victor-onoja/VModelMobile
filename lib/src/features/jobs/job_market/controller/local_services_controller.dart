// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/repository/local_services_repo.dart';

import '../../../settings/views/booking_settings/models/service_package_model.dart';

// final popularJobsProvider =
//     Provider.family<List<JobPostModel>, int>((ref, count) async {
//   return await ref.read(jobsProvider.notifier).getPopularJobs(count: count);
//   // return;
// });

final allServiceSearchProvider = StateProvider<String?>((ref) => null);

final allServicesProvider = AutoDisposeAsyncNotifierProvider<
    AllServicesController,
    List<ServicePackageModel>?>(() => AllServicesController());

class AllServicesController
    extends AutoDisposeAsyncNotifier<List<ServicePackageModel>?> {
  final _repository = LocalServicesRepository.instance;
  List<ServicePackageModel>? services;
  int _pageCount = 15;
  int _currentPage = 1;
  int _serviceTotalItems = 0;

  @override
  Future<List<ServicePackageModel>?> build() async {
    state = const AsyncLoading();
    final searchTerm = ref.watch(allServiceSearchProvider);
    _currentPage = 1;
    await getAllServices(pageNumber: _currentPage, search: searchTerm);
    return state.value;
  }

  Future<void> getAllServices({int? pageNumber, String? search}) async {
    print('[kss] get services $search');
    final res = await _repository.getAllServices(
        pageCount: _pageCount, pageNumber: pageNumber, search: search);

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      services = null;
    }, (right) {
      try {
        _serviceTotalItems = right['allServicesTotalNumber'];
        print("allServicesTotalNumber $_serviceTotalItems");
        final List allServicesData = right['allServices'];
        // print("[kss1] allServices ${allServicesData.first['title']}");
        final newState =
            allServicesData.map((e) => ServicePackageModel.fromMiniMap(e));

        // print('[nvnv] ...... ${newState.first.user}');
        final currentState = state.valueOrNull ?? [];
        if (pageNumber == 1) {
          state = AsyncData(newState.toList());
        } else {
          print("_currentPage $_currentPage");
          if (currentState.isNotEmpty &&
              newState.any((element) => currentState.last.id == element.id)) {
            return;
          }

          state = AsyncData([...currentState, ...newState]);
        }
        _currentPage = pageNumber!;

        print(allServicesData);
      } on Exception catch (e) {
        print(e.toString());
      }
    });
  }

  Future<void> fetchMoreData() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _serviceTotalItems;

    if (canLoadMore) {
      await getAllServices(
        pageNumber: _currentPage + 1,
      );
      // ref.read(allServicesProvider.notifier).state =
      //     itemPositon < _serviceTotalItems;
    }
  }

  Future<void> fetchMoreHandler() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _serviceTotalItems;
    // print("[55]  Fetching page:${currentPage + 1} no bounce");
    if (canLoadMore) {
      await fetchMoreData();
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < _serviceTotalItems;
  }
}
