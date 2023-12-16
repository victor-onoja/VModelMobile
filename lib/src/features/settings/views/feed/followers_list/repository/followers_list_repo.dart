import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class FollowersListRepository {
  FollowersListRepository._();
  static FollowersListRepository instance = FollowersListRepository._();

  Future<Either<CustomException, List<dynamic>>> getFollowers(
      {int? pageCount, int? pageNumber, String? search}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(
        queryDocument: '''
              query followedUsers(\$pageCount: Int, \$pageNumber: Int,
              \$search: String
              ) {
            followers(pageCount:\$pageCount, pageNumber:\$pageNumber,
              search: \$search
            ) {
                id
                thumbnailUrl
                profilePictureUrl
                username
                firstName
                lastName
               displayName
                isBusinessAccount
                userType
                label
                isVerified
                blueTickVerified
            }
            followersTotalNumber
          }

      ''',
        payload: {
          'pageCount': pageCount,
          'pageNumber': pageNumber,
          'search': search,
        },
      );

      return result.fold(
        (left) => Left(left),
        (right) {
          print(right);
          print(right);
          final getblockUsersResultData = right?['followers'] as List<dynamic>;

          return Right(getblockUsersResultData ?? []);
        },
      );
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  /// Un-Block User
  // Future<Either<CustomException, Map<String, dynamic>>> unfollowUser({
  //   required String userName,
  // }) async {
  //   try {
  //     final result = await vBaseServiceInstance.mutationQuery(
  //       mutationDocument: '''
  //       mutation (\$userName : String!){
  //         unfollowUser(username : \$userName){
  //           success
  //         }
  //       }
  //       ''',
  //       payload: {
  //         'userName': userName,
  //       },
  //     );

  //     return result.fold(
  //       (left) => Left(left),
  //       (right) {
  //         print('UUUUnnnnffollllwooooww');
  //         print(right);
  //         final unblockUserResultData =
  //             right?['unfollowUser'] as Map<String, dynamic>?;

  //         return Right(unblockUserResultData!);
  //       },
  //     );
  //   } catch (e) {
  //     return Left(CustomException(e.toString()));
  //   }
  // }
}
