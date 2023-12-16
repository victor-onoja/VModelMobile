import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/create_posts/models/photo_post_model.dart';

import '../../../core/utils/enum/album_type.dart';
import '../../dashboard/new_profile/controller/gallery_controller.dart';
import '../../dashboard/new_profile/model/gallery_model.dart';

final printGalleryTypeFilterProvider = StateProvider.autoDispose
    .family<AlbumType, String?>((ref, username) => AlbumType.portfolio);

final printGalleryListProvider = Provider.autoDispose
    .family<AsyncValue<List<GalleryModel>>, String?>((ref, username) {
  // ref.onDispose(() {
  //   print('!!!!!!======!!!!! Disposing printGalleryListProvider');
  // });
  final filter = ref.watch(printGalleryTypeFilterProvider(username));
  final temp = ref.watch(galleryProvider(username));
  if (temp.isLoading || temp.isRefreshing) {
    return const AsyncLoading();
  }

  final stateValues = temp.valueOrNull ?? [];
  final result = stateValues.where((element) {
    final List<PhotoPostModel> flattenedPhotos = [];
    if (element.galleryType == filter && element.postSets.isNotEmpty) {
      for (var post in element.postSets) {
        flattenedPhotos.addAll(post.photos);
      }
      element.copyWith(
          postSets: [element.postSets.first.copyWith(photos: flattenedPhotos)]);
      return true;
    }
    return false;

    // return element.galleryType == argument && element.postSets.isNotEmpty;
  }).toList();

  return AsyncData(result);
});
