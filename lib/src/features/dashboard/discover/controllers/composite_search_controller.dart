import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/enum/discover_search_tabs_enum.dart';
import '../views/discover_user_search.dart/models/discover_composite_search_model.dart';
import 'discover_controller.dart';

final compositeSearchProvider =
    NotifierProvider<CompositeSearchNotifier, DiscoverSearchCompositeModel>(
        CompositeSearchNotifier.new);

class CompositeSearchNotifier extends Notifier<DiscoverSearchCompositeModel> {
  @override
  DiscoverSearchCompositeModel build() {
    // final selectedTab = ref.watch(searchTabProvider);
    return DiscoverSearchCompositeModel.defualt(DiscoverSearchTab.members);
    // DiscoverSearchTab.vahttps://appwrite.io/docs/products/databases/relationshipslues[selectedTab]);
  }

  updateState({
    String? query,
    DiscoverSearchTab? activeTab,
    // int? activeTab,
  }) {
    // if (state == null)
    //   state = DiscoverSearchCompositeModel(
    //       query: query, activeTab: DiscoverSearchTab.members);
    // else
    // state = state!.copyWith(
    state = state.copyWith(
      query: query,
      activeTab: activeTab,
    );

    if (state.activeTab == DiscoverSearchTab.members && state.query != null) {
      ref.read(discoverProvider.notifier).searchUsers(state.query!);
    }
    log('active tab: $state');
  }
}
