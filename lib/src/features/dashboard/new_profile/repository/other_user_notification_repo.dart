// import 'package:either_option/either_option.dart';
// import 'package:vmodel/src/app_locator.dart';

// import '../../../../core/utils/exception_handler.dart';

// class OtherUserNotificationRepo {
//   OtherUserNotificationRepo._();
//   static OtherUserNotificationRepo instance = OtherUserNotificationRepo._();

//   Future<Either<CustomException, Map<String, dynamic>>> toggleFollowingNotification({
//     required bool notifyOnJob,
//     required bool notifyOnPost,
//     required bool notifyOnCoupon,
//     required String username,
//   }) async {
//     try {
//       final result =
//           await vBaseServiceInstance.mutationQuery(mutationDocument: '''
// mutation toggleFollowingNotification(\$notifyOnCoupon: Boolean!, \$notifyOnJob: Boolean!, \$notifyOnPost: Boolean!, \$username: String!) {
//   toggleFollowingNotification(notifyOnJob: \$notifyOnJob, notifyOnCoupon: \$notifyOnCoupon, notifyOnPost: \$notifyOnPost, username: \$username) {
//     success
//   }
// }
//         ''', payload: {
//         "notifyOnJob": notifyOnJob,
//         "notifyOnPost": notifyOnPost,
//         "notifyOnCoupon": notifyOnCoupon,
//         "username": username,
//       });

//       return result.fold((left) {
//         print('BBBB000000000000 $left');
//         return Left(left);
//       }, (right) {
//         // print('YYYYYYyayyyyy $right');
//         return Right(right!['deleteJob']);
//       });
//     } catch (e) {
//       print('Error $e');
//       return Left(CustomException(e.toString()));
//     }
//   }

// }
