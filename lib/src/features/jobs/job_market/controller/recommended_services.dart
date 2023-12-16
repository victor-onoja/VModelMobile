import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/new_profile/profile_features/services/repository/services_repository.dart';
import '../../../settings/views/booking_settings/models/service_package_model.dart';

final recommendedServicesProvider = AsyncNotifierProvider<
    RecommendedServicesController,
    List<ServicePackageModel>>(() => RecommendedServicesController());

class RecommendedServicesController
    extends AsyncNotifier<List<ServicePackageModel>> {
  final _repository = ServicesRepository.instance;

  int _pgCount = 5;

  @override
  Future<List<ServicePackageModel>> build() async {
    // print('sssssssssssssss building popular jobs again');
    return await getPopularServices();
    // print('resssssssssssssssssssssssss');
  }

  Future<List<ServicePackageModel>> getPopularServices() async {
    final response =
        await _repository.getRecommendedServices(dataCount: _pgCount);

    return response.fold(
      (left) {
        print(
            '[ukmote] failed to getting recommended services ${left.message}');
        // run this block when you have an error
        print('[ukmote] ${left.message}');
        return [];
      },
      (right) async {
        print('[ukmote] success getting to recommended services');
        // print(right);
        // print('[ukwErr] ${right}');

        // final servicesData = right['popularServices'] as List;

        // print(' ${servicesData.length}');

        if (right.isNotEmpty) {
          List<ServicePackageModel> models = [];
          try {
            models = right
                .map<ServicePackageModel>((e) =>
                    ServicePackageModel.fromMiniMap(e as Map<String, dynamic>))
                .toList();
          } catch (e, st) {
            print('[ukmote] $e $st');
          }
          // print(' ${models.length}');
          return models;
          // popularJobs = popular;
        }
        return [];
        // return popularJobs;
        // if the success field in the mutation response is true
      },
    );
  }
}
