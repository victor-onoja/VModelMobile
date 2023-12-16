import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class UserPostBoardRepo {
  UserPostBoardRepo._();
  static UserPostBoardRepo instance = UserPostBoardRepo._();

  Future<Either<CustomException, Map<String, dynamic>>> createPostBoard(
      String title) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation createUserPostBoard(\$title: String!) {
            createPostBoard(title: \$title) {
             success 
              postBoard {
                id
                title
                coverImageUrl
                numberOfPosts
                pinned
                user {
                  id
                  firstName
                  lastName
                  username
                  profilePictureUrl
                  thumbnailUrl
                }
                createdAt
                deleted
              }
            }
          }
        ''', payload: {'title': title});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['createPostBoard']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> savePostToBoard(
      {required int postId, int? boardId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation savePostToBoard(\$postId:Int!, \$boardId: Int) {
            savePost(postId: \$postId, boardId: \$boardId) {
              success
              message
            }
          }
        ''', payload: {'postId': postId, 'boardId': boardId});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%rar% postId: $postId, boardId: $boardId, $right');
        return Right(right!['savePost']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> setBoardCoverImage({
    required int boardId,
    required String imageUrl,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation setBoardCoverImage(\$boardId: Int!, \$imageUrl: String!) {
              setPostBoardCoverImage(boardId: \$boardId, imageUrl: \$imageUrl) {
                success
                message
              }
            }
        ''', payload: {
        'boardId': boardId,
        'imageUrl': imageUrl,
      });

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['setPostBoardCoverImage']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      deleteSavedPostFromBoard({required int postId, int? boardId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation deleteSavedPost(\$savedPostId:Int!, \$boardId: Int) {
            deleteSavedPost(savedPostId: \$savedPostId, boardId: \$boardId) {
              success
              message
            }
          }
        ''', payload: {'postId': postId, 'boardId': boardId});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['deleteSavedPost']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> pinPostBoard(
      {required int boardId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation pinPostBoard(\$boardId:Int!) {
           pinPostBoard(boardId: \$boardId) {
              success
              message
            }
          }
        ''', payload: {'boardId': boardId});

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['pinPostBoard']);
      });

      return userName;
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> unpinPostBoard(
      {required int boardId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation unpinPostBoard(\$boardId:Int!) {
           unpinPostBoard(boardId: \$boardId) {
              success
              message
            }
          }
        ''', payload: {'boardId': boardId});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['unpinPostBoard']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteUserBoard(
      {required int boardId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation deleteBoard(\$boardId:Int!) {
           removePostBoard(boardId: \$boardId) {
              success
              message
            }
          }
        ''', payload: {'boardId': boardId});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['removePostBoard']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> renameUserBoard(
      {required int boardId, required String title}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation renameBoard(\$boardId:Int!, \$title:String!) {
           renamePostBoard(boardId: \$boardId, title: \$title) {
              success
              postBoard {
                id
                title
                coverImageUrl
                numberOfPosts
                pinned
                user {
                  id
                  firstName
                  lastName
                  username
                  profilePictureUrl
                  thumbnailUrl
                }
                createdAt
                deleted
              }
            }
          }
        ''', payload: {'boardId': boardId, 'title': title});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['renamePostBoard']);
      });
    } catch (e) {
      // log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getSavedPosts() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query SavedPosts(\$pageCount: Int, \$pageNumber: Int) {
        savedPosts(pageCount: \$pageCount, pageNumber: \$pageNumber) {
          id
          user {
            id
            firstName
            lastName
            username
            profilePictureUrl
            thumbnailUrl
          }
          post {
            id
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
            photos {
              id
              createdBy {
                id
                firstName
                lastName
              }
              updatedBy {
                id
                firstName
                lastName
              }
              itemLink
              description
            }
            aspectRatio
            caption
            deleted
            userLiked
            user {
              id
              username
            }
          }
        }
      }
        ''', payload: {
        'pageCount': 20,
        'pageNumer': 1,
      });
      // log('CreatePostRepo Fetching user posts $result');

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['savedPosts'] as List<dynamic>?;
        print("77777777777777777777777777777777 $albumList");
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getsavedPostsCategory() async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          query savedPostsCategories {
            savedPostsCategories
          }
        ''', payload: {});

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['savedPostsCategories'] as List<dynamic>?;
        // log("this $albumList");
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getUserCreatedBoards({
    required int pageCount,
    int? pageNumber,
    String? search,
  }) async {
    print("slko84 pgC: $pageCount pgN: $pageNumber");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
        query myBoards(\$search: String, \$pageCount: Int, \$pageNumber: Int) {
          postBoards(search: \$search, pageCount: \$pageCount,
            pageNumber: \$pageNumber) {
            id
            title
            coverImageUrl
            numberOfPosts
            pinned
            user {
              id
              firstName
              lastName
              username
              profilePictureUrl
              thumbnailUrl
            }
            createdAt
            deleted
          }
          postBoardsTotalNumber
        }

        ''', payload: {
        'pageCount': pageCount,
        'pageNumer': pageNumber,
        'search': search,
      });

      return result.fold((left) => Left(left), (right) {
        print("7x7y $right");

        return Right(right!);
      });

      // print("''''''''''''''''''''''''''''''$response");
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>>
      getRecentlyViewedBoards() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          query recentlyViewedPostBoards {
            recentlyViewedPostBoards {
              id
              dateViewed
              postBoard {
                id
                title
                pinned
                coverImageUrl
                numberOfPosts
                user {
                  id
                  username
                }
                createdAt
                deleted
              }
            }
          }
        ''', payload: {});

      return result.fold((left) => Left(left), (right) {
        print("7x7y $right");

        return Right(right!['recentlyViewedPostBoards'] as List);
      });

      // print("''''''''''''''''''''''''''''''$response");
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getBoardPosts(
      {required int boardId, required int pageCount, int? pageNumber}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
        query myBoardPosts(\$boardId: Int!, \$pageCount: Int, \$pageNumber: Int) {
          postBoardPosts(boardId: \$boardId, pageCount: \$pageCount,
            pageNumber: \$pageNumber) {
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
            album {
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
        }
        ''', payload: {
        'boardId': boardId,
        'pageCount': pageCount,
        'pageNumber': pageNumber,
      });

      return result.fold((left) => Left(left), (right) {
        print("7x7y $right");

        return Right(right!['postBoardPosts'] as List);
      });

      // print("''''''''''''''''''''''''''''''$response");
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
