import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/enum/album_type.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../../../create_posts/controller/create_post_controller.dart';
import '../model/gallery_feed_page_data_model.dart';
import '../model/gallery_model.dart';
import '../model/user_gallery_only_model.dart';
import '../repository/gallery_repo.dart';

final galleryFeedDataProvider = StateProvider<GalleryFeedDataModel?>((ref) {
  return null;
});

final showCurrentUserProfileFeedProvider =
    StateProvider.autoDispose<bool>((ref) {
  return false;
});

final enableOtherUserPolaroidProvider = StateProvider<bool>((ref) {
  // final temp = ref.watch(galleryProvider('gg500').notifier);
  // final galleries = temp.valueOrNull;
  // temp.getPolaroidGalleries();
  return false;
});

final galleryTypeFilterProvider =
    StateProvider.family<AlbumType, String?>((ref, arg) => AlbumType.portfolio);

final filteredGalleryListProvider =
    Provider.family<AsyncValue<List<GalleryModel>>, String?>((ref, argument) {
  final filter = ref.watch(galleryTypeFilterProvider(argument));
  final temp = ref.watch(galleryProvider(argument));
  final isInitialLoadOrRefresh = ref.watch(isInitialOrRefreshGalleriesLoad);
  // print('isRepost $isRepost');
  if (temp.isLoading || temp.isRefreshing) {
    // if (isInitialLoadOrRefresh) {
    return const AsyncLoading();
  }

  ref.onDispose(() {
    print('isRepost disposed ');
  });

  final stateValues = temp.valueOrNull ?? [];
  final result = stateValues
      .where((element) =>
          element.galleryType == filter && element.postSets.isNotEmpty)
      .toList();

  // if (temp.isLoading || temp.isRefreshing) {
  return AsyncData(result);
});

final galleryProvider =
    AsyncNotifierProvider.family<GalleryNotifier, List<GalleryModel>, String?>(
        () => GalleryNotifier());

class GalleryNotifier extends FamilyAsyncNotifier<List<GalleryModel>, String?> {
  final _repository = GalleryRepository.instance;

  @override
  Future<List<GalleryModel>> build(arg) async {
    print(
        '-------LLLLLLLL-----------Rebuildddding gallery nnotifierrrrrrr with username $arg');
    state = const AsyncLoading();

    final response = await _repository.getUserPortfolioGalleries(username: arg);
    response.fold((left) {
      return [];
    }, (right) {
      // ref.read(isInitialOrRefreshGalleriesLoad.notifier).state = false;
      final List<UserGalleryOnlyModel> galleryList = [];
      if (right.isNotEmpty) {
        for (Map<String, dynamic> value in right) {
          // print('<<<<<<<<<<<<<<GGGGGGGGGGGGGGGGGGGG>>>>>>>>>>>> ${x['name']}');
          // final ab = x['postSet'] as List<Map<String, dynamic>>;
          try {
            final gallery = UserGalleryOnlyModel.fromMap(value);
            // if(gallery.postSets.isNotEmpty) {
            galleryList.add(gallery);
            // }
          } catch (e, stackTrack) {
            print('[uwuw1] $e $stackTrack');
          }
        }
        print('[uwuw2] $galleryList');

        // final albumPostsResponse = await _repository.getUserGalleryPosts(albumId: arg);

        // final sss = galleryList.any((element) =>
        //     element.galleryType == AlbumType.polaroid &&
        //     element.postSets.isNotEmpty);
        // ref.read(enableOtherUserPolaroidProvider.notifier).state = sss;

        // return galleryList;
        // return right
        //     .map<GalleryModel>(
        //         (e) => AlbumModel.fromMap(e as Map<String, dynamic>))
        //     .toList();
      }
      return [];
    });

    final res = await _repository.getUserGalleries(username: arg);
    return res.fold((left) {
      return [];
    }, (right) {
      ref.read(isInitialOrRefreshGalleriesLoad.notifier).state = false;
      final List<GalleryModel> galleryList = [];
      if (right.isNotEmpty) {
        for (Map<String, dynamic> value in right) {
          // print('<<<<<<<<<<<<<<GGGGGGGGGGGGGGGGGGGG>>>>>>>>>>>> ${x['name']}');
          // final ab = x['postSet'] as List<Map<String, dynamic>>;
          try {
            final gallery = GalleryModel.fromMap(value);
            // if(gallery.postSets.isNotEmpty) {
            galleryList.add(gallery);
            // }
          } catch (e, stackTrack) {
            print(
                '<<<<<<<<<<<<<<GGGGGGGGGGGGGGGGGGGG>>>>>>>>>>>> $e $stackTrack');
          }
        }

        final sss = galleryList.any((element) =>
            element.galleryType == AlbumType.polaroid &&
            element.postSets.isNotEmpty);
        ref.read(enableOtherUserPolaroidProvider.notifier).state = sss;

        return galleryList;
        // return right
        //     .map<GalleryModel>(
        //         (e) => AlbumModel.fromMap(e as Map<String, dynamic>))
        //     .toList();
      }
      return [];
    });
  }

//Todo: Temp measure remove after all posts are migrated to thumbnails
  // void sss(String galleryId, String postId) {
  //   final temp = state.valueOrNull ?? [];
  //   final gal = temp.firstWhere((element) => element.id == galleryId);
  //   final postSet = gal.postSets;
  //   // final postSet = gal.postSets.firstWhere((element) => '${element.id}' == postId);
  //   for (var x in postSet) {
  //     if('${x.id}' == postId) {
  //       x.copyWith(photos: )
  //     }
  //   }
  // }

