import 'package:either_option/either_option.dart';

import '../../../../app_locator.dart';
import '../../../../core/utils/exception_handler.dart';

class GalleryRepository {
  GalleryRepository._();
  static GalleryRepository instance = GalleryRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> createGallery({
    required String name,
  }) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation createAlbum(\$name: String!) {
          createAlbum(name : \$name) {
            message
            album {
              id
              name
            }
          }
        }
      ''',
        payload: {
          'name': name,
        },
      );

      final Either<CustomException, Map<String, dynamic>> albumResult =
          result.fold(
        (left) => Left(left),
        (right) {
          final createAlbumData =
              right?['createAlbum'] as Map<String, dynamic>?;

          if (createAlbumData != null) {
            final album = createAlbumData['album'] as Map<String, dynamic>?;
            if (album != null) {
              return Right(album);
            }
          }

          return Left(CustomException('Failed to create album.'));
        },
      );

      return albumResult;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getUserGalleries(
      {String? username}) async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query userAlbumsPosts (\$username: String) {
  userAlbums (username:\$username) {
    id
    name
    albumType
    postSet {
      id
      createdAt
      updatedAt
      caption
      aspectRatio
      locationInfo
      likes
      userLiked
      userSaved
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
        isBusinessAccount
        userType
        label
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
        thumbnailUrl
        profilePictureUrl
      }
      photos {
        id
        itemLink
        description
        thumbnail
      }
    }
  }
}
        ''', payload: {
        'username': username,
      });

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['userAlbums'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getUserGalleryPosts(
      {required int albumId, int? pageNumber, int? pageCount}) async {
    print('Fetching album (id: $albumId) posts ');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          query albumsPosts(\$albumId: Int!, \$pageCount: Int,
            \$pageNumber: Int) {
            albumPosts(albumId: \$albumId, pageCount: \$pageCount,
            pageNumber:\$pageNumber) {
              id
              createdAt
              updatedAt
              caption
              aspectRatio
              locationInfo
              likes
              userLiked
              userSaved
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
                isBusinessAccount
                userType
                label
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
                thumbnailUrl
                profilePictureUrl
              }
              photos {
                id
                itemLink
                description
                thumbnail
              }
            }
            albumPostsTotalNumber
          }
        ''', payload: {
        'albumId': albumId,
        'pageCount': pageCount,
        'pageNumber': pageNumber,
      });

      return result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        return Right(right!);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getUserPortfolioGalleries(
      {String? username}) async {
    print('CreatePostRepo Fetching albums for user $username');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      query userAlbumsPosts (\$username: String) {
          userAlbums (username:\$username) {
              id
              name
              hasPosts
              albumType
              postSet {
                id
              }
             }
           }
        ''', payload: {'username': username});

      final Either<CustomException, List<dynamic>> albumResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        final albumList = right?['userAlbums'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      print("''''''''''''''''''''''''''''''$albumResponse");
      return albumResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getUserGalleriesOnly(
      {String? username}) async {
    print('CreatePostRepo Fetching albums for user $username');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      query userAlbumsPosts (\$username: String) {
  userAlbums (username:\$username) {
              id
              name
             }
           }
        ''', payload: {'username': username});

      final Either<CustomException, List<dynamic>> albumResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        final albumList = right?['userAlbums'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      print("''''''''''''''''''''''''''''''$albumResponse");
      return albumResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> createAlbum({
    required String name,
    required String albumType,
  }) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation createAlbum(\$name: String!, \$albumType: String!) {
          createAlbum(name : \$name, albumType:\$albumType) {
            message
            album {
              id
              name
              albumType
            }
          }
        }
      ''',
        payload: {
          'name': name,
          'albumType': albumType,
        },
      );

      final Either<CustomException, Map<String, dynamic>> albumResult =
          result.fold(
        (left) => Left(left),
        (right) {
          final createAlbumData =
              right?['createAlbum'] as Map<String, dynamic>?;

          if (createAlbumData != null) {
            final album = createAlbumData['album'] as Map<String, dynamic>?;
            if (album != null) {
              return Right(album);
            }
          }

          return Left(CustomException('Failed to create album.'));
        },
      );

      return albumResult;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteGallery(
      {required int galleryId, required String password}) async {
    print('Deleting gallery with id $galleryId and password $password');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      mutation deleteAlbum(\$albumId: Int!, \$password: String!) {
          deleteAlbum(albumId:\$albumId, password:\$password) {
              message
              success
             }
           }
        ''', payload: {'albumId': galleryId, 'password': password});

      final Either<CustomException, Map<String, dynamic>> deleteResponse =
          result.fold((left) {
        return Left(left);
      }, (right) {
        final albumList = right?['deleteAlbum'] as Map<String, dynamic>;
        return Right(albumList ?? {});
      });

      print("''''''''''''''''''''''''''''''$deleteResponse");
      return deleteResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateGalleryName(
      {required int galleryId, required String newName}) async {
    print('Updating gallery name with id $galleryId and name $newName');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      mutation updateAlbum(\$albumId: Int!, \$name: String!) {
          updateAlbum(albumId:\$albumId, name:\$name) {
              message
              album{
                id,
                name
                albumType
                isDeleted
              }
             }
           }
        ''', payload: {'albumId': galleryId, 'name': newName});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        final albumList = right!['updateAlbum'] as Map<String, dynamic>;
        print("''''''''''''''''''''''''''''''$right");
        return Right(albumList);
      });
    } catch (e) {
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

  Future<Either<CustomException, Map<String, dynamic>>> deletePost(
      int postId) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''

    mutation(\$postId: Int!) {
      deletePost(postId: \$postId) {
        status
        message
      }
    }
          
''', payload: {"postId": postId});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right!['deletePost']);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }
}
