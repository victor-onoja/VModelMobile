// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../core/network/urls.dart';
import '../../../../core/repository/file_upload_service.dart';
import '../../../create_posts/models/image_upload_response_model.dart';
import '../../../dashboard/feed/repository/feed_repository.dart';
import '../../model/user_post_board_model.dart';
import '../repository/user_boards_repo.dart';
import 'board_posts_controller.dart';
import 'current_selected_board_provider.dart';
import 'recently_viewed_boards_controller.dart';

final userBoardsSearchProvider =
    StateProvider.autoDispose<String?>((ref) => '');

final userBoardsTotalNumberProvider = StateProvider<int>((ref) => 0);

final pinnedBoardsProvider =
    Provider.autoDispose<AsyncValue<List<UserPostBoard>>>((ref) {
  final boardsProvider = ref.watch(userPostBoardsProvider);
  if (boardsProvider.isLoading || boardsProvider.isRefreshing) {
    return const AsyncLoading();
  }

  // ref.onDispose(() {
  //   print('isRepost disposed ');
  // });

  final stateValues = boardsProvider.valueOrNull ?? [];
  final result = stateValues.where((element) => element.pinned).toList();

  return AsyncData(result);
});

final userPostBoardsProvider = AsyncNotifierProvider.autoDispose<
    UserPostBoardsNotifier, List<UserPostBoard>>(UserPostBoardsNotifier.new);

