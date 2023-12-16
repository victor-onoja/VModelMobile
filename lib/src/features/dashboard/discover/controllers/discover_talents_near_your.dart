import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/discover_item.dart';
import '../repository/discover_repo.dart';

final talentsNearYouProvider =
    AsyncNotifierProvider<TalentsNearYouNotifier, List<DiscoverItemObject>>(
        TalentsNearYouNotifier.new);

class TalentsNearYouNotifier extends AsyncNotifier<List<DiscoverItemObject>> {
  int _pgCount = 5;
  @override
  FutureOr<List<DiscoverItemObject>> build() async {
    final response = await DiscoverRepository.instance
        .getTalentsNearYou(pageCount: _pgCount, pageNumber: 1);
    return response.fold((left) {
      print('On Left error fetching from explore: ${left.message}');
      return [];
    }, (right) {
      final data = right['talentsNearYou'] as List;
      return data.map((e) => DiscoverItemObject.fromMap(e)).toList();
      // return;
    });
  }
}
