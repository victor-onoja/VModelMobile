import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class AllCouponsRepository {
  AllCouponsRepository._();
  static AllCouponsRepository instance = AllCouponsRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getAllCoupons({
    String? search,
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
query allCoupons(\$pageNumber: Int, \$search: String, \$pageCount: Int) {
  allCoupons(pageNumber: \$pageNumber, pageCount: \$pageCount, search: \$search) {
    id
    title
    deleted
    expiryDate,
    useLimit,
    isExpired,
    code,
    dateCreated,
    owner{
      id,
      username,
      fullName,
      profilePictureUrl
    }
   
  }
  allCouponsTotalNumber
}
        ''', payload: {
        'search': search,
        'pageCount': pageCount,
        'pageNumber': pageNumber,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getHottestCoupons({
    required int dataCount,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      query hottestCoupons(\$dataCount: Int!) {
        explore(dataCount: \$dataCount){
          hottestCoupons {
            id
            title
            deleted
            expiryDate
            useLimit
            isExpired
            code
            dateCreated
            owner {
              id
              username
              fullName
              profilePictureUrl
            }
          }
        }
      }

        ''', payload: {"dataCount": dataCount});

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        // print('popularJobsss ${right!['explore']['popularJobs']}');
        return Right(right!['explore']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> registerCouponCopy({
    required int couponId,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation recordCouponCopy(\$couponId: Int!) {
            registerCouponCopy(couponId: \$couponId) {
              message
              coupon {
                id
              }
            }
          }
        ''', payload: {
        'couponId': couponId,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['registerCouponCopy']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}
