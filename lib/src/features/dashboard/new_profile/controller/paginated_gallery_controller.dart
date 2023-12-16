import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/gallery_model.dart';
import '../repository/gallery_repo.dart';

final onlyAlbumsProvider =
    AsyncNotifierProvider.autoDispose<AllAlbumsNotifier, List<GalleryModel>>(
        AllAlbumsNotifier.new);

class AllAlbumsNotifier extends AutoDisposeAsyncNotifier<List<GalleryModel>> {
  @override
  Future<List<GalleryModel>> build() async {
    final response =
        await GalleryRepository.instance.getUserGalleriesOnly(username: null);
    return response.fold((left) {
      return [];
    }, (right) {
      try {
        print('[okok] $right');
        final result = right.map((e) => GalleryModel.fromMap(e));
        return result.toList();
      } catch (e) {
        return [];
      }
    });
  }
}


/*
final albumOOO = AsyncNotifierProvider.autoDispose
    .family<PaginatedAlbumPostsNotifier, List<AlbumPostSetModel>, int>(
        PaginatedAlbumPostsNotifier.new);

class PaginatedAlbumPostsNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<AlbumPostSetModel>, int> {
  final _repository = GalleryRepository.instance;
  final defaultCount = 3 * 7;
  int currentPage = 1;
  int postsTotalNumber = 0;

  @override
  Future<List<AlbumPostSetModel>> build(arg) async {
    final response = await GalleryRepository.instance
        .paginatedGalleryPosts(albumId: arg, pageCount: 10, pageNumber: 1);
    return response.fold((left) {
      return [];
    }, (right) {
      try {
        print('[okok] $right');
        final result = right.map((e) => AlbumPostSetModel.fromMap(e));
        return result.toList();
      } catch (e) {
        return [];
      }
    });
  }

  Future<void> fetchMoreFeedData({required int page}) async {
    final response = await GalleryRepository.instance
        .paginatedGalleryPosts(albumId: arg, pageCount: 10, pageNumber: 1);
    return response.fold((left) {
      print(
          "8888888888888 () error in build ${left.message} ${StackTrace.current}");
      // return AsyncError(left.message, StackTrace.current);
      // feeds = null;
    }, (right) {
      try {
        postsTotalNumber = right['albumPostsTotalNumber'] ?? 0;
        final res = right['albumPosts'] as List;
        print('################## %%%% $res');

        final result = right.map((e) => AlbumPostSetModel.fromMap(e));
        // feeds?.addAll(newState);

        // state = AsyncData()[...state, ...newState];
        final currentState = state.valueOrNull ?? [];
        if (page == 1) {
          state = AsyncData(newState.toList());
        } else {
          if (currentState.isNotEmpty &&
              newState.any((element) => currentState.last.id == element.id)) {
            return;
          }
          state = AsyncData([...currentState, ...newState]);
        }
        currentPage = page;
        print("++++++++++++++++++++++++++++++++\n $newState \n");
        // return feeds;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
        feeds = null;
        // return null;
      }
    });
  }
}
*/