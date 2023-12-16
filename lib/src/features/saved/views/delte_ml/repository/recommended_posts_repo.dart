import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';

import '../../../../../core/utils/exception_handler.dart';

// final recommendedPostsRepoInstance = RecommendedRepository.instance;

class RecommendedRepository {
  RecommendedRepository._();
  static RecommendedRepository instance = RecommendedRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> getFeedStream() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
  query RecommendForUser {
  recommendForUser {
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
}
          
''', payload: {});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        // return Right(right!['allPosts']);
        // print("allPosts ${right!['allPostsTotalNumber']}");
        return Right(right!);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }
}
