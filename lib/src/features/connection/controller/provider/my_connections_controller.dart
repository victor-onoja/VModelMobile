
import 'package:flutter_riverpod/flutter_riverpod.dart';


final myConnectionsSortTypeProvider = StateProvider<bool>((ref) {
  return true;
});

final myConnectionsSearchProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

// class MyConnectionsNotifier extends AsyncNotifier<List<dynamic>> {
//   @override
//   Future<List<dynamic>> build() async {
//     return await ref.read(connectionProvider).getConnections();
//   }
// }
