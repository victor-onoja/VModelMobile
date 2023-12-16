import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/app_user.dart';
import '../../../connection/controller/provider/connection_provider.dart';
import '../../profile/repository/profile_repo.dart';
import '../repository/discover_repo.dart';

final accountToFollowProvider =
    AsyncNotifierProvider<AccountsToFollowNotifier, List<VAppUser>>(
        AccountsToFollowNotifier.new);

class AccountsToFollowNotifier extends AsyncNotifier<List<VAppUser>> {
  final int _defaultPageCount = 5;
  int _totalDataCount = 0;
  int _currentPage = 1;
  @override
  FutureOr<List<VAppUser>> build() async {
    return await fetchData(page: _currentPage, addToState: false);
  }

  Future<List<VAppUser>> fetchData(
      {required int page, bool addToState = true}) async {
    print('[ssk1] page: $page');
    final response = await DiscoverRepository.instance
        .getAccountsToFollow(pageNumber: page, pageCount: _defaultPageCount);
// ?['accountsToFollow'] as List
    return response.fold((left) {
      print('On Left error getting accounts to'
          ' connect or follow: ${left.message}');
      return [];
    }, (right) {
      if (_totalDataCount == 0)
        _totalDataCount = right['accountsToFollowTotalNumber'] as int;
      print(
          '[ssk] $_currentPage right the total data count is $_totalDataCount');
      final users = right['accountsToFollow'] as List;
      final values = users.map((e) => VAppUser.fromMinimalMap(e)).toList();
      if (addToState) {
        final currentState = state.valueOrNull ?? [];
        state = AsyncData([...currentState, ...values]);
        _currentPage = page;
        return [];
      }
      return values;
      // return users.toList();
    });
  }

  Future<void> fetchMoreHandler() async {
    final currentItemsLength = state.valueOrNull?.length;
    final canLoadMore = (currentItemsLength ?? 0) < _totalDataCount;
    // print(
    //     '[ssk] ($currentItemsLength) Can load $canLoadMore Toatal itesm are $_totalDataCount');

    if (canLoadMore) {
      await fetchData(page: _currentPage + 1);
    }
  }

  Future<void> onFollowUser(String username, {required bool isFollow}) async {
    final response = isFollow
        ? await ProfileRepository.instance.followUser(username)
        : await ref.read(connectionProvider).requestConnection(username);
    response.fold((p0) => null, (right) {
      // print('[kss] $right');
      final success = right['success'] ?? false;
      if (success) {
        final currentState = state.valueOrNull ?? [];
        state = AsyncData([
          for (var item in currentState)
            if (item.username != username) item
        ]);
      }
    });
  }
}
