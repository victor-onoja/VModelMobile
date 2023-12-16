import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';

import '../../../../core/utils/exception_handler.dart';

class HashTagSearchRepository {
  HashTagSearchRepository._();
  static HashTagSearchRepository instance = HashTagSearchRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> hashTagSearch(
      {int? pageCount, int? pageNumber, String? search}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          
  query postHashtagSearch(\$pageCount: Int, \$pageNumber: Int,
   \$hashSearch: String!) {
  postHashtagSearch(pageCount: \$pageCount, pageNumber: \$pageNumber,
   hashSearch: \$hashSearch) {
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
      thumbnail
      itemLink
    }
    videos {
      id
      description
      itemLink
    }
  }
  postHashtagSearchTotalNumber
}
          
''', payload: {
        "pageCount": pageCount,
        "pageNumber": pageNumber,
        "hashSearch": search,
      });

      return result.fold((left) {
        return Left(left);
      }, (right) {
        print("allPosts ${right!['postHashtagSearch']}");
        return Right(right);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> recentHashTags(
      {int? pageCount, int? pageNumber, String? search}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          
        query {
          recentlyViewedHashtags {
            id
            recentlyViewedHashTags
          }
        }
          
''', payload: {});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        print("recent hastags ${right!}");
        return Right(right);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }
}
