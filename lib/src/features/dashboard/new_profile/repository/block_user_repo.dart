import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class BlockUserRepository {
  BlockUserRepository._();
  static BlockUserRepository instance = BlockUserRepository._();

  //  id
  //     profilePictureUrl
  //     username
  //     firstName
  //     lastName

  /// Gettting Blocked Users
  Future<Either<CustomException, Map<String, dynamic>>> getBlockedUsers(
      {String? search}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(
        queryDocument: '''
              query BlockedUsers(\$search: String) {
            blockedUsers(search: \$search) {
              id
              blockedUsers {
                id
                profilePictureUrl
                username
                firstName
                lastName
                displayName
                userType
                label
                isVerified
                blueTickVerified
              }
            }
          }

      ''',
        payload: {'search': search},
      );

      final Either<CustomException, Map<String, dynamic>> getblockUsersResult =
          result.fold(
        (left) => Left(left),
        (right) {
          print(right);
          final getblockUsersResultData =
              right?['blockedUsers'] as Map<String, dynamic>?;

          return Right(getblockUsersResultData!);
        },
      );

      return getblockUsersResult;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  /// Block User
  Future<Either<CustomException, Map<String, dynamic>>> blockUser({
    required String userName,
  }) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
      mutation BlockUser(\$userName : String!){
      blockUser(username : \$userName){
      success
      }
    }
      ''',
        payload: {
          'userName': userName,
        },
      );

      final Either<CustomException, Map<String, dynamic>> blockUserResult =
          result.fold(
        (left) => Left(left),
        (right) {
          print(right);
          final blockUserResultData =
              right?['blockUser'] as Map<String, dynamic>?;

          return Right(blockUserResultData!);
        },
      );

      return blockUserResult;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  /// Un-Block User
  Future<Either<CustomException, Map<String, dynamic>>> unBlockUser({
    required String userName,
  }) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation unblockUser(\$userName : String!){
          unblockUser(username : \$userName){
            success
          }
        }
        ''',
        payload: {
          'userName': userName,
        },
      );

      final Either<CustomException, Map<String, dynamic>> unblockUserResult =
          result.fold(
        (left) => Left(left),
        (right) {
          print(right);
          final unblockUserResultData =
              right?['unblockUser'] as Map<String, dynamic>?;

          return Right(unblockUserResultData!);
        },
      );

      return unblockUserResult;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
