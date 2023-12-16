import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/discover_item.dart';
import '../repository/discover_repo.dart';

final recommendedBusinessesProvider = AsyncNotifierProvider<
    RecommendedBusinessesNotifier,
    List<DiscoverItemObject>>(RecommendedBusinessesNotifier.new);

class RecommendedBusinessesNotifier
    extends AsyncNotifier<List<DiscoverItemObject>> {
  @override
  FutureOr<List<DiscoverItemObject>> build() async {
    final response = await DiscoverRepository.instance
        .getRecommendedBusiness(pageCount: 20, pageNumber: 1);
    return response.fold((left) {
      print('On Left error fetching from explore: ${left.message}');
      return [];
    }, (right) {
      final data = right['recommendedBusinesses'] as List;
      print('[kkr] $data');
      final items = data.map((e) => DiscoverItemObject.fromMap(e)).toList();
      print('[kkrsss] $items');
      return items;
    });
  }
}
