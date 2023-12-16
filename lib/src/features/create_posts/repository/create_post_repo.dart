import 'dart:io';
import 'dart:typed_data';

import 'package:either_option/either_option.dart';
// import 'package:get/get.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/api/file_service.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class CreatePostRepository {
  CreatePostRepository._();
  static CreatePostRepository instance = CreatePostRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> postContent({
    required String albumId,
    required String aspectRatio,
    String? locationInfo,
    required String caption,
    required List<Map<String, dynamic>> filesMap,
    required List<String> tagged,
    required int? serviceId,
  }) async {
    print('+-) tagged users $tagged');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
         mutation createPost(\$albumId: Int!, \$aspectRatio: String!, \$caption: String, 
\$files: [FileUrlType]!,
\$locationInfo: String,
\$tagged: [String],
\$serviceId: Int) {
  createPost(album: \$albumId,
    aspectRatio: \$aspectRatio,
    caption: \$caption,
    files: \$files,
    locationInfo: \$locationInfo,
    tagged: \$tagged,
    service: \$serviceId,
    ) {
    status
    message
    userPost {
      id
      photos {
        id
        itemLink
        description
            }
        }
    }
} 
          
        ''', payload: {
        'albumId': albumId, //Album id for Emo
        'caption': caption,
        'files': filesMap,
        'locationInfo': locationInfo,
        'tagged': tagged,
        'aspectRatio': aspectRatio,
        'serviceId': serviceId,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['createPost']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> uploadPhotoThumbnail(
      {required String postId,
      required List<Map<String, dynamic>> data}) async {
    print('The postId: $postId map is $data');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
mutation UploadPhotoThumbnail(\$postId: String!,
  \$thumbnailUrl: [ThumbnailUrlType]!) {
  uploadPhotoThumbnail(postId: \$postId,
    thumbnailUrl: \$thumbnailUrl) {
    message
    post {
      id
      photos {
        id
        itemLink
        thumbnail
      }
    }
  }
}


''', payload: {"postId": postId, "thumbnailUrl": data});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        print('Sxuccess right $right');
        return Right(right!['uploadPhotoThumbnail']);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> editPost({
    required int postId,
    String? caption,
    String? locationName,
    List<String>? taggedUsers,
  }) async {
    // final tagged =
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''

      mutation updatePost(
        \$postId: Int!,
        \$caption: String,
        \$locationInfo: String,
        \$tagged: [String]
      ) {
        updatePost(
          postId: \$postId,
          caption: \$caption,
          locationInfo: \$locationInfo,
          tagged: \$tagged,
        ) {
          status
          message
          userPost {
            caption
            locationInfo
            tagged {
              id
              username
            }

          }
        }
      }

      ''',
        payload: {
          "postId": postId,
          "caption": caption,
          "locationInfo": locationName,
          "tagged":
              (taggedUsers != null && taggedUsers.isEmpty) ? [""] : taggedUsers,
        },
      );

      return result.fold(
        (left) => Left(left),
        (right) {
          return Right(right!);
        },
      );
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> postLocationHistory() async {
    // final tagged =
    try {
      final result = await vBaseServiceInstance.getQuery(
        queryDocument: '''
        {
          previousPostLocations
        }
      ''',
        payload: {},
      );

      return result.fold(
        (left) => Left(left),
        (right) {
          print('[oxssi] $right');
          final res = right!['previousPostLocations'] as List?;
          return Right(res ?? []);
        },
      );
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getAlbums(
      {String? username, String? albumType}) async {
    print('CreatePostRepo Fetching albums for user $username');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      query userAlbumsPosts (\$username: String, \$albumType: String) {
  userAlbums (username:\$username, albumType: \$albumType) {
              id
              name
              albumType
             }
           }
        ''', payload: {'username': username, 'albumType': albumType});

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

  //Upload file

  Future<Either<CustomException, String?>> uploadFiles(
      String url, List<File> files,
      {OnUploadProgressCallback? onUploadProgress}) async {
    final fps = files.map((e) => e.path).toList();
    try {
      final res = await FileService.fileUploadMultipart(
        // url: VUrls.postMediaUploadUrl,
        url: url,
        files: fps,
        onUploadProgress: onUploadProgress,
      );
      // return res;
      print('%%%MMMMMMMMM REturning right $res');
      return Right(res);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, String?>> uploadRawBytesList(
      String url, List<Uint8List> rawData,
      {OnUploadProgressCallback? onUploadProgress}) async {
    // final fps = files.map((e) => e.path).toList();
    try {
      final res = await FileService.rawBytesDataUploadMultipart(
        // url: VUrls.postMediaUploadUrl,
        url: url,
        rawDataList: rawData,
        onUploadProgress: onUploadProgress,
      );
      // return res;
      print('%%%MMMMMMMMM REturning right $res');
      return Right(res);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
