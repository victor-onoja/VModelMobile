import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/create_posts/models/album_model.dart';
import 'package:vmodel/src/features/create_posts/repository/create_post_repo.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/gallery_controller.dart';

import '../../../core/models/post_photo_thumbnail_model.dart';
import '../../../core/network/urls.dart';
import '../../../core/utils/enum/album_type.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../shared/response_widgets/toast.dart';
import '../models/image_upload_response_model.dart';
import '../models/photo_post_model.dart';
import 'cropped_data_controller.dart';

///Used to implement gallery thumbnail creation logic
final isInitialOrRefreshGalleriesLoad = StateProvider<bool>((ref) => true);

final uploadProgressProvider = StateProvider((ref) => -1.0);

final createPostProvider = AutoDisposeAsyncNotifierProvider.family<
    CreatePostNotifier, List<AlbumModel>, String?>(() => CreatePostNotifier());

class CreatePostNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<AlbumModel>, String?> {
  final _repository = CreatePostRepository.instance;
  // List<File> selectedImages = [];
  final List<File> selectedPhotosToPost = [];

  @override
  Future<List<AlbumModel>> build(arg) async {
    state = const AsyncLoading();
    print('in AsyncBuild..............');
    List<AlbumModel>? albums;

    final res = await _repository.getAlbums(username: arg);
    return res.fold((left) {
      print('in AsyncBuild left is .............. ${left.message}');

      return [];
    }, (right) {
      print('in AsyncBuild rieght is .............. $right');

      if (right.isNotEmpty) {
        return right
            .map<AlbumModel>(
                (e) => AlbumModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }

  List<AlbumModel> filterAlbumsByType(AlbumType type) {
    final currentState = state.valueOrNull ?? [];
    return currentState.where((element) => element.albumType == type).toList();
  }

  Future<void> createPost({
    required String albumId,
    required UploadAspectRatio aspectRatio,
    List<File>? images,
    List<Uint8List>? rawBytes,
    required String caption,
    String? location,
    List<String>? tagged,
    String? serviceId,
  }) async {
    print('$tagged|||||------||||||| Uploading to posts to album id $albumId');

    assert((images != null && rawBytes == null) ||
        (images == null && rawBytes != null));

    print('$tagged[[[[[[[[[[[[[[[[[[[ satisfied');
    //Upload files to bucket first
    if (albumId.isEmpty) {
      //Todo show toast to create a new album
      VWidgetShowResponse.showToast(
        ResponseEnum.failed,
        message: 'Please create an album first',
      );
      return;
    }

    //Set it to zero percent so that we can go back to the post page when there
    //is an error.
    ref.read(uploadProgressProvider.notifier).state = 0.01;
    final Either<CustomException, String?> uploadResult;
    if (images != null) {
      uploadResult = await _repository.uploadFiles(
          VUrls.postMediaUploadUrl, images, onUploadProgress: (sent, total) {
        final percentage = sent / total;
        print('[$percentage] @@@@@@@@@@@@@@@@@@@@ $sent \\ $total');
        ref.read(uploadProgressProvider.notifier).state = sent / total;
      });
    } else {
      uploadResult = await _repository.uploadRawBytesList(
          VUrls.postMediaUploadUrl, rawBytes!, onUploadProgress: (sent, total) {
        final percentage = sent / total;
        print('[$percentage] @@@@@@@@@@@@@@@@@@@@ $sent \\ $total');
        ref.read(uploadProgressProvider.notifier).state = sent / total;
      });
    }

    uploadResult.fold((left) {
      print("Error ${left.message}");
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Error uploading files");
      //clear contents to free memory
      _resetUploadIndicator();
    }, (right) async {
      if (right == null) {
        return;
      }
      HapticFeedback.mediumImpact();
      final map = json.decode(right);
      final uploadedFilesMap = map["data"] as List<dynamic>;
      String baseUrl = map['base_url'] ?? '';
      if (uploadedFilesMap.isNotEmpty) {
        final objs = uploadedFilesMap
            .map((e) => ImageUploadResponseModel.fromMap(baseUrl, e))
            .toList();
        print("!!!!!!!!!!!!!!!!! ${objs.first.toApiTypeMap(caption)}");

        final filesToPost = objs.map((e) => e.toApiTypeMap(caption)).toList();

        //Send responsed from upload to backend API
        final apiResponse = await _repository.postContent(
            albumId: albumId,
            aspectRatio: aspectRatio.apiValue,
            caption: caption,
            locationInfo: location,
            filesMap: filesToPost,
            tagged: tagged ?? [],
            serviceId: int.tryParse(serviceId ?? ''));
        apiResponse.fold((left) {
          print('MMMMMMMMMMMM Left is ${left.message}');
          // VWidgetShowResponse.showToast(ResponseEnum.failed,
          //     message: "Failed to create post ${left.message}");
          _resetUploadIndicator();
        }, (right) {
          // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          //     message: "Post created successfully");
          // ref.read(profileProvider.notifier).getUserPosts();
          // ref.invalidate(profileProvider);

          // toastContainer(text: "Post uploaded successful");

          ref.invalidate(galleryProvider(null));
          //clean up
          HapticFeedback.mediumImpact();
          _resetUploadIndicator();
        });
      }
      //set to -1 to show upload is done
    });
  }

  Future<void> createPostThumbnailOnly({
    bool invalidateGallery = true,
    required String postId,
    required List<PhotoPostModel> photos,
    // List<File>? images,

    // List<Uint8List>? rawBytes,
    // required String caption,
    // String? location,
    // List<String>? tagged,
  }) async {
    // print('$tagged|||||------||||||| Uploading to posts to album id $albumId');

    // assert((images != null && rawBytes == null) ||
    //     (images == null && rawBytes != null));

    // final values = await photos.map((e) {
    //   return cachePath(e.url);
    // });
    print('[lsus] started...');
    ref.read(isInitialOrRefreshGalleriesLoad.notifier).state = false;
    // final List<PostPhotoThumbnail> values = [];
    // final Either<CustomException, String?> uploadResult;
    final List<Future<Either<CustomException, String?>>> uploadResult = [];

    for (var x in photos) {
      final dFile = await cachePath(x.url);
      // values.add(await dFile.readAsBytes());
      final fileBuffer = await dFile.readAsBytes();
      // values.add(PostPhotoThumbnail(postId: postId, thumbnailUrl: []));

      uploadResult.add(_repository
          .uploadRawBytesList(VUrls.postThumbnailOnlyUrl, [fileBuffer],
              onUploadProgress: (sent, total) {
        final percentage = sent / total;
        print('[$percentage] @@@@@@@@@@@@@@@@@@@@ $sent \\ $total');
        ref.read(uploadProgressProvider.notifier).state = sent / total;
      }));

      // uploadResult.fold((left) {
      //   print('Failed uploading post thumbanail only');
      // }, (right) {
      //   return null;
      // });
// values.add(PostPhotoThumbnail(postId: postId, thumbnailUrl: ThumbnailUrl(photoId: photoId, thumbnail: thumbnail)))
    }

    final ups = await Future.wait(uploadResult);

    int ssi = 0;
    final List<Map<String, dynamic>> thmbs = [];
    for (int i = 0; i < ups.length; i++) {
      ups[i].fold((left) {
        print('[lsus] Left Failed upload index $ssi');
      }, (right) {
        final map = json.decode(right!);
        List sssk = map['data'] as List;
        String baseUrl = map['base_url'] ?? '';
        print('[lsus] right is $right');
        final thmbUrl = ThumbnailUrl.fromMap(photos[i].id, baseUrl, sssk.first);
        thmbs.add(thmbUrl.toMap());
        print('[lsus] parent: ${photos[i].url} thumb: ${thmbUrl.thumbnail}');
      });
    }

    final apiResponse =
        await _repository.uploadPhotoThumbnail(postId: postId, data: thmbs);

    if (invalidateGallery) ref.invalidate(galleryProvider);

    return;
  }

  Future<void> editPost({
    required int postId,
    String? caption,
    String? locationName,
    List<String>? taggedUsers,
  }) async {
    final result = await _repository.editPost(
      postId: postId,
      caption: caption,
      locationName: locationName,
      taggedUsers: taggedUsers,
    );

    result.fold(
      (left) {
        // Handle error
        print('Failed to create album: ${left.message}');
      },
      (right) {
        // Handle success
        print('Post updated successfully! $right');
        // Optionally, you can update the UI with the new album or refresh the albums list
      },
    );
  }

  void _resetUploadIndicator() {
    // ref.read(croppedImagesToUploadProviderx.notifier).state = [];
    ref.read(croppedImagesProvider.notifier).clearAll();
    ref.read(uploadProgressProvider.notifier).state = -1;
  }
}