  // List<GalleryModel> getPolaroidGalleries() {
  //   final plGalleries = state.valueOrNull ?? [];
  //   return plGalleries
  //       .where((element) => element.galleryType == AlbumType.polaroid)
  //       .toList();
  // }

  Future<void> createAlbum(String albumName, AlbumType albumType) async {
    final result = await _repository.createAlbum(
        name: albumName, albumType: albumType.name);

    result.fold(
      (left) {
        // Handle error
        print('Failed to create album: ${left.message}');
      },
      (right) {
        // Handle success
        final albumId = right['id'];
        final albumName = right['name'];
        final newAlbum = GalleryModel.fromMap(right);
        final temp = state.value ?? [];
        temp.add(newAlbum);
        state = AsyncData(temp);
        print('Album created successfully! ID: $albumId, Name: $albumName');
        // Optionally, you can update the UI with the new album or refresh the albums list
      },
    );
  }

  Future<void> deleteGallery(
      {required int galleryId, required String userPassword}) async {
    final response = await _repository.deleteGallery(
        galleryId: galleryId, password: userPassword);

    response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Failed to delete gallery");
      print('Error deleting gallery ${left.message} ${StackTrace.current}');
    }, (right) {
      final bool success = right['success'] ?? false;
      if (success) {
        state.value
            ?.removeWhere((element) => element.id == galleryId.toString());
      }
      print('Success deleting gallery $right');
      return null;
    });
  }

  Future<void> upadetGalleryName(
      {required int galleryId, required String name}) async {
    final response = await _repository.updateGalleryName(
        galleryId: galleryId, newName: name);

    response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Failed to rename gallery");
      print('Error renaming gallery ${left.message} ${StackTrace.current}');
    }, (right) {
      final response = right['album'];
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: "${right['message']}");
      if (response != null) {
        final galleries = state.valueOrNull ?? [];
        state = AsyncValue.data([
          for (final gallery in galleries)
            if (galleryId.toString() == gallery.id)
              gallery.copyWith(
                name: response['name'] ?? gallery.name,
              )
            else
              gallery,
        ]);
      }
      print('Success renaming gallery $right');

      return;
    });
  }

  Future<bool> onLikePost(
      {required String galleryId, required int postId}) async {
    print("AAAAAAA liking post $postId");
    final response = await _repository.likePost(postId);
    return response.fold((left) {
      print(
          "AAAAAAA error parsing json response ${left.message} ${StackTrace.current}");
      return false;
    }, (right) {
      try {
        final bool success = right['success'] as bool;
        final galleryList = state.value;

        state = AsyncValue.data([
          for (final gallery in galleryList!)
            if (gallery.id == galleryId)
              gallery.copyWith(
                  postSets: gallery.postSets.map((element) {
                if (element.id == postId) {
                  return element.copyWith(userLiked: !element.userLiked);
                } else {
                  return element;
                }
              }).toList())
            else
              gallery,
        ]);
        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
      return false;
    });
  }

  Future<bool> onSavePost(
      {required String galleryId,
      required int postId,
      required bool currentValue}) async {
    print("AAAAAAA saving post $postId");
    final response = await _repository.savePost(postId);
    return response.fold((left) {
      print(
          "AAAAAAA error parsing json response ${left.message} ${StackTrace.current}");
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message:
              currentValue ? 'Saving post failed' : 'Unsaving post failed');
      return false;
    }, (right) {
      try {
        final bool success = right['success'] as bool;
        final galleryList = state.value;

        if (success) {
          VWidgetShowResponse.showToast(ResponseEnum.warning,
              message:
                  currentValue ? 'Removed from boards' : 'Added to boards');

          state = AsyncValue.data([
            for (final gallery in galleryList!)
              if (gallery.id == galleryId)
                gallery.copyWith(
                    postSets: gallery.postSets.map((element) {
                  if (element.id == postId) {
                    return element.copyWith(userSaved: !element.userSaved);
                  } else {
                    return element;
                  }
                }).toList())
              else
                gallery,
          ]);
        }
        print("AAAAAAA saving post success status: $success");
        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
        VWidgetShowResponse.showToast(ResponseEnum.failed,
            message:
                currentValue ? 'Saving post failed' : 'Unsaving post failed');
      }
      return false;
    });
  }

  Future<bool> deletePost({required int postId}) async {
    print("AAAAAAA deleting post $postId");
    final response = await _repository.deletePost(postId);
    // final Either<CustomException, Map<String, dynamic>> response =
    //     Right({"status": true});
    return response.fold((left) {
      print("AAAAAAA on Left ${left.message} ${StackTrace.current}");
      return false;
    }, (right) {
      print("AAAAAAA in right $right");
      try {
        final bool success = right['status'] as bool;
        final galleryList = state.valueOrNull ?? [];

        print('HHHHHHH ${galleryList.first.postSets.length}');
        if (success) {
          for (final gallery in galleryList) {
            gallery.postSets.removeWhere((element) => element.id == postId);
          }
          print('FFFFFFF ${galleryList.first.postSets.length}');
          state = AsyncData(galleryList);
          // state = AsyncValue.data([
          //   for (final gallery in galleryList!)
          // if (gallery.id == galleryId)
          //   gallery.copyWith(
          //       postSets: gallery.postSets.map((element) {
          //     if (element.id == postId) {
          //       return element.copyWith(userLiked: !element.userLiked);
          //     } else {
          //       return element;
          //     }
          //   }).toList())
          // else
          // gallery,
          // ]);
        }

        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
      return false;
    });
  }

  Future<bool> getPostThumbnail({required int postId}) async {
    print("AAAAAAA deleting post $postId");
    final response = await _repository.deletePost(postId);
    // final Either<CustomException, Map<String, dynamic>> response =
    //     Right({"status": true});
    return response.fold((left) {
      print("AAAAAAA on Left ${left.message} ${StackTrace.current}");
      return false;
    }, (right) {
      print("AAAAAAA in right $right");
      try {
        final bool success = right['status'] as bool;
        final galleryList = state.valueOrNull ?? [];

        print('HHHHHHH ${galleryList.first.postSets.length}');
        if (success) {
          for (final gallery in galleryList) {
            gallery.postSets.removeWhere((element) => element.id == postId);
          }
          print('FFFFFFF ${galleryList.first.postSets.length}');
          state = AsyncData(galleryList);
          // state = AsyncValue.data([
          //   for (final gallery in galleryList!)
          // if (gallery.id == galleryId)
          //   gallery.copyWith(
          //       postSets: gallery.postSets.map((element) {
          //     if (element.id == postId) {
          //       return element.copyWith(userLiked: !element.userLiked);
          //     } else {
          //       return element;
          //     }
          //   }).toList())
          // else
          // gallery,
          // ]);
        }

        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
      return false;
    });
  }

  // Future<void> createAlbum(String albumName) async {
  // final result = await _repository.createAlbum(name: albumName);
  //
  //   result.fold(
  //         (left) {
  //       // Handle error
  //       print('Failed to create album: ${left.message}');
  //     },
  //         (right) {
  //       // Handle success
  //       final albumId = right['id'];
  //       final albumName = right['name'];
  //       final newAlbum = AlbumModel.fromMap(right);
  //       final temp = state.value ?? [];
  //       //Todo implement
  //       // temp.add(newAlbum);
  //       state = AsyncData(temp);
  //       print('Album created successfully! ID: $albumId, Name: $albumName');
  //       // Optionally, you can update the UI with the new album or refresh the albums list
  //     },
  //   );
  // }
}
