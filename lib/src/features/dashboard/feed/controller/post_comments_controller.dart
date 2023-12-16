import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/repository/post_comments_repository.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../model/post_comment_model_temp.dart';
import 'post_comment_replies_controller.dart';

final postCommentsProvider = AsyncNotifierProvider.family
    .autoDispose<PostCommentNotifier, List<NewPostCommentsModel>, int>(
        PostCommentNotifier.new);

class PostCommentNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<NewPostCommentsModel>, int> {
  final _repository = PostCommentsRepository.instance;
  int _pageCount = 15;
  int _currentPage = 1;
  int _totalComment = 0;
  @override
  FutureOr<List<NewPostCommentsModel>> build(int postId) async {
    return await getPostComments(postId: postId, pageNumber: _currentPage);
  }

  // @override
  // Future<FutureOr<List<NewPostCommentsModel>>> build(arg) async {

  //   return  await getPostComments();
  // }

  Future<List<NewPostCommentsModel>> getPostComments({
    required int postId,
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      print("[erw] omment $postId");
      final response = await _repository.getPostComments(
          postId: postId, pageCount: _pageCount);
      return response.fold((left) {
        print("faild to get comment ${left.message}");

        return [];
      }, (right) {
        // print("lent${right}");
        _totalComment = right['postCommentsTotalNumber'];
        // print("postCommentsTotalNumber ${right['postComments'][0]}");
        final list = right['postComments'] as List;
        // final currentData = state.value;
        // state = AsyncValue.data(currentData!);

        if (list.isNotEmpty) {
          final comments = list
              .map<NewPostCommentsModel>((e) =>
                  NewPostCommentsModel.fromMap(e as Map<String, dynamic>))
              .toList();

          // for (var x in comments) {
          // }
          return comments;
        }
        return [];
      });
    } catch (e) {
      return [];
    }
  }

  Future<void> savePostComments({
    required int postId,
    required String comment,
  }) async {
    //  final List<NewPostCommentsModel> commentList = state.valueOrNull ?? [];
    try {
      final response =
          await _repository.savePostComments(postId: postId, comment: comment);
      response.fold((left) {
        print("faild to save comment${left.message}");
        return [];
      }, (right) {
        print("comment saved ${right}");
        final newComment = NewPostCommentsModel.fromMap(right);
        final currentData = state.value;
        state = AsyncValue.data([newComment, ...?currentData]);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> replyComment({
  //   required int commentId,
  //   required String reply,
  // }) async {
  //   //  final List<NewPostCommentsModel> commentList = state.valueOrNull ?? [];
  //   try {
  //     final response =
  //         await _repository.replyComment(commentId: commentId, reply: reply);
  //     response.fold((left) {
  //       print("faild to reply comment ${left.message}");
  //       return [];
  //     }, (right) {
  //       // print("reply saved ${right}");
  //       // final newComment = NewPostCommentsModel.fromJson(right);
  //       // final currentData = state.value;
  //       // state = AsyncValue.data([newComment, ...?currentData]);
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<List<NewPostCommentsModel>> replyPostCommentReplies({
  //   required int commentId,
  //   int? pageCount,
  //   int? pageNumber,
  // }) async {
  //   //  final List<NewPostCommentsModel> commentList = state.valueOrNull ?? [];
  //   try {
  //     final response = await _repository.getPostCommentsReplies(
  //       commentId: commentId,
  //       pageCount: pageCount,
  //       pageNumber: pageNumber,
  //     );
  //     return response.fold((left) {
  //       print("faild to reply comment${left.message}");
  //       return [];
  //     }, (right) {
  //       print("reply saved ${right}");
  //       final list = right;
  //       // final currentData = state.value;
  //       // state = AsyncValue.data(currentData!);

  //       if (list.isNotEmpty) {
  //         return list
  //             .map<NewPostCommentsModel>((e) =>
  //                 NewPostCommentsModel.fromMap(e as Map<String, dynamic>))
  //             .toList();
  //       }
  //       return [];
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return [];
  //   }
  // }

  Future<void> fetchMoreData(int postId) async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _totalComment;

    if (canLoadMore) {
      await getPostComments(postId: postId, pageNumber: _currentPage + 1);
      // ref.read(allServicesProvider.notifier).state =
      //     itemPositon < _serviceTotalItems;
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < _totalComment;
  }

  Future<void> deleteComment(
      {required int commentId, required int? rootCommentId}) async {
    try {
      final response = await _repository.deleteComment(commentId: commentId);
      response.fold((left) {
        print("faild to delete comment${left.message}");
        return [];
      }, (right) {
        print("comment deleted ${right}");
        VWidgetShowResponse.showToast(ResponseEnum.sucesss,
            message: 'Comment $commentId deleted');
        ref.invalidateSelf();
        if (rootCommentId != null)
          ref.invalidate(commentRepliesProvider(rootCommentId));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
