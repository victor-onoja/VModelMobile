import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../repository/create_post_repo.dart';

final suggestedPostLocationProvider = AsyncNotifierProvider.autoDispose<
    SuggestedPostLocationNotifier,
    List<String>>(SuggestedPostLocationNotifier.new);

class SuggestedPostLocationNotifier
    extends AutoDisposeAsyncNotifier<List<String>> {
  final _repository = CreatePostRepository.instance;

  @override
  Future<List<String>> build() async {
//User profile location
    final userLocation =
        ref.watch(appUserProvider.select((user) => user.valueOrNull?.location));

    //has profile location name
    final hasProfileLocation =
        !(userLocation?.locationName.isEmptyOrNull ?? true);

    //add user location name if available
    final initialLocations = [
      if (hasProfileLocation) userLocation!.locationName,
    ];

    //get post location history from api
    final res = await _repository.postLocationHistory();
    return res.fold((left) {
      print('Error $left');
      return [];
    }, (right) {
      // print('[oxssi] ${}');
      if (right.isEmpty) {
        return initialLocations;
      }
      try {
        final pastLocations =
            right.map((e) => e as String?).whereType<String>().toList();
        print(
            '[oxssi] is $pastLocations ProfileEmpty ${userLocation?.locationName} $initialLocations');
        initialLocations.addAll(pastLocations);
      } catch (err, st) {
        print('[oxssi] $err, $st');
      }

      // final List<int> b = a.whereType<int>().toList();
      return initialLocations;
      // return [];
    });
  }
}
