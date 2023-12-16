import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/repository/services.dart';

final serviceProvider =
    Provider<ServiceRepository>((ref) => ServicesRepository());

final userServices = FutureProvider.autoDispose
    .family<Either<CustomException, List<dynamic>>, String?>(
        (ref, username) async {
  return ref.read(serviceProvider).userServices(username);
});

// final userService = FutureProvider.autoDispose
//     .family<Either<CustomException, List<dynamic>>, String>(
//         (ref, username) async {
//   return ref.read(serviceProvider).getUserConnections(username);
// });

class ServiceNotifier extends ChangeNotifier {
  ServiceNotifier(this.ref) : super();
  final Ref ref;

//  Future<Either<CustomException, Map<String, dynamic>>> createService(
//       String deliveryTimeline,
//       String description,
//       String period,
//       double price,
//       String title,
//       String usageLength,
//       String usageType) async {
//     final repository = ref.read(serviceProvider);
//     late Either<CustomException, Map<String, dynamic>> response;

//     response = await repository.createService(deliveryTimeline, description, period, price, title, usageLength, usageType);

//     return response;
//   }

  // Future<Either<CustomException, Map<String, dynamic>>> updateService(
  //     String deliveryTimeline,
  //     String description,
  //     String period,
  //     double price,
  //     String title,
  //     String usageLength,
  //     String usageType) async {
  //   final repository = ref.read(serviceProvider);
  //   late Either<CustomException, Map<String, dynamic>> response;

  //   response = await repository.updateService(deliveryTimeline, description, period, price, title, usageLength, usageType);

  //   return response;
  // }

  // Future<Either<CustomException, Map<String, dynamic>>> deleteService(
  //     int serviceId) async {
  //   final repository = ref.read(serviceProvider);
  //   late Either<CustomException, Map<String, dynamic>> response;

  //   response = await repository.deleteService(serviceId);

  //   return response;
  // }
}
