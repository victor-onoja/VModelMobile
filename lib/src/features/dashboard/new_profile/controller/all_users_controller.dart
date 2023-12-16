import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/model/all_users_model.dart';
import 'package:vmodel/src/features/dashboard/new_profile/repository/all_users_repo.dart';

final allUsersProvider =
    AutoDisposeAsyncNotifierProvider<AllUsersController, List<AllUsersModel>>(
        () => AllUsersController());

class AllUsersController extends AutoDisposeAsyncNotifier<List<AllUsersModel>> {
  final _repository = AllUsersRepository.instance;

  @override
  FutureOr<List<AllUsersModel>> build() async {
    final getUsers = await _repository.getUsers();
    return getUsers.fold((left) {
      print("Failed to get users");
      return [];
    }, (right) {
      final blockedUsers = right;
      print("=======================> >> $blockedUsers");
      try {
        final usersList = blockedUsers.map((e) => AllUsersModel.fromJson(e));
        return usersList.toList();
      } catch (err) {
        print("========================> $err");
      }
      return [];
    });
  }
}
