// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/coupons_model.dart';
import '../repository/coupons_repo.dart';

final allCouponsSearchProvider = StateProvider.autoDispose<String?>((ref) {
  return null;
});

final allCouponsProvider = AsyncNotifierProvider.autoDispose<
    AllCouponsController, List<AllCouponsModel>>(AllCouponsController.new);

class AllCouponsController
    extends AutoDisposeAsyncNotifier<List<AllCouponsModel>> {
  final _repository = AllCouponsRepository.instance;

  int _pageCount = 5;
  int _currentPage = 1;
  int _allCouponsTotalNumber = 0;
  @override
  Future<List<AllCouponsModel>> build() async {
    state = const AsyncLoading();
    final searchTerm = ref.watch(allCouponsSearchProvider);
    await getAllCoupons(pageNumber: _currentPage, search: searchTerm);
    return state.value!;
  }

  Future<void> getAllCoupons({int? pageNumber, String? search}) async {
    final res = await _repository.getAllCoupons(
        search: search, pageNumber: pageNumber, pageCount: _pageCount);

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      _allCouponsTotalNumber = right['allCouponsTotalNumber'];
      final List allServicesData = right['allCoupons'];
      final newState = allServicesData.map((e) => AllCouponsModel.fromJson(e));

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
    });
  }

  Future<void> fetchMoreData() async {
    final canLoadMore =
        (state.valueOrNull?.length ?? 0) < _allCouponsTotalNumber;

    if (canLoadMore) {
      print("object");
      await getAllCoupons(pageNumber: _currentPage + 1);
      // ref.read(isFeedEndReachedPallCouponsProviderrovider.notifier).state =
      //     itemPositon < feedTotalItems;
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < _allCouponsTotalNumber;
  }

  // Future<void> recordCouponCopy(int couponId) async {
  //   final res = await _repository.registerCouponCopy(
  //     couponId: couponId,
  //   );

  //   return res.fold((left) {
  //     print('in AsyncBuild left is .............. ${left.message}');

  //     return [];
  //   }, (right) {
  //     print(right['message']);
  //   });
  // }
}

final recordCouponCopyProvider =
    FutureProvider.family.autoDispose<void, String>((ref, arg) async {
  final id = int.parse(arg);
  final res = await AllCouponsRepository.instance.registerCouponCopy(
    couponId: id,
  );

  return res.fold((left) {
    print('in AsyncBuild left is .............. ${left.message}');

    return [];
  }, (right) {
    print(right['message']);
  });
});

//*
//
//////////Hottest Coupons
final hottestCouponsProvider =
    AsyncNotifierProvider<HottestCouponsController, List<AllCouponsModel>>(
        HottestCouponsController.new);

class HottestCouponsController extends AsyncNotifier<List<AllCouponsModel>> {
  final _repository = AllCouponsRepository.instance;

  int _pageCount = 5;
  @override
  Future<List<AllCouponsModel>> build() async {
    state = const AsyncLoading();
    // final searchTerm = ref.watch(allCouponsSearchProvider);
    await getHottestCoupons();
    return state.value!;
  }

  Future<void> getHottestCoupons() async {
    final res = await _repository.getHottestCoupons(dataCount: _pageCount);

    return res.fold(
      (left) {
        print('failed to create service ${left.message}');
        // run this block when you have an error
        return;
      },
      (right) async {
        // print('successful create service $right');
        // print();
        // print('recommendedJobsss ${right['recommendedJobs']}');

        final data = right['hottestCoupons'] as List?;

        if (data == null) {
          state = AsyncData([]);
          return;
        }
        if (data.isNotEmpty) {
          List<AllCouponsModel> models = [];
          try {
            models = data
                .map<AllCouponsModel>(
                    (e) => AllCouponsModel.fromJson(e as Map<String, dynamic>))
                .toList();
          } catch (e, st) {
            print('[ukwErr] $e $st');
          }
          // print(' ${models.length}');
          // return models;
          state = AsyncData(models);
          // RecommendedJobs = Recommended;
        }
        return;
        // return RecommendedJobs;
        // if the success field in the mutation response is true
      },
    );
    // return res.fold((left) {
    //   print('in AsyncBuild left is .............. ${left.message}');

    //   return [];
    // }, (right) {
    //   _allCouponsTotalNumber = right['allCouponsTotalNumber'];
    //   final List allServicesData = right['allCoupons'];
    //   final newState = allServicesData.map((e) => AllCouponsModel.fromJson(e));

    //   final currentState = state.valueOrNull ?? [];
    //   if (pageNumber == 1) {
    //     state = AsyncData(newState.toList());
    //   } else {
    //     print("_currentPage $_currentPage");
    //     if (currentState.isNotEmpty &&
    //         newState.any((element) => currentState.last.id == element.id)) {
    //       return;
    //     }

    //     state = AsyncData([...currentState, ...newState]);
    //   }
    //   _currentPage = pageNumber!;
    // });
  }
}
