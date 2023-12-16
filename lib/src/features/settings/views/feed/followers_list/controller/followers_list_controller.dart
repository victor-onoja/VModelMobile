import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/models/app_user.dart';
import '../../../../../connection/controller/provider/connection_provider.dart';
import '../repository/followers_list_repo.dart';

final followersListProvider =
    AsyncNotifierProvider.autoDispose<FollowersListNotifier, List<VAppUser>>(
        () => FollowersListNotifier());

class FollowersListNotifier extends AutoDisposeAsyncNotifier<List<VAppUser>> {
  final _repository = FollowersListRepository.instance;

  @override
  FutureOr<List<VAppUser>> build() async {
    print("Fetching followed users");
    final searchQuery = ref.watch(connectionGeneralSearchProvider);
    final response = await _repository.getFollowers(search: searchQuery);
    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.failed,
      //     message: "Failed to get the users");
      print("Failed to get followed users");
      return [];
    }, (right) {
      // final followedUsers = right;
      print("=======================> >> $right");
      try {
        final userList =
            right.map((e) => VAppUser.fromMap(e, igNoreEmail: true));
        return userList.toList();
      } catch (err, st) {
        print("========================> $err $st");
      }
      return [];
    });
  }

  // Future<bool> unfollowUser({required String userName}) async {
  //   final followedUsers = state.valueOrNull;
  //   final response = await _repository.unfollowUser(userName: userName);
  //   return response.fold((left) {
  //     VWidgetShowResponse.showToast(ResponseEnum.failed,
  //         message: "Failed to Un-follow the $userName");

  //     print('Error unfollowers the ${left.message} ${StackTrace.current}');
  //     return false;
  //   }, (right) {
  //     final bool success = right['success'] ?? false;
  //     if (success) {
  //       VWidgetShowResponse.showToast(ResponseEnum.sucesss,
  //           message: "unfollowed $userName");
  //       if (followedUsers == null) return false;
  //       state = AsyncValue.data([
  //         for (final user in followedUsers)
  //           if (user.username != userName) user,
  //       ]);
  //     }
  //     print('Success Un-followers user -----------------------------> $right');
  //     return success;
  //   });
  // }
}
