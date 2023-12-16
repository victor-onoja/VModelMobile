import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

abstract class ServiceRepository {
  // Future<Either<CustomException, Map<String, dynamic>>> createService(
  //     String deliveryTimeline,
  //     String description,
  //     String period,
  //     double price,
  //     String title,
  //     String usageLength,
  //     String usageType);
  // Future<Either<CustomException, Map<String, dynamic>>> updateService(
  //     String deliveryTimeline,
  //     String description,
  //     String period,
  //     double price,
  //     String title,
  //     String usageLength,
  //     String usageType);
  // Future<Either<CustomException, Map<String, dynamic>>> deleteService(
  //     int serviceId);
  Future<Either<CustomException, List<dynamic>>> userServices(String? username);
  Future<Either<CustomException, List<dynamic>>> userService(
      String? username, int? serviceId);
}

class ServicesRepository implements ServiceRepository {
//   @override
//   Future<Either<CustomException, Map<String, dynamic>>> createService(
//       String deliveryTimeline,
//       String description,
//       String period,
//       double price,
//       String title,
//       String usageLength,
//       String usageType) async {
//     try {
//       print('CreatePostRepo Fetching user posts }');
//       final result =
//           await vBaseServiceInstance.mutationQuery(mutationDocument: '''
//           mutation createService(\$deliveryTimeline: String!, \$description: String, \$period: String!, \$price: Float!, \$title: String!, \$usageLength: String!, \$usageType: String!) {
//             createService(deliveryTimeline: \$deliveryTimeline, description: \$description, period: \$period, price: \$price, title: \$title, usageLength: \$usageLength, usageType: \$usageType) {
//               success
//               message
//               service{
//                 id
//                 title
//                 price
//                 description
//                 serviceType
//                 period
//                 user{
//                id
//                firstName
//                lastName
//                }
//                 delivery{
//                id
//                name
//                addedBy
//                }
//                usageType
//                usageLength
//                deleted
//                deliveryTimeline
//                }
//             }
//           }
//         ''', payload: {
//         'deliveryTimeline': deliveryTimeline,
//         'description': description,
//         'period': period,
//         'price': price,
//         'title': title,
//         'usageLength': usageLength,
//         'usageType': usageType
//       });
//       print('CreatePostRepo Fetching user posts }');
//       final Either<CustomException, Map<String, dynamic>> userName =
//           result.fold((left) => Left(left), (right) {
//         print('%%%%%%%%%%%%%%% $right');
//         return Right(right!['tokenAuth']);
//       });
//       print("tis is the $usageType");
//       return userName;
//     } catch (e) {
//       log("${Left(e.toString())}");
//       print("tis is the $usageType");
//       return Left(CustomException(e.toString()));
//     }
//   }

  // @override
  // Future<Either<CustomException, Map<String, dynamic>>> updateService(
  //     String deliveryTimeline,
  //     String description,
  //     String period,
  //     double price,
  //     String title,
  //     String usageLength,
  //     String usageType) async {
  //   try {
  //     final result =
  //         await vBaseServiceInstance.mutationQuery(mutationDocument: '''
  //         mutation UpdateService(\$deliveryTimeline: String, \$description: Strin, \$period: String, \$price: Float, \$title: String, \$usageLength: String, \$usageType: String) {
  //           updateService(deliveryTimeline: \$deliveryTimeline, description: \$description, period: \$period, price: \$price, title: \$title, usageLength: \$usageLength, usageType: \$usageType) {

  //             service{
  //               id
  //               title
  //               price
  //               description
  //               serviceType
  //               period
  //               user{
  //              id
  //              firstName
  //              lastName
  //              }
  //               delivery{
  //              id
  //              name
  //              addedBy
  //              }
  //              usageType
  //              usageLength
  //              deleted
  //              deliveryTimeline
  //              }
  //           }
  //         }
  //       ''', payload: {
  //       'deliveryTimeline': deliveryTimeline,
  //       'description': description,
  //       'period': period,
  //       'price': price,
  //       'title': title,
  //       'usageLength': usageLength,
  //       'usageType': usageType
  //     });

