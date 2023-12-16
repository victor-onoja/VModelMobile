import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class CouponRepository {
  CouponRepository._();
  static CouponRepository instance = CouponRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> createCoupon({
    required String code,
    required String title,
    String? expiryDate,
    int? useLimit,
    DateTime? dateCreated,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation createCoupon(\$code: String!, \$expiryDate: DateTime, \$title: String!, \$useLimit: Int) {
  createCoupon(code: \$code, expiryDate: \$expiryDate, title: \$title, useLimit: \$useLimit) {
    message
  }
}
''', payload: {
        'code': code,
        'title': title,
        'expiryDate': expiryDate,
        'useLimit': useLimit,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        final success = right!['createCoupon'];
        print('---$success -----');
        // if (success['message']) {
        //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        //       message: 'Coupon created successfully');
        // }

        print('-----postCoupon------');
        return Right(right['createCoupon']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getUserCoupons({
    String? username,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
query userCoupons(\$username: String! ){
  userCoupons(username: \$username){
  id
  code
  title
  dateCreated
   owner {
     id
     username
   }
  }
}
''', payload: {'username': username ?? ""});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right!['userCoupons'] as List);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateCoupon({
    String? code,
    String? title,
    String? expiryDate,
    int? useLimit,
    required int couponId,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation updateCoupon(\$code: String, \$expiryDate: DateTime, \$title: String, \$useLimit: Int, \$couponId: Int!) {
  updateCoupon(code: \$code, expiryDate: \$expiryDate, title: \$title, useLimit: \$useLimit, couponId: \$couponId) {
    message
  }
}
''', payload: {
        'code': code,
        'title': title,
        'expiryDate': expiryDate,
        'useLimit': useLimit,
        'couponId': couponId
      });

      return result.fold((left) {
        print("error on update coupon $left");
        return Left(left);
      }, (right) {
        print('update coupon  $right');
        final success = right!['coupon'];
        // print('---$success -----');
        // if (success['message']) {
        //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        //       message: 'Coupon created successfully');
        // }

        return Right(right['updateCoupon']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteCoupon({
    required int couponId,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation deleteCoupon(\$couponId: Int!){
  deleteCoupon(
    couponId: \$couponId
  ){
    message
  }
}
''', payload: {'couponId': couponId});

      return result.fold((left) {
        print("error on update coupon $left");
        return Left(left);
      }, (right) {
        print('update coupon  $right');
        final success = right!['deleteCoupon'];
        // print('---$success -----');
        // if (success['message']) {
        //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        //       message: 'Coupon created successfully');
        // }

        return Right(right['deleteCoupon']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}
