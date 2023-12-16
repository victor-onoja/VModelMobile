import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/notifications/controller/repository/notification.dart';

import 'dart:async';

final notificationProvider =
    Provider<NotificationRepository>((ref) => NotificationsRepository());

// final getNotifications =
//     FutureProvider<Either<CustomException, List<dynamic>>>((ref) async {
//   return ref.read(notificationProvider).getNotifications();
// });

final getNotifications =
    AsyncNotifierProvider.autoDispose<NotificationController, List<dynamic>>(
        NotificationController.new);

class NotificationController extends AutoDisposeAsyncNotifier<List<dynamic>> {
  final _repository = notificationProvider;

  int _pageCount = 30;
  int _currentPage = 10;
  int _totalItems = 0;

  @override
  Future<List<dynamic>> build() async {
    // state = const AsyncLoading();
    _currentPage = 1;
    return await fetchData(pageNumber: _currentPage);
    // return state.value;
  }

  Future<List<dynamic>> fetchData(
      {required int pageNumber, String? search, bool addToState = true}) async {
    print('[wzs1] page ${pageNumber}');
    final res = await ref
        .read(notificationProvider)
        .getNotifications(pageNumber: pageNumber, pageCount: _pageCount);

    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      _totalItems = right['notificationsTotalNumber'] ?? 0;
      print('[wzss] page ${pageNumber}....... ${_totalItems}');
      final List newValue = right['notifications'];
      // final newState = allServicesData.map((e) => dynamic.fromJson(e));

      for (var x in newValue) {
        print('[wzss] page ${x["id"]}');
      }

      final currentState = state.valueOrNull ?? [];
      if (pageNumber > 1) {
        // state = AsyncData(newState.toList());
        state = AsyncData([...currentState, ...newValue]);
        return [];
      } else {
        // state = AsyncData([...currentState, ...newValue]);
        return newValue;
      }
      // _currentPage = pageNumber!;
      // print(allServicesData);
      // return allServicesData
      //     .map<dynamic>((e) => dynamic.fromJson(e as Map<String, dynamic>))
      //     .toList();

      // try {
      //   _serviceTotalItems = right['allServicesTotalNumber'];
      //   print("allServicesTotalNumber $_serviceTotalItems");
      //   final List allServicesData = right['allServices'];
      //   final newState =
      //       allServicesData.map((e) => LocalServicesModel.fromJson(e));

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

      //   print(allServicesData);
      // } on Exception catch (e) {
      //   print(e.toString());
      // }
    });
  }

  // Future<void> fetchMoreData() async {
  //   final canLoadMore = (state.valueOrNull?.length ?? 0) < _serviceTotalItems;

  //   if (canLoadMore) {
  //     await getAllCoupons(pageNumber: _currentPage + 1);
  //     // ref.read(isFeedEndReachedProvider.notifier).state =
  //     //     itemPositon < feedTotalItems;
  //   }
  // }

  Future<void> fetchMoreHandler() async {
    final currentItemsLength = state.valueOrNull?.length;
    final canLoadMore = (currentItemsLength ?? 0) < _totalItems;
    print(
        '[aak] ($currentItemsLength) Can load $canLoadMore Toatal itesm are $_totalItems');

    if (canLoadMore) {
      await fetchData(pageNumber: _currentPage + 1);
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < _totalItems;
  }
}
