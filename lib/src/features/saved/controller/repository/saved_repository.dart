import 'dart:developer';

import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/res/colors.dart';

abstract class SavePostRepository {
  Future<Either<CustomException, Map<String, dynamic>>> savePost(
      int postId, bool saveBool);
  Future<Either<CustomException, List<dynamic>>> getSavedPosts();
  Future<Either<CustomException, List<dynamic>>> getsavedPostsCategory();
}

class SavePostsRepository implements SavePostRepository {
  @override
  Future<Either<CustomException, Map<String, dynamic>>> savePost(
      int postId, bool saveBool) async {
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
        Fluttertoast.showToast(
            msg: saveBool ? "Unsaved" : "Saved",
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: VmodelColors.black.withOpacity(0.6),
            textColor: Colors.white,
            fontSize: 16.0);
        return Right(right!['tokenAuth']);
      });

      return userName;
    } catch (e) {
      log(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  @override
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
      log('CreatePostRepo Fetching user posts $result');

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

  @override
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
        log("this $albumList");
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}

final savedPostRes = SavedPostRes.instance;

class SavedPostRes {
  SavedPostRes._();
  static SavedPostRes instance = SavedPostRes._();

  Future<Either<CustomException, Map<String, dynamic>>> getSavedPosts() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query SavedPosts (\$pageCount: Int, \$pageNumber: Int) {
  savedPosts (pageCount:\$pageCount, pageNumber:\$pageNumber) {
               id
    post {
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
    
    createdAt
    deleted
  }
}
        ''', payload: {
        'pageCount': 20,
        'pageNumer': 1,
      });
      log("$result");

      return result.fold((left) => Left(left), (right) {
        print("77777777777777777777777777777777 $right");

        return Right(right!);
      });

      // print("''''''''''''''''''''''''''''''$response");
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getHiddenPosts() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query archivedPosts (\$pageCount: Int, \$pageNumber: Int) {
  archivedPosts (pageCount:\$pageCount, pageNumber:\$pageNumber) {
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
      thumbnail
    }
    videos {
      id
      description
      itemLink
    }
    
    createdAt
    deleted
  }
}
        ''', payload: {
        'pageCount': 20,
        'pageNumer': 1,
      });
      log("$result");

      return result.fold((left) => Left(left), (right) {
        print("77777777777777777777777777777777 $right");

        return Right(right!);
      });

      // print("''''''''''''''''''''''''''''''$response");
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
