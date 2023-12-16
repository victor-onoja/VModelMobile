import 'dart:async';

import 'package:either_option/either_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/dashboard/feed/model/feed_model.dart';
import 'package:vmodel/src/features/saved/controller/repository/saved_repository.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../dashboard/feed/repository/feed_repository.dart';

enum BoardProvider { allPosts, hidden, userCreated }

final savepostProvider =
    Provider<SavePostRepository>((ref) => SavePostsRepository());

final getSavedPosts =
    FutureProvider<Either<CustomException, List<dynamic>>>((ref) async {
  return ref.read(savepostProvider).getSavedPosts();
});

final getsavedPostProvider = AutoDisposeAsyncNotifierProvider<
    GetSavedPostNotifier, List<FeedPostSetModel>?>(GetSavedPostNotifier.new);

class GetSavedPostNotifier
    extends AutoDisposeAsyncNotifier<List<FeedPostSetModel>?> {
  final repo = SavedPostRes.instance;
  @override
  Future<List<FeedPostSetModel>?> build() async {
    state = AsyncLoading();

    return getSavedPosts();
  }

  Future<List<FeedPostSetModel>> getSavedPosts() async {
    final response = await repo.getSavedPosts();

    return response.fold((left) {
      print("left ${left.message}");

      return [];
    }, (right) {
      final List post = right['savedPosts'];
      print("cniejcknm $right");
      if (post.isNotEmpty) {
        return post.map<FeedPostSetModel>((e) {
          return FeedPostSetModel.fromMap(e['post']);
        }).toList();
      }
      return [];
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

        state = AsyncValue.data([
          for (final post in postList!)
            if (post.id == postId) post.copyWith(userLiked: success) else post,
        ]);
        return success;
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
      return false;
    });
  }
}

final getHiddenPostProvider = AutoDisposeAsyncNotifierProvider<
    GetHiddenPostNotifier, List<FeedPostSetModel>?>(GetHiddenPostNotifier.new);

class GetHiddenPostNotifier
    extends AutoDisposeAsyncNotifier<List<FeedPostSetModel>?> {
  final repo = SavedPostRes.instance;
  @override
  Future<List<FeedPostSetModel>?> build() async {
    state = AsyncLoading();
    return getHiddenPost();
  }

  Future<List<FeedPostSetModel>> getHiddenPost() async {
    final response = await repo.getHiddenPosts();

    return response.fold((left) {
      print("left ${left.message}");

      return [];
    }, (right) {
      final List post = right['archivedPosts'];
      print("cniejcknm $right");
      if (post.isNotEmpty) {
        return post.map<FeedPostSetModel>((e) {
          return FeedPostSetModel.fromMap(e);
        }).toList();
      }
      return [];
    });
  }
}

class SavePostNotifier extends ChangeNotifier {
  SavePostNotifier(this.ref) : super();
  final Ref ref;

  Future<Either<CustomException, Map<String, dynamic>>> savePost(
      int postId, bool saveBool) async {
    final repository = ref.read(savepostProvider);
    late Either<CustomException, Map<String, dynamic>> response;

    response = await repository.savePost(postId, saveBool);

    return response;
  }
}
