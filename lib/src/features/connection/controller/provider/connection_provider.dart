import 'dart:async';

import 'package:either_option/either_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/connection/controller/repository/connection_repository.dart';
import 'package:vmodel/src/vmodel.dart';

import 'my_connections_controller.dart';

final connectionProvider =
    Provider<ConnectionRepository>((ref) => ConnectionsRepository());

final connectionProcessingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
// final Provider = StateProvider<>((ref) {
//   return ;
// });

final searchConnections =
    FutureProvider.autoDispose<Either<CustomException, List<dynamic>>>(
        (ref) async {
  final searchQuery = ref.watch(myConnectionsSearchProvider);
  Either<CustomException, List<dynamic>> searchResults = Right([]);
  print('[vcc] --->> make call with $searchQuery*');
  // return;
  searchResults =
      await ref.read(connectionProvider).searchConnections(query: searchQuery);
  // return ref.read(connectionProvider).searchConnections(query: searchQuery);
  return searchResults;
});

final getConnections =
    FutureProvider<Either<CustomException, List<dynamic>>>((ref) async {
  final sortType = ref.watch(myConnectionsSortTypeProvider);
  print('[dff] getting conns. with latest $sortType');
  return ref.read(connectionProvider).getConnections(latestFirst: sortType);
});

final getUserConnections = FutureProvider.autoDispose
    .family<Either<CustomException, List<dynamic>>, String>(
        (ref, username) async {
  return ref.read(connectionProvider).getUserConnections(username);
});

final connectionGeneralSearchProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final getSentConnections =
    FutureProvider.autoDispose<Either<CustomException, List<dynamic>>>(
        (ref) async {
  final term = ref.watch(connectionGeneralSearchProvider);
  return ref.read(connectionProvider).getSentConnectionsRequests(search: term);
});

final getRecievedConnections =
    FutureProvider.autoDispose<Either<CustomException, List<dynamic>>>(
        (ref) async {
  final term = ref.watch(connectionGeneralSearchProvider);
  return ref
      .read(connectionProvider)
      .getRecievedConnectionsRequests(search: term);
});

class ConnectionNotifier extends ChangeNotifier {
  ConnectionNotifier(this.ref) : super();
  final Ref ref;

  Future<Either<CustomException, Map<String, dynamic>>> requestConnection(
      String username) async {
    // ref.read(connectionProcessingProvider.notifier).state = true;
    final repository = ref.read(connectionProvider);
    late Either<CustomException, Map<String, dynamic>> response;

    response = await repository.requestConnection(username);

    // ref.read(connectionProcessingProvider.notifier).state = false;
    return response;
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteConnection(
      bool accept, int connectionId) async {
    final repository = ref.read(connectionProvider);
    late Either<CustomException, Map<String, dynamic>> response;

    response = await repository.deleteConnection(connectionId);

    return response;
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateConnection(
      bool accept, int connectionId) async {
    final repository = ref.read(connectionProvider);
    late Either<CustomException, Map<String, dynamic>> response;

    response = await repository.updateConnection(accept, connectionId);

    return response;
  }
}
