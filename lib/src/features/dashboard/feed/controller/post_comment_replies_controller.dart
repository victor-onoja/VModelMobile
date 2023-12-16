import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/feed/repository/post_comments_repository.dart';

import '../model/post_comment_model_temp.dart';

final commentRepliesTotalProvider =
    StateProvider.autoDispose.family<int, int>((ref, id) {
  return 0;
});

final commentRepliesProvider = AsyncNotifierProvider.family
    .autoDispose<PostCommentNotifier, List<NewPostCommentsModel>, int>(
        PostCommentNotifier.new);

class PostCommentNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<NewPostCommentsModel>, int> {
  final _repository = PostCommentsRepository.instance;
  int _pageCount = 3;
  int _currentPage = 1;
  int _totalComment = 0;
  int _rootCommentId = -1;

  @override
  FutureOr<List<NewPostCommentsModel>> build(int rootCommentId) async {
    _rootCommentId = rootCommentId;
    return await getCommentReplies(pageNumber: _currentPage);
  }

  // @override
  // Future<FutureOr<List<NewPostCommentsModel>>> build(arg) async {

  //   return  await getPostComments();
  // }

  Future<List<NewPostCommentsModel>> getCommentReplies({
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      print("[kdat] pageNumber = $pageNumber");
      print("[kdat] replied $_rootCommentId");
      final response = await _repository.getPostCommentsReplies(
          commentId: _rootCommentId,
          pageCount: _pageCount,
          pageNumber: pageNumber);
      return response.fold((left) {
        print("[kdat] fail replied $_rootCommentId");

        return [];
      }, (right) {
        print("[erw] success replied $right");
        // print("lent${right}");
        _totalComment = right['commentRepliesTotalNumber'];
        ref.read(commentRepliesTotalProvider(_rootCommentId).notifier).state =
            _totalComment;
        // print("postCommentsTotalNumber ${right['postComments'][0]}");
        final list = right['commentReplies'] as List;
        // final list = right;
        // final currentData = state.value;
        // state = AsyncValue.data(currentData!);
        List<NewPostCommentsModel> parsedList = [];

        if (list.isNotEmpty) {
          parsedList = list.map<NewPostCommentsModel>((e) {
            print("[rrp33] [$pageNumber] current models ${e['id']}");
            return NewPostCommentsModel.fromMap(e as Map<String, dynamic>);
          }).toList();

          print("[erw] current models ${parsedList.length}");
        }
        if (pageNumber != null && pageNumber > 1) {
          _currentPage = pageNumber;
          state =
              AsyncValue.data([...(state.valueOrNull ?? []), ...parsedList]);
        }
        return parsedList;
      });
    } catch (e) {
      return [];
    }
  }

  Future<void> fetchMoreData() async {
    final canLoadMore = (state.valueOrNull?.length ?? 0) < _totalComment;

    print('[slk] The new problem $canLoadMore');
    if (canLoadMore) {
      await getCommentReplies(pageNumber: _currentPage + 1);
      // ref.read(allServicesProvider.notifier).state =
      //     itemPositon < _serviceTotalItems;
    }
  }

  bool canLoadMore() {
    return (state.valueOrNull?.length ?? 0) < _totalComment;
  }
  // Future<void> fetchMoreHandler() async {
  //   final canLoadMore = (state.valueOrNull?.length ?? 0) < _totalComment;
  //   // print("[55]  Fetching page:${currentPage + 1} no bounce");
  //   if (canLoadMore) {
  //     await fetchMoreData();
  //   }
  // }

  Future<void> replyComment({
    required int commentId,
    required String reply,
  }) async {
    //  final List<NewPostCommentsModel> commentList = state.valueOrNull ?? [];
    try {
      final currentData = state.value ?? [];
      print("[x-3] currentData ${currentData.length}");
      // return;
      final response =
          await _repository.replyComment(commentId: commentId, reply: reply);
      response.fold((left) {
        print("faild to reply comment ${left.message}");
        return [];
      }, (right) {
        print("[x-3] reply saved ${right}");
        final newComment = NewPostCommentsModel.fromMap(right);
        final currentData = state.value ?? [];
        print("[x-3] currentData ${currentData.length}");
        // state = AsyncValue.data([ ...?currentData, newComment,]);
        state = AsyncValue.data([newComment, ...currentData]);
        print("[x-3] after state ${state.value?.map((e) => e.comment)}");
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