  //     print("tis is the $usageType");
  //     final Either<CustomException, Map<String, dynamic>> userName =
  //         result.fold((left) => Left(left), (right) {
  //       print('%%%%%%%%%%%%%%% $right');
  //       return Right(right!['tokenAuth']);
  //     });

  //     return userName;
  //   } catch (e) {
  //     print("tis is the $usageType");
  //     return Left(CustomException(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<CustomException, Map<String, dynamic>>> deleteService(
  //     int serviceId) async {
  //   try {
  //     final result =
  //         await vBaseServiceInstance.mutationQuery(mutationDocument: '''
  //         mutation DeleteService(\$serviceId: Int!) {
  //           deleteService(serviceId: \$serviceId,) {
  //             success
  //             message
  //           }
  //         }
  //       ''', payload: {'serviceId': serviceId});

  //     final Either<CustomException, Map<String, dynamic>> userName =
  //         result.fold((left) => Left(left), (right) {
  //       print('%%%%%%%%%%%%%%% $right');
  //       return Right(right!['tokenAuth']);
  //     });

  //     return userName;
  //   } catch (e) {
  //     return Left(CustomException(e.toString()));
  //   }
  // }

  @override
  Future<Either<CustomException, List<dynamic>>> userServices(
      String? username) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query userServices (\$username: String!) {
  userServices (username: \$username) {
                id
                title
                price
                description
                serviceType
                period
                user{
               id
               firstName
               lastName
               username
               displayName
               }
                delivery{
               id
               name
               addedBy
               }
               usageType
               usageLength
               deleted
               deliveryTimeline
  }
}
        ''', payload: {
        'username': username,
      });

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['userServices'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, List<dynamic>>> userService(
      String? username, int? serviceId) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query userService(\$username: String!,\$isOffer: Boolean, \$serviceId: Int!) {
  userService(username: \$username, isOffer: \$isOffer, serviceId:\$serviceId) {
    id
    title
    description
    period
    initialDeposit
    usageType
    usageLength
    
    discount
    views
    isDigitalContentCreator
    hasAdditional
    createdAt
    lastUpdated
    isOffer
    userLiked
    likes
    deliveryTimeline
    user {
      id
      fullName
      profilePicture
      username
      displayName
      price
    }
    delivery {
      id
      name
      addedBy
      serviceSet {
        id
        title
        description
      }
    }
  bookingSet{
    id
    accepted
    rejected
    createdAt
  }
  }
}
        ''', payload: {
        'username': username,
        'serviceId': serviceId,
      });

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['userServices'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}

class UserServiceRepository {
  UserServiceRepository._();

  //For debugging purposes only

  static UserServiceRepository instance = UserServiceRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> userService(
      String? username, int? serviceId) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query userService(
  #\$username: String!,
  \$isOffer: Boolean, \$serviceId: Int!) {
  userService(
    #username: \$username,
     isOffer: \$isOffer, serviceId:\$serviceId) {
     id
    title
    userLiked
    likes
    discount
    #userSaved
    saves
    banner {
      url
      thumbnail
    }
    views
    faq
    price
    description
    period
    isOffer
    serviceType
    usageType
    createdAt
    lastUpdated
    #deleted
    paused
    status
    user {
      id
      username
      displayName
      userType
      label
      isBusinessAccount
      isVerified
      blueTickVerified
      profilePictureUrl
      thumbnailUrl
      location {
        locationName
      }
    }
    delivery {
      id
      name
    }
    hasAdditional
    likes
  }
}
        ''', payload: {
        'username': username,
        'serviceId': serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) => Left(left), (right) {
        print("77777777777777777777777777777777 ${right!['userService']}");

        final albumList = right['userService'] as Map<String, dynamic>?;
        return Right(albumList ?? {});
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> likeService(
      int serviceId) async {
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation likeService(\$serviceId: Int!) {
  likeService(serviceId: \$serviceId) {
    success
  }
}
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['likeService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> saveService(
      int serviceId) async {
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation saveService(\$serviceId: Int!) {
  saveService(serviceId: \$serviceId) {
    success
  }
}
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['saveService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