class UserPostBoardsNotifier
    extends AutoDisposeAsyncNotifier<List<UserPostBoard>> {
  final repo = UserPostBoardRepo.instance;
  int _totalUserBoards = 0;
  int _currentPage = 1;
  int _pageCount = 10;

  @override
  Future<List<UserPostBoard>> build() async {
    // state = AsyncLoading();
    return await getUserSavedBoards(pageNumber: _currentPage);
  }

  Future<List<UserPostBoard>> getUserSavedBoards(
      {required int pageNumber}) async {
    final searchTerm = ref.watch(userBoardsSearchProvider);
    final response = await repo.getUserCreatedBoards(
        pageNumber: pageNumber, pageCount: _pageCount, search: searchTerm);

    return response.fold((left) {
      print("left ${left.message}");

      return [];
    }, (right) {
      // final List post = right['savedPosts'];

      _totalUserBoards = right['postBoardsTotalNumber'] as int;
      ref.read(userBoardsTotalNumberProvider.notifier).state = _totalUserBoards;

      print("slko8o ${right['postBoardsTotalNumber']}");
      final boardData = right['postBoards'] as List;
      print("cn7x $right");

      print("slko8o parsed: ${boardData.length}");
      if (boardData.isNotEmpty) {
        final parsedList = boardData.map<UserPostBoard>((e) {
          print("slko8o id: ${e['id']}");
          return UserPostBoard.fromMap(e);
        }).toList();

        if (pageNumber > 1) {
          _currentPage = pageNumber;
          state =
              AsyncValue.data([...(state.valueOrNull ?? []), ...parsedList]);
        }
        return parsedList;
      }

      return [];
    });
  }

  Future<void> fetchMoreData() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _totalUserBoards;

    print('[slko8] The new problem $canLoadMore total: $_totalUserBoards');
    if (canLoadMore) {
      await getUserSavedBoards(pageNumber: _currentPage + 1);
      // ref.read(allServicesProvider.notifier).state =
      //     itemPositon < _serviceTotalItems;
    }
  }

  void updateItemState(UserPostBoard board) {
    log('xpdating user created item state with $board');
    final currentState = state.valueOrNull ?? [];
    state = AsyncData([
      for (var item in currentState)
        if (item.id == board.id) board else item,
    ]);
  }

  Future<Map<int, bool>> createPostBoardAndAddPost(String title,
      {required int postId}) async {
    final response = await repo.createPostBoard(title);

    return response.fold((left) {
      print("left ${left.message}");

      return {-1: false};
    }, (right) async {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm $right");

      if (!success) return {-1: false};
      final board = UserPostBoard.fromMap(right['postBoard']);
      final saveSuccessful =
          await savePostToBoard(postId: postId, boardId: board.id);
      if (saveSuccessful) {
        //Refresh state
        ref.invalidateSelf();
      }
      return {board.id: saveSuccessful};
    });
  }

  Future<bool> createPostBoard(String title) async {
    final response = await repo.createPostBoard(title);

    return response.fold((left) {
      print("left ${left.message}");

      return false;
    }, (right) {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm $right");
      if (success) {
        //Refresh state
        ref.invalidateSelf();
      }
      return success;
    });
  }

  Future<bool> savePostToBoard({required int postId, int? boardId}) async {
    final response =
        await repo.savePostToBoard(postId: postId, boardId: boardId);

    return response.fold((left) {
      print("left ${left.message}");

      return false;
    }, (right) {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm boardID: $boardId, result: $right");
      if (success) {
        //Refresh state
        ref.invalidateSelf();
      }
      return success;
    });
  }

  Future<bool> renameUserBoard(
      {required int boardId, required String newTitle}) async {
    final mTitle = newTitle.trim();
    if (mTitle.isEmpty) return false;
    final response =
        await repo.renameUserBoard(boardId: boardId, title: mTitle);

    return response.fold((left) {
      print("left $boardId ${left.message}");
      return false;
    }, (right) {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm $right");
      if (success) {
        //Refresh state
        ref.invalidateSelf();
      }
      return success;
    });
  }

  Future<bool> deleteUserBoard({required int boardId}) async {
    final response = await repo.deleteUserBoard(boardId: boardId);

    return response.fold((left) {
      print("left ${left.message}");

      return false;
    }, (right) {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm $right");
      if (success) {
        //Refresh state

        ref.invalidateSelf();
      }
      return success;
    });
  }

  Future<bool> deletePostFromBoard({required int postId, int? boardId}) async {
    final response =
        await repo.deleteSavedPostFromBoard(postId: postId, boardId: boardId);

    return response.fold((left) {
      print("left ${left.message}");

      return false;
    }, (right) {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm $right");
      if (success) {
        //Refresh state

        ref.invalidateSelf();
      }
      return success;
    });
  }

  Future<bool> togglePinnedStatus({required int boardId}) async {
    // final currentState = state.valueOrNull ?? [];
    // final pinnedStatus =
    // currentState.firstWhere((element) => element.id == boardId).pinned;
    final currentBoardState =
        ref.watch(currentSelectedBoardProvider.notifier).currentState;

    if (currentBoardState == null) return false;

    //pinned
    final response = currentBoardState.board.pinned
        ? await repo.unpinPostBoard(boardId: boardId)
        : await repo.pinPostBoard(boardId: boardId);

    return response.fold((left) {
      print("left ${left.message}");

      return false;
    }, (right) {
      bool success = (right['success'] as bool?) ?? false;
      print("cniejcknm $right");
      if (success) {
        final updatedBoard = currentBoardState.board.copyWith(
            pinned: !currentBoardState.board.pinned,
            title:
                '${currentBoardState.board.title} ${currentBoardState.board.pinned}');
        ref
            .read(currentSelectedBoardProvider.notifier)
            .setOrUpdateBoard(currentBoardState.copyWith(board: updatedBoard));
        switch (currentBoardState.source) {
          case SelectedBoardSource.recent:
          case SelectedBoardSource.userCreatd:
            updateItemState(updatedBoard);

            ref
                .read(recentlyViewedBoardsProvider.notifier)
                .updateItemState(updatedBoard);
            break;
          default:
            break;
        }

        //Refresh state
        // ref.invalidateSelf();
      }
      return success;
    });
  }

  Future<bool> onLikePost({required int postId}) async {
    print("AAAAAAA liking post $postId");
    final response = await FeedRepository.instance.likePost(postId);
    return response.fold((left) {
      print(
          "AAAAAAA error parsing json response ${left.message} ${StackTrace.current}");
      return false;
    }, (right) {
      try {
        final bool success = right['success'] as bool;
        final postList = state.value;

        // state = AsyncValue.data([
        //   for (final post in postList!)
        //     if (post.id == postId) post.copyWith(userLiked: success) else post,
        // ]);
        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
      return false;
    });
  }

  Future<bool> setPostBoardCoverImage(
      {required int boardId, String? imageUrl, File? selectedImage}) async {
    log('os33 $boardId \nimg: $imageUrl, \nfile: $selectedImage');
    final isFileAvailable = await selectedImage?.exists() ?? false;

    String? uploadedImageUrl;
    if (isFileAvailable) {
      final temp = await _uploadBanner([selectedImage!]);

      if (temp == null || temp.isEmpty) {
        print('Board cover image upload failed');
        return false;
      }
      uploadedImageUrl = temp.first['url'];
      print('osx8 ${uploadedImageUrl}');
    }

    log('os33b $uploadedImageUrl');
    final coverImageUrl = uploadedImageUrl ?? imageUrl;
    print('osx8b ${coverImageUrl}');
    if (coverImageUrl.isEmptyOrNull) return false;

    final response = await repo.setBoardCoverImage(
        boardId: boardId, imageUrl: coverImageUrl!);

    print('osx8p ${response}');
    return response.fold((left) {
      print("left ${left.message}");

      return false;
    }, (right) {
      print("cn3o $right");
      bool success = (right['success'] as bool?) ?? false;
      if (success) {
        //Refresh state
        // Todo: update crude update logic below

        final currentBoardState =
            ref.watch(currentSelectedBoardProvider.notifier).currentState;

        if (currentBoardState == null) {
          //refetch all data
          print('[iow9] currentBoardState is null in change cover');
          ref.invalidate(recentlyViewedBoardsProvider);
          ref.invalidateSelf();
        }

        final updatedBoard =
            currentBoardState!.board.copyWith(coverImageUrl: coverImageUrl);
        ref
            .read(currentSelectedBoardProvider.notifier)
            .setOrUpdateBoard(currentBoardState.copyWith(board: updatedBoard));
        updateItemState(updatedBoard);
        ref
            .read(recentlyViewedBoardsProvider.notifier)
            .updateItemState(updatedBoard);
      }
      print("cn3oi $success");
      return success;
    });
  }

  Future<List<dynamic>?> _uploadBanner(List<File> images) async {
    print('[vv] calling upload banner');
    final uploadResult = await FileUploadRepository.instance
        .uploadFiles(images, uploadEndpoint: VUrls.postMediaUploadUrl,
            onUploadProgress: (sent, total) {
      final percentage = sent / total;
      print('[$percentage] service banner progress $sent \\ $total');
      // ref.read(uploadProgressProvider.notifier).state = sent / total;
    });

    return uploadResult.fold((left) {
      print("Error ${left.message}");
      // VWidgetShowResponse.showToast(ResponseEnum.failed,
      //     message: "Error uploading service banner");
      return null;
    }, (right) {
      print('[vv] service banner progress $right');
      if (right == null) {
        return null;
      }

      final map = json.decode(right);
      final uploadedFilesMap = map["data"] as List<dynamic>;
      String baseUrl = map['base_url'] ?? '';
      if (uploadedFilesMap.isNotEmpty) {
        final objs = uploadedFilesMap
            .map((e) => ImageUploadResponseModel.fromMap(baseUrl, e))
            .toList();
        // print("!!!!!!!!!!!!!!!!! ${objs.first.toApiTypeMap(caption)}");

        final filesToPost = objs.map((e) => e.toFileAndThumbnailMap).toList();
        return filesToPost;
        // print('[vv] $tmp');
        // return tmp;
      }
      return null;
    });
  }
}
