import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/vmodel_credits/models/leaderboard_model.dart';

import '../models/vmc_history_model.dart';
import '../repository/vmc_history_repo.dart';

final vmcTotalProvider = StateProvider<int>((ref) {
  return 0;
});

final vmcRecordProvider = AutoDisposeAsyncNotifierProvider<VMCHistoryNotifier,
    List<VMCHistoryModel>?>(VMCHistoryNotifier.new);

class VMCHistoryNotifier
    extends AutoDisposeAsyncNotifier<List<VMCHistoryModel>?> {
  VMCRepository? _repository;

  int _totalDataCount = 0;
  int _currentPage = 1;

  @override
  // Future<VMCRecordModel?> build() async {
  Future<List<VMCHistoryModel>?> build() async {
    _repository = VMCRepository.instance;

    // final vmcRecord = await _repository!.vmcHistory();
    // VMCRecordModel? initialState;
    // vmcRecord.fold((left) {
    //   print("${left.message} ${StackTrace.current}");
    // }, (right) {
    //   print('more info ${right['vmcrecord']}');
    //   try {
    //     final newState = VMCRecordModel.fromJson(right);
    //     initialState = newState;
    //   } catch (e) {
    //     print(" $e ${StackTrace.current}");
    //   }
    // });
    _currentPage = 1;
    return await fetchData(page: _currentPage, addToState: false);

    // return initialState;
  }

  Future<List<VMCHistoryModel>?> fetchData(
      {required int page, bool addToState = true}) async {
    final vmcRecord =
        await _repository!.vmcHistory(pageNumber: page, pageCount: 20);
    return vmcRecord.fold((left) {
      print("${left.message} ${StackTrace.current}");
      return null;
    }, (right) {
      ref.read(vmcTotalProvider.notifier).state = right['vmcPointsTotal'] ?? 0;
      _totalDataCount = right['vmcPointsHistoryTotalNumber'];
      final historyData = right['vmcPointsHistory'] as List;
      print('[lsa1] more info ${historyData.length}');
      try {
        final history = historyData.map((e) => VMCHistoryModel.fromMap(e));
        print('[lsa2] more info ${history.length}');
        // final newState = VMCRecordModel.fromJson(right);
        // initialState = newState;
        if (addToState) {
          final currentState = state.valueOrNull ?? [];
          state = AsyncData([...currentState, ...history]);
          return null;
        } else {
          return history.toList();
        }
      } catch (e) {
        print(" $e ${StackTrace.current}");
      }
      return null;
    });
  }

  Future<void> fetchMoreHandler() async {
    final currentItemsLength = state.valueOrNull?.length;
    final canLoadMore = (currentItemsLength ?? 0) < _totalDataCount;
    print(
        '[aak] ($currentItemsLength) Can load $canLoadMore Toatal itesm are $_totalDataCount');

    if (canLoadMore) {
      await fetchData(page: _currentPage + 1);
    }
  }
}

final vmcLeaderboardProvider = AutoDisposeAsyncNotifierProvider<
    VMCLeaderboardNotifeier,
    List<VMCLeaderboardModel>>(VMCLeaderboardNotifeier.new);

class VMCLeaderboardNotifeier
    extends AutoDisposeAsyncNotifier<List<VMCLeaderboardModel>> {
  final _repository = VMCRepository.instance;
  @override
  FutureOr<List<VMCLeaderboardModel>> build()async {
    state = AsyncLoading();
    return await vmcLeaderBoard();
  }

  Future<List<VMCLeaderboardModel>> vmcLeaderBoard() async {
    final response = await _repository.vmcLeaderboard();
    return response.fold((left) {
      print(left.message);
      return [];
    }, (right) {
      final List leaderboardList = right['leaderboard'];
      if (leaderboardList.isNotEmpty) {
        return leaderboardList
            .map((e) => VMCLeaderboardModel.fromJson(e))
            .toList();
      }
      return [];
    });
  }
}
