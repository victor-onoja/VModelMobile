import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class PostCommentsRepository {
  PostCommentsRepository._();
  static PostCommentsRepository instance = PostCommentsRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> getPostComments({
    required int postId,
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      final response = await vBaseServiceInstance.getQuery(
        queryDocument: '''
  query postComments(
    \$postId: Int!, 
    \$pageCount: Int
    \$pageNumber: Int
  ) {
  postComments(
    postId:\$postId,
    pageCount:\$pageCount,
    pageNumber: \$pageNumber,
  ) {

    id
    upVotes
    createdAt
    updatedAt
    comment
    userLiked
    hasChildren
    childrenCount
    post {
      id
    }
    user {
      id
      username
      displayName
      profilePictureUrl
      thumbnailUrl
      isVerified
      blueTickVerified
    }
    rootParent {
      id
    }
    parent {
      id
      comment
      user {
        id
        username
        displayName
        isVerified
        blueTickVerified
      }
    }
  }
  postCommentsTotalNumber
}

''',
        payload: {
          'pageCount': pageCount,
          'pageNumber': pageNumber,
          'postId': postId,
        },
      );
      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) {
        return Left(left);
      }, (right) {
        // print("comments ${right!['postComments']}");
        return Right(right as Map<String, dynamic>);
      });
      return result;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

//   Future<Either<CustomException, Map<String, dynamic>>> getPostComments({
//     required int postId,
//     int? pageCount,
//     int? pageNumber,
//   }) async {
//     try {
//       final response = await vBaseServiceInstance.getQuery(
//         queryDocument: '''
//   query postComments(
//     \$postId: Int!,
//     \$pageCount: Int
//     \$pageNumber: Int
//   ) {
//   postComments(
//     postId:\$postId,
//     pageCount:\$pageCount,
//     pageNumber: \$pageNumber,
//   ) {

//   id
//   upVotes
//   createdAt
//   updatedAt
//   comment
//   userLiked
//   parent{
//     id
//     comment
//       user{
//         id
//         username
//         profilePicture
//         thumbnailUrl
//       }
//   }
//   user{
//     id
//     username
//     profilePicture
//     thumbnailUrl
//   }
//     replyParent{
//       comment
//       id
//   parent{
//     id
//     comment
//       user{
//         id
//         username
//         profilePicture
//         thumbnailUrl
//       }
//   }
//       replyParent{
//         id
//         comment
//         parent{
//           id
//           comment
//             user{
//               id
//               username
//               profilePicture
//               thumbnailUrl
//             }
//         }
//          user{
//         id
//         username
//         profilePicture
//         thumbnailUrl
//       }
//       }
//       user{
//         id
//         username
//         profilePicture
//         thumbnailUrl
//       }
//     }

//   }
//     postCommentsTotalNumber
// }

// ''',
//         payload: {
//           'pageCount': pageCount,
//           'pageNumber': pageNumber,
//           'postId': postId,
//         },
//       );
//       final Either<CustomException, Map<String, dynamic>> result =
//           response.fold((left) {
//         return Left(left);
//       }, (right) {
//         // print("comments ${right!['postComments']}");
//         return Right(right as Map<String, dynamic>);
//       });
//       return result;
//     } catch (e) {
//       return Left(CustomException(e.toString()));
//     }
//   }

  Future<Either<CustomException, Map<String, dynamic>>> savePostComments({
    required int postId,
    required String comment,
  }) async {
    try {
      final response = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
  mutation saveComment(
    \$postId: Int!, 
    \$comment: String!
  
  ) {
  saveComment(
     postId:\$postId,
    comment:\$comment,
 
  ) {
     comment{
    id
    comment
    upVotes
    createdAt
    updatedAt
    userLiked
    post {
      id
    }
    parent{
      comment
      user{
        id
        username
        displayName
        thumbnailUrl
        isVerified
        blueTickVerified
      }
    }
    user{
      id
      username
      displayName
      profilePictureUrl
      thumbnailUrl
      isVerified
      blueTickVerified
    }
  	}
    
  }
}

''',
        payload: {
          'comment': comment,
          'postId': postId,
        },
      );
      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) {
        return Left(left);
      }, (right) {
        // print("comments ${right!['postComments']}");
        return Right(right!['saveComment']['comment'] as Map<String, dynamic>);
      });
      return result;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> replyComment({
    required int commentId,
    required String reply,
  }) async {
    try {
      final response = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
  mutation replyComment(\$commentId: Int!, \$reply: String!) {
  replyComment(commentId: \$commentId, reply: \$reply) {
      message
      reply{
      id
      comment
      upVotes
      createdAt
      updatedAt
      userLiked
      post {
        id
      }
      user{
        id
        username
        displayName
        thumbnailUrl
        profilePictureUrl
        isVerified
        blueTickVerified
      }
      parent{
        id
        comment
        user{
          id
          username
          displayName
          thumbnailUrl
          profilePictureUrl
          isVerified
          blueTickVerified
        }
      }
  	}
    
  }
}

''',
        payload: {
          'reply': reply,
          'commentId': commentId,
        },
      );
      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) {
        return Left(left);
      }, (right) {
        // print("comments ${right!['postComments']}");
        return Right(right!['replyComment']['reply'] as Map<String, dynamic>);
      });
      return result;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getPostCommentsReplies({
    required int commentId,
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      final response = await vBaseServiceInstance.getQuery(
        queryDocument: '''
 query commentReplies(\$commentId: Int!, \$pageCount: Int, \$pageNumber: Int) {
  commentReplies(commentId: \$commentId, pageCount: \$pageCount, pageNumber: \$pageNumber) {

     id
    comment
    upVotes
    createdAt
    updatedAt
    userLiked
    post {
      id
    }
    rootParent {
      id
      comment
    user{
      id
      username
        displayName
      profilePictureUrl
      thumbnailUrl
    }
    }
    parent {
      id
      comment
    user{
      id
      username
        displayName
      profilePictureUrl
      thumbnailUrl
      isVerified
      blueTickVerified
    }
    }
    user{
      id
      username
        displayName
      profilePictureUrl
      thumbnailUrl
      isVerified
      blueTickVerified
    }
  }

  commentRepliesTotalNumber
}

''',
        payload: {
          'pageCount': pageCount,
          'pageNumber': pageNumber,
          'commentId': commentId,
        },
      );
      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) {
        return Left(left);
      }, (right) {
        // print("comments ${right!['postComments']}");
        // return Right(right!['commentReplies'] as List);
        return Right(right!);
      });
      return result;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteComment({
    required int commentId,
  }) async {
    try {
      final response = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
          mutation delComment(\$commentId: Int!) {
            deleteComment(commentId: \$commentId) {
              message
            }
          }
      ''',
        payload: {
          'commentId': commentId,
        },
      );
      return response.fold((left) {
        return Left(left);
      }, (right) {
        // print("comments ${right!['postComments']}");
        return Right(right!['deleteComment']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
