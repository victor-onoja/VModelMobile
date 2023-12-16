import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/create_posts/models/post_set_model.dart';

import '../repository/gallery_repo.dart';

final galleryPostsProvider = AsyncNotifierProvider.family<GalleryPostsNotifier,
    List<AlbumPostSetModel>, int>(GalleryPostsNotifier.new);

class GalleryPostsNotifier
    extends FamilyAsyncNotifier<List<AlbumPostSetModel>, int> {
  final _repository = GalleryRepository.instance;
  int _postsTotalItems = 0;
  int _currentPage = 1;
  int _pageCount = 9;
  int _albumId = -1;

  @override
  FutureOr<List<AlbumPostSetModel>> build(arg) async {
    _albumId = arg;
    await getAlbumPosts(pageNumber: 1);
    return state.valueOrNull ?? [];
  }

  //The new paginated gallery logic
  Future<void> getAlbumPosts({required int pageNumber}) async {
    // print('[kss] get services $search');

    final albumPostsResponse = await _repository.getUserGalleryPosts(
        albumId: _albumId, pageCount: _pageCount, pageNumber: pageNumber);

    return albumPostsResponse.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      // services = null;
    }, (right) {
      try {
        _postsTotalItems = right['albumPostsTotalNumber'] as int;
        print("allServicesTotalNumber $_postsTotalItems");
        final List postData = right['albumsPosts'];
        // print("[kss1] allServices ${allServicesData.first['title']}");
        final newState = postData.map((e) => AlbumPostSetModel.fromMap(e));

        // print('[nvnv] ...... ${newState.first.user}');
        final currentState = state.valueOrNull ?? [];
        if (pageNumber == 1) {
          state = AsyncData(newState.toList());
        } else {
          print("_currentPage $_currentPage");
          if (currentState.isNotEmpty &&
              newState.any((element) => currentState.last.id == element.id)) {
            return;
          }

          state = AsyncData([...currentState, ...newState]);
        }
        _currentPage = pageNumber;

        print(postData);
      } on Exception catch (e) {
        print(e.toString());
      }
    });
  }

  Future<void> fetchMoreData() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _postsTotalItems;

    if (canLoadMore) {
      await getAlbumPosts(
        pageNumber: _currentPage + 1,
      );
      // ref.read(allServicesProvider.notifier).state =
      //     itemPositon < _serviceTotalItems;
    }
  }

  Future<void> fetchMoreHandler() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _postsTotalItems;
    // print("[55]  Fetching page:${currentPage + 1} no bounce");
    if (canLoadMore) {
      await fetchMoreData();
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < _postsTotalItems;
  }

  //
}
