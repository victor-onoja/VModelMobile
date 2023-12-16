import 'package:either_option/either_option.dart';

import '../../../../../app_locator.dart';
import '../../../../../core/utils/exception_handler.dart';

class UserPermissionsRepository {
  UserPermissionsRepository._();
  static UserPermissionsRepository instance = UserPermissionsRepository._();

  //For debugging purposes only
  final _TAG = 'UserPermissionsRepository';

  Future<Either<CustomException, Map<String, dynamic>>> updatePermission({
    String? whoCanViewMyNetwork,
    String? whoCanMessageMe,
    String? whoCanFeatureMe,
    String? whoCanConnectMe,
  }) async {
    print(whoCanViewMyNetwork);
    print(whoCanMessageMe);
    print(whoCanFeatureMe);
    print(whoCanConnectMe);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation updateUserPermmissions(
              \$whoCanConnectWithMe: ConnectWithMeEnum,
            \$whoCanFeatureMe: FeatureMeEnum,
            \$whoCanMessageMe: MessageMeEnum,
            \$whoCanViewMyNetwork: FeatureMeEnum
            ) {
              updatePermissions(
            whoCanConnectWithMe: \$whoCanConnectWithMe
            whoCanFeatureMe: \$whoCanFeatureMe,
            whoCanMessageMe: \$whoCanMessageMe,
            whoCanViewMyNetwork: \$whoCanViewMyNetwork,
              ) {
                message
              }
            }
        ''', payload: {
        "whoCanConnectWithMe": whoCanConnectMe,
        "whoCanFeatureMe": whoCanFeatureMe,
        "whoCanMessageMe": whoCanMessageMe,
        "whoCanViewMyNetwork": whoCanViewMyNetwork,
      });

      return result.fold((left) {
        print('%%%%%%%%%%%%%%% ${left.toString()}');
        return Left(left);
      }, (right) {
        print('%%%%%%%%%%%%%%% $right');

        return Right(right!);
      });
    } catch (e) {
      print(e.toString());
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getMe() async {
    // _tagPrint("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH getting me");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
query{
  viewMe{
    id
    dob
    email
    username
    firstName
    lastName
    displayName
    whoCanMessageMe
    whoCanFeatureMe
    whoCanViewMyNetwork
    whoCanConnectWithMe
    isVerified
    blueTickVerified
        whoCanMessageMe
    whoCanFeatureMe
    whoCanViewMyNetwork
whoCanConnectWithMe
    profilePictureUrl
    thumbnailUrl
    isBusinessAccount
    userType
    label
  }
}
        ''', payload: {});

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        final profile = right!['viewMe'];
        return Right(profile);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getAppUserInfo(
      {required String username}) async {
    // _tagPrint("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH $username");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
  query getUser(\$username: String!){
  getUser(username:\$username){
    username
    id
    email
    bio
    zodiacSign
    connectionStatus
    allowConnectionView
    connectionId
    gender
    dob
    userType
    isVerified
    postNotification
    jobNotification
    couponNotification
    blueTickVerified
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
    displayName
    hair
    eyes
    thumbnailUrl
    profilePictureUrl
    isBusinessAccount
    userType
    label
    isFollowing
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
}
