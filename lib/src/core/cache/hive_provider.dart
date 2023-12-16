import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vmodel/src/core/models/app_user.dart';

final userPreferredTheme = StateProvider((ref) => 0);

final hiveStoreProvider = AsyncNotifierProvider(() => HiveNotifier());

class HiveNotifier extends AsyncNotifier<void> {
  late Box searchesBox;
  // late Box prefsBox;
  @override
  FutureOr<void> build() async {
    searchesBox = await Hive.openBox('recent_searches',
        keyComparator: recentKeyComparator);

    // searchesBox.listenable()
    return;
  }

  List<VAppUser> getRecentlyViewedList() {
    final recentSearches = searchesBox.values.map((e) {
      // return SearchUserModel.fromMap(e);
      print('[[${e.runtimeType}]] Retrieval rommmmmmmm hive $e');
      var temp = Map<String, dynamic>.from(e);
      return VAppUser.fromMap(temp, igNoreEmail: true);
    });
    return recentSearches.toList();
  }

  void clearRecent() {
    searchesBox.clear();
  }

  // void storeRecentEntry(SearchUserModel user) {
  void storeRecentEntry(VAppUser user) {
    searchesBox.add(user.toMap());
  }

  /// Efficient default implementation to compare keys
  int recentKeyComparator(dynamic k1, dynamic k2) {
    if (k1 is int) {
      if (k2 is int) {
        if (k1 > k2) {
          return -1;
        } else if (k1 < k2) {
          return 1;
        } else {
          return 0;
        }
      } else {
        return -1;
      }
    } else if (k2 is String) {
      return (k1 as String).compareTo(k2);
    } else {
      return 1;
    }
  }
}
