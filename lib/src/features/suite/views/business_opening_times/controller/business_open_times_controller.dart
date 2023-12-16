import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';

import '../models/business_open_times_info.dart';
import '../models/simple_open_time.dart';
import '../repository/business_info_repository.dart';
import 'business_edit_extras_controller.dart';

final initailExtrasProvider =
    StateProvider.autoDispose<List<BusinessWorkingInfoTag>>((ref) {
  return [];
});
final initailSafetyRulesProvider =
    StateProvider.autoDispose<List<BusinessWorkingInfoTag>>((ref) {
  return [];
});
// final initailSafetyRulesProvider = StateProvider.autoDispose
//     .family<List<BusinessWorkingInfoTag>, String>((ref, arg) {
//   return [];
// });

final businessOpenTimesProvider = AsyncNotifierProvider.autoDispose
    .family<BusinessOpenTimesNotifier, BusinessOpenTimeInfoModel?, String?>(
        BusinessOpenTimesNotifier.new);

class BusinessOpenTimesNotifier extends AutoDisposeFamilyAsyncNotifier<
    BusinessOpenTimeInfoModel?, String?> {
  final _repository = BusinessOpeningInfoRepository.instance;
  @override
  Future<BusinessOpenTimeInfoModel?> build(arg) async {
    final response = await _repository.getBusinessOpenTimesInfo(username: arg);
    return response.fold((left) {
      return null;
    }, (right) {
      print('[iki1] ${right}');
      final model = BusinessOpenTimeInfoModel.fromMap(right);
      ref
          .read(businessInfoTag(VMString.businessExtraKey).notifier)
          .set(model.extrasInfo, VMString.businessExtraKey);
      ref
          .read(businessInfoTag(VMString.businessSafetyRulesKey).notifier)
          .set(model.safetyInfo, VMString.businessSafetyRulesKey);
      return model;
    });
    // return null;
  }

  Future<void> updateWorkingTimes(List<SimpleOpenTime> workingHours) async {
    final workingHoursMap = workingHours.map((e) => e.toMap()).toList();

    print('[iki10] ${workingHoursMap.length}');
    final response =
        await _repository.updateWorkingDaysAndHours(workingHoursMap);
    response.fold((p0) => null, (right) {
      print('[iki1] ${right}');
      final updatedState =
          BusinessOpenTimeInfoModel.fromMap(right['businessInfo']);
      // ref
      //     .read(businessInfoTag(VMString.businessExtraKey).notifier)
      //     .set(updatedState.extrasInfo, VMString.businessExtraKey);
      // ref
      //     .read(businessInfoTag(VMString.businessSafetyRulesKey).notifier)
      //     .set(updatedState.safetyInfo, VMString.businessSafetyRulesKey);
      state = AsyncData(updatedState);
    });
    return;
  }

  Future<void> addBusinessExtras(List<String> extras) async {
    // final workingHoursMap = workingHours.map((e) => e.toMap()).toList();
    final response = await _repository.addBusinessExtraInfo(extras);
    response.fold((p0) => null, (right) {
      print('[iki7] ${right}');
      final updatedState =
          BusinessOpenTimeInfoModel.fromMap(right['businessInfo']);
      print('[iki77] ${updatedState}');
      // state = AsyncData(updatedState);

      ref
          .read(businessInfoTag(VMString.businessExtraKey).notifier)
          .set(updatedState.extrasInfo, VMString.businessExtraKey);
      // ref
      //     .read(businessInfoTag(VMString.businessSafetyRulesKey).notifier)
      //     .set(updatedState.safetyInfo, VMString.businessSafetyRulesKey);
      return null;
    });
    return;
  }

  Future<void> addBusinessSafetyRule(List<String> rules) async {
    // final workingHoursMap = workingHours.map((e) => e.toMap()).toList();
    final response = await _repository.addBusinessSafetyRules(rules);
    response.fold((p0) => null, (right) {
      print('[iki7] ${right}');
      final updatedState =
          BusinessOpenTimeInfoModel.fromMap(right['businessInfo']);
      print('[iki7aaa=>] ${updatedState}');
      // state = AsyncData(updatedState);
      // ref
      //     .read(businessInfoTag(VMString.businessExtraKey).notifier)
      //     .set(updatedState.extrasInfo, VMString.businessExtraKey);
      ref
          .read(businessInfoTag(VMString.businessSafetyRulesKey).notifier)
          .set(updatedState.safetyInfo, VMString.businessSafetyRulesKey);
      return null;
    });
    return;
  }

  Future<void> removeExtraInfo(String id) async {
    // final workingHoursMap = workingHours.map((e) => e.toMap()).toList();
    final int extraId = int.parse('$id');
    final response = await _repository.removeBusinessesExtraInfo(extraId);
    response.fold((p0) => null, (right) {
      print('[iki7] ${right}');
      return null;
    });
    return;
  }

  Future<void> removeSafetyRule(String id) async {
    // final workingHoursMap = workingHours.map((e) => e.toMap()).toList();
    final int extraId = int.parse('$id');
    final response = await _repository.removeBusinessesSafetyRule(extraId);
    response.fold((p0) => null, (right) {
      print('[iki7] ${right}');
      return null;
    });
    return;
  }
}
