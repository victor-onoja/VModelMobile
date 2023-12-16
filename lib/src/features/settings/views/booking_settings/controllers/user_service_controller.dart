import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/repository/services.dart';

import '../../../../dashboard/new_profile/profile_features/services/models/user_service_modal.dart';
import '../models/service_package_model.dart';

final userServicePackagesProvider = AsyncNotifierProvider.autoDispose.family<
    UserServicePackageController,
    ServicePackageModel,
    UserServiceModel?>(() => UserServicePackageController());

class UserServicePackageController extends AutoDisposeFamilyAsyncNotifier<
    ServicePackageModel, UserServiceModel?> {
  final _repository = UserServiceRepository.instance;

  @override
  FutureOr<ServicePackageModel> build(userServiceModel) async {
    return await getService(
      serviceId: userServiceModel?.serviceId ?? "",
      username: userServiceModel?.username ?? "",
    );
  }

  Future<ServicePackageModel> getService({
    required String? serviceId,
    String? username,
  }) async {
    ServicePackageModel? serviceData;
    final response = await _repository.userService(
      username,
      int.parse(serviceId!),
    );

    return response.fold(
      (left) {
        print('failed to get service ${left.message}');
        // run this block when you have an error
        return serviceData!;
      },
      (right) async {
        print('successfully fetched service');
        print("righthghgh $right");

        print("userService ${right}");
        return serviceData = ServicePackageModel.fromMap(right);

        // if the success field in the mutation response is true
      },
    );
  }

  Future<bool> likeService(String packageId) async {
    bool success = false;
    final makeRequest = await _repository.likeService(
      int.parse(packageId),
    );

    makeRequest.fold((onLeft) {
      print('Failed to like service ${onLeft.message}');

      // run this block when you have an error
    }, (onRight) async {
      success = onRight['success'] ?? false;
      if (!success) return;
      final currentData = state.value;
      state = AsyncValue.data(currentData!.copyWith(
        likes: currentData.userLiked
            ? currentData.likes! - 1
            : currentData.likes! + 1,
        userLiked: !currentData.userLiked,
      ));

      // print('[pd] $onRight');
      print('successfully liked service');
      // if the success field in the mutation response is true
    });

    return success;
  }

  Future<bool> saveService(String packageId) async {
    final makeRequest = await _repository.saveService(
      int.parse(packageId),
    );

    return makeRequest.fold((onLeft) {
      print('Failed to save service ${onLeft.message}');
      return false;
    }, (onRight) async {
      final success = onRight['success'] ?? false;
      if (!success) return success;

      try {
        final currentData = state.value;
        if (currentData != null)
          state = AsyncValue.data(currentData.copyWith(
            saves: currentData.userSaved
                ? currentData.saves! - 1
                : currentData.saves! + 1,
            userSaved: !currentData.userSaved,
          ));
      } on Platform catch (e) {
        return success;
      }

      return success;
    });
  }
}
