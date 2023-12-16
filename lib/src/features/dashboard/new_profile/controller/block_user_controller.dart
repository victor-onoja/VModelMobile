import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/model/block_user_model.dart';
import 'package:vmodel/src/features/dashboard/new_profile/repository/block_user_repo.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../../../connection/controller/provider/connection_provider.dart';

final isUserBlockedProvider =
    StateProvider.autoDispose.family<bool, String>((ref, args) {
  final blockUsers = ref.watch(blockUserProvider);
  //when value is async use valueOrNull
  final blockUsersCheck = blockUsers.valueOrNull;
  if (blockUsersCheck == null) return false;
  return blockUsersCheck.any((element) => element.username == args);
});

final blockUserProvider =
    AsyncNotifierProvider.autoDispose<BlockUserNotifier, List<BlockUserModel>>(
        () => BlockUserNotifier());

class BlockUserNotifier extends AutoDisposeAsyncNotifier<List<BlockUserModel>> {
  final _repository = BlockUserRepository.instance;

  @override
  FutureOr<List<BlockUserModel>> build() async {
    final searchQuery = ref.watch(connectionGeneralSearchProvider);
    final getBlockedUsersResponse =
        await _repository.getBlockedUsers(search: searchQuery);
    return getBlockedUsersResponse.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.failed,
      //     message: "Failed to get the users");
      print("Failed to get blocked users");
      return [];
    }, (right) {
      final blockedUsers = right['blockedUsers'] as List<dynamic>;
      print("=======================> >> $blockedUsers");
      try {
        final blockedUsersList =
            blockedUsers.map((e) => BlockUserModel.fromMap(e));
        return blockedUsersList.toList();
      } catch (err) {
        print("========================> $err");
      }
      return [];
    });
  }

  ///

  bool isUserInBlockedList({required String username}) {
    final blockedUsersCheck = state.valueOrNull;
    if (blockedUsersCheck == null) return false;
    return blockedUsersCheck.any((element) => element.username == username);
  }

  /// Function to Block the User
  Future<bool> blockUser(
      {required int id,
      required String userName,
      required String firstName,
      required String lastName,
      required bool isVerified,
      required bool blueTickVerified,
      String? userType,
      String? userTypeLabel,
      String? profilePictureUrl}) async {
    final response = await _repository.blockUser(userName: userName);
    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Failed to block the $userName");

      print('Error blocking the ${left.message} ${StackTrace.current}');
      return false;
    }, (right) {
      final bool success = right['success'] ?? false;
      if (success) {
        VWidgetShowResponse.showToast(ResponseEnum.failed,
            message: "The $userName has been blocked");
        final newBlockUser = BlockUserModel(
          id: id.toString(),
          username: userName,
          firstName: firstName,
          lastName: lastName,
          profilePictureUrl: profilePictureUrl,
          userType: userType ?? 'No talent',
          label: userTypeLabel ?? 'No sub-talent',
          isVerified: isVerified,
          blueTickVerified: blueTickVerified,
        );
        state = AsyncValue.data([
          ...?state.value,
          newBlockUser,
        ]);
      }

      print('Success blocking user  ----------------------------->  $right');
      return success;
    });
  }

  /// Function to Un-Block the User
  Future<bool> unBlockUser({required String userName}) async {
    final blockedUsersCheck = state.valueOrNull;
    final response = await _repository.unBlockUser(userName: userName);
    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Failed to Un-block the $userName");

      print('Error blocking the ${left.message} ${StackTrace.current}');
      return false;
    }, (right) {
      final bool success = right['success'] ?? false;
      if (success) {
        VWidgetShowResponse.showToast(ResponseEnum.sucesss,
            message: "Unblocked $userName successfully");
        if (blockedUsersCheck == null) return false;
        state = AsyncValue.data([
          for (final blockUser in blockedUsersCheck)
            if (blockUser.username != userName) blockUser,
        ]);
      }
      print('Success Un-blocking user -----------------------------> $right');
      return success;
    });
  }
}
