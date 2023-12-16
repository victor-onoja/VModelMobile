import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';

import '../../../../core/utils/exception_handler.dart';

final feedRepoInstance = FeedRepository.instance;

class FeedRepository {
  FeedRepository._();
  static FeedRepository instance = FeedRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> getFeedStream(
      {int? pageCount, int? pageNumber}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          
  query feedPosts(\$pageCount: Int, \$pageNumber: Int) {
  allPosts(feed: true, pageCount: \$pageCount, pageNumber: \$pageNumber) {
    id
    likes
    aspectRatio
    locationInfo
    caption
    likes
    userLiked
    userSaved
    createdAt
    updatedAt
    service {
      id
      title
      price
      description
      period
      user {
       id
       username
      }
    }
    user {
      id
      username
      displayName
      userType
      label
      isBusinessAccount
      thumbnailUrl
      profilePictureUrl
      isVerified
      blueTickVerified
    }
    album{
      id
      name
    }
    tagged {
      id
      username
      profilePictureUrl
      thumbnailUrl
    }
    photos {
      id
      description
      itemLink
    }
    videos {
      id
      description
      itemLink
    }
  }
  allPostsTotalNumber
}
          
''', payload: {
        "pageCount": pageCount,
        "pageNumber": pageNumber,
      });

      return result.fold((left) {
        return Left(left);
      }, (right) {
        // return Right(right!['allPosts']);
        print("allPosts ${right!['allPostsTotalNumber']}");
        return Right(right);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> likePost(
      int postId) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''

    mutation toggleLike(\$postId: Int!) {
    likePost(postId: \$postId) {
      success
      }
    }
          
''', payload: {"postId": postId});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right!['likePost']);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> savePost(
      int postId) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation SavePost(\$postId: Int!) {
            savePost(postId: \$postId) {
              success
              message
            }
          }
        ''', payload: {'postId': postId});

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['savePost']);
      });

      return userName;
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteSavedPost(
      int postId) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation DeleteSavedPost(\$postId: Int!) {
            deleteSavedPost(savedPostId: \$postId) {
              success
              message
            }
          }
        ''', payload: {'postId': postId});

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['deleteSavedPost']);
      });

      return userName;
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }
}
