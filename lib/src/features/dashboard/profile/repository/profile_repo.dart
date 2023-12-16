import 'package:either_option/either_option.dart';

import '../../../../app_locator.dart';
import '../../../../core/utils/exception_handler.dart';

class ProfileRepository {
  final String _TAG = 'ProfileRepository';
  ProfileRepository._();
  static ProfileRepository instance = ProfileRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getUserProfile(
      {required String username}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
            query(\$username: String!){
  getUser(username:\$username){
    username
    id
    email
    bio
    zodiacSign
    gender
    userType
    isVerified
    allowConnectionView
    connectionStatus
    height {
      value
      unit
    }
    location{
      locationName
    }
    website
    price
    postcode
    gender
    ethnicity
    size
    firstName
    lastName
    hair
    eyes
    #phoneNumber
    profilePictureUrl
    isBusinessAccount
    userType
  }
}
        ''', payload: {
        'username': username,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        final profile = right!['getUser'];

        return Right(profile);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

//   Future<Either<CustomException, Map<String, dynamic>>> updateProfilePicture(
//       {required String profilePictureUrl}) async {
//     try {
//       final response =
//           await vBaseServiceInstance.mutationQuery(mutatonDocument: '''
//            mutation updateProfile(\$profilePictureUrl: String!) {
//   updateProfile(profilePictureUrl: \$profilePictureUrl) {
//     user {
//       username
//       lastName
//       firstName
//       isActive
//       bio
//       id
//       profilePictureUrl
//       profilePicture
//     }
//   }
// }
//         ''', payload: {
//         'profilePictureUrl': profilePictureUrl,
//       });
//
//       final Either<CustomException, Map<String, dynamic>> result =
//           response.fold(
//               (left) => Left(left), (right) => Right(right!['updateProfile']));
//       return result;
//     } catch (e) {
//       print('Error uploading profile picture in $_TAG ===> $e');
//       return Left(CustomException(e.toString()));
//     }
//   }

  Future<Either<CustomException, List<dynamic>>> getUserPosts(
      String? username) async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query userAlbumsPosts (\$username: String) {
  userAlbums (username:\$username) {
    id
    name
    postSet {
      caption
      tagged {
        id
        username
      }
      locationInfo
      album {
        id
        name
      }
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

  Future<Either<CustomException, Map<String, dynamic>>> followUser(
      String? username) async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(
        queryDocument: '''
   mutation followUser(\$username: String!) {
  followUser(username: \$username) {
    success
  }
}

        ''',
        payload: {
          'username': username,
        },
      );

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        return Right(right?['followUser']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> unFollowUser(
      String? username) async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(
        queryDocument: '''
   mutation unfollowUser(\$username: String!) {
  unfollowUser(username: \$username) {
    success
  }
}

        ''',
        payload: {
          'username': username,
        },
      );

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        return Right(right?['unfollowUser']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      toggleFollowingNotification({
    required bool notifyOnJob,
    required bool notifyOnPost,
    required bool notifyOnCoupon,
    required String username,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation toggleFollowingNotification(\$notifyOnCoupon: Boolean!, \$notifyOnJob: Boolean!, \$notifyOnPost: Boolean!, \$username: String!) {
  toggleFollowingNotification(notifyOnJob: \$notifyOnJob, notifyOnCoupon: \$notifyOnCoupon, notifyOnPost: \$notifyOnPost, username: \$username) {
    success
  }
}
        ''', payload: {
        "notifyOnJob": notifyOnJob,
        "notifyOnPost": notifyOnPost,
        "notifyOnCoupon": notifyOnCoupon,
        "username": username,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        // print('YYYYYYyayyyyy $right');
        return Right(right!['toggleFollowingNotification']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}
