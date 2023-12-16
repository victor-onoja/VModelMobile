// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../../../core/utils/enum/discover_search_tabs_enum.dart';

@immutable
class DiscoverSearchCompositeModel {
  final String? query;
  final DiscoverSearchTab activeTab;

  DiscoverSearchCompositeModel({
    required this.query,
    required this.activeTab,
  });

  DiscoverSearchCompositeModel copyWith({
    String? query,
    DiscoverSearchTab? activeTab,
  }) {
    return DiscoverSearchCompositeModel(
      query: query ?? this.query,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  factory DiscoverSearchCompositeModel.defualt(DiscoverSearchTab activeTab) {
    return DiscoverSearchCompositeModel(
      query: null,
      activeTab: activeTab,
    );
  }

  @override
  String toString() =>
      'DiscoverSearchCompositeModel(query: $query, activeTab: $activeTab)';

  @override
  bool operator ==(covariant DiscoverSearchCompositeModel other) {
    if (identical(this, other)) return true;

    return other.query == query && other.activeTab == activeTab;
  }

  @override
  int get hashCode => query.hashCode ^ activeTab.hashCode;
}
