import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/suite/models/profile_view_model.dart';
import 'package:vmodel/src/features/suite/profile_views_repo/profile_view_repo.dart';

final dailyProfileViewProvider = AsyncNotifierProvider.autoDispose<
    ProfileViewNotifier, List<DailyViewModel>?>(() => ProfileViewNotifier());
final analyticViews = StateProvider((ref) => '8');

class ProfileViewNotifier
    extends AutoDisposeAsyncNotifier<List<DailyViewModel>?> {
  final _repo = ProfileViewRepo.instance;
  @override
  Future<List<DailyViewModel>?> build() async {
    state = AsyncLoading();
    await Future.delayed(Duration(seconds: 4));
    final filter = ref.watch(analyticViews);
    await getDailyProfileViews(filter);
    return state.value;
  }

  Future<void> getDailyProfileViews(String filterBy) async {
    final response = await _repo.getDailyProfileViews(filterBy);
    response.fold((left) {
      print("nihwjekbncsdjk $left");
      return [];
    }, (right) {
      List dailyView = right['totalViewsGraph'];
      print("klwmrfvekrl $dailyView");
      var allViews = dailyView.map((e) => DailyViewModel.fromJson(e));
      state = AsyncData(allViews.toList());
    });
  }
}
