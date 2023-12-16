// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/enum/album_type.dart';
import 'gallery_controller.dart';

// final selectedGalleryProvider = StateProvider<int>((ref) {
//   return 0;
// });

final profileTabProvider =
    NotifierProvider.autoDispose<ProfileStateInfoNotifier, ProfileTabState>(
        ProfileStateInfoNotifier.new);

class ProfileStateInfoNotifier extends AutoDisposeNotifier<ProfileTabState> {
  @override
  build() {
    return ProfileTabState(
        selectedPortfolioTabIndex: 0, selectedPolaroidTabIndex: 0);
  }

  int getCurrentIndex() {
    final filter = ref.read(galleryTypeFilterProvider(null));
    if (filter == AlbumType.portfolio) {
      return state.selectedPortfolioTabIndex;
    } else {
      return state.selectedPolaroidTabIndex;
    }
  }

  void updateIndex(int index) {
    final filter = ref.read(galleryTypeFilterProvider(null));
    if (filter == AlbumType.portfolio) {
      updatePortfolioIndex(index);
    } else {
      updatePolaroidIndex(index);
    }
  }

  void updatePortfolioIndex(int newIndex) {
    state = state.copyWith(selectedPortfolioTabIndex: newIndex);
  }

  void updatePolaroidIndex(int newIndex) {
    state = state.copyWith(selectedPolaroidTabIndex: newIndex);
  }
}

// @immutable
class ProfileTabState {
  final int selectedPortfolioTabIndex;
  final int selectedPolaroidTabIndex;

  ProfileTabState({
    required this.selectedPortfolioTabIndex,
    required this.selectedPolaroidTabIndex,
  });

  ProfileTabState copyWith({
    int? selectedPortfolioTabIndex,
    int? selectedPolaroidTabIndex,
  }) {
    return ProfileTabState(
      selectedPortfolioTabIndex:
          selectedPortfolioTabIndex ?? this.selectedPortfolioTabIndex,
      selectedPolaroidTabIndex:
          selectedPolaroidTabIndex ?? this.selectedPolaroidTabIndex,
    );
  }

  @override
  String toString() =>
      'ProfileTabState(selectedPortfolioTabIndex: $selectedPortfolioTabIndex, selectedPolaroidTabIndex: $selectedPolaroidTabIndex)';

  @override
  bool operator ==(covariant ProfileTabState other) {
    if (identical(this, other)) return true;

    return other.selectedPortfolioTabIndex == selectedPortfolioTabIndex &&
        other.selectedPolaroidTabIndex == selectedPolaroidTabIndex;
  }

  @override
  int get hashCode =>
      selectedPortfolioTabIndex.hashCode ^ selectedPolaroidTabIndex.hashCode;
}
