import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';

import '../../core/utils/exception_handler.dart';

class PostsWithoutThumbnailRepository {
  PostsWithoutThumbnailRepository._();
  static PostsWithoutThumbnailRepository instance =
      PostsWithoutThumbnailRepository._();
  Future<Either<CustomException, Map<String, dynamic>>>
      getPostsWithoutThumbnails({int? pageCount, int? pageNumber}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          
  {
  postsWithPhotosWithoutThumbnail {
    id
    caption
    createdAt
    user {
      id
      username
      displayName
    }
    album{
      id
      name
    }
    photos {
      id
      description
      itemLink
      thumbnail
    }
  }
  postsWithPhotosWithoutThumbnailTotalNumber
}
          
''', payload: {});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        print("[2qus] ${right!['postsWithPhotosWithoutThumbnail']}");
        return Right(right);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }
}
