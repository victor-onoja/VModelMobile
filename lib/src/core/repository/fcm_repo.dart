import 'package:either_option/either_option.dart';
// import 'package:get/get.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';



class FCMRepository {
  FCMRepository._();
  static FCMRepository instance = FCMRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> updateFcmToken({
required String fcmToken
  }) async {
   
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation updateToken(\$fcmToken: String!) {
  updateFcmToken(fcmToken: \$fcmToken) {
    success
  }
}

        ''',
         payload: {
         'fcmToken':fcmToken
       
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['createJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  

  
}
