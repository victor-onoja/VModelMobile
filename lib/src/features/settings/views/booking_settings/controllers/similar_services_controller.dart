import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';

import '../../../../dashboard/new_profile/profile_features/services/repository/services_repository.dart';

final similerServicesProvider = AsyncNotifierProvider.autoDispose
    .family<SimilarServicesController, List<ServicePackageModel>, String?>(
        () => SimilarServicesController());

class SimilarServicesController
    extends AutoDisposeFamilyAsyncNotifier<List<ServicePackageModel>, String?> {
       final _repository = ServicesRepository.instance;
  @override
  Future<List<ServicePackageModel>> build(String? arg) async{
     final res = await _repository.getSimilarServices(serviceId: arg);

    return res.fold((left) {
      return [];
    }, (right) {

      if (right.isNotEmpty) {
        print(right);
        final servicesList = right
            .map<ServicePackageModel>((e) => ServicePackageModel.fromMiniMap(
                e as Map<String, dynamic>,
                discardUser: false))
            .toList();
        servicesList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return servicesList;
      }
      return [];
    });
  }
}
