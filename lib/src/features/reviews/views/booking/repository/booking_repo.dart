import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class BookingRepository {
  BookingRepository._();
  static BookingRepository instance = BookingRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> createBooking(
      {required Map<String, dynamic> bookingData}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''

      mutation CreateBooking(\$bookingData: BookingInput!) {
        createBooking(bookingData: \$bookingData) {
          booking {
            id
            title
          }
        }
      }

        ''', payload: {
        "bookingData": bookingData,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['createBooking']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> createPayment(
      {required int bookingId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation createPayment (\$bookingId: Int!) {
              createPayment(bookingId: \$bookingId) {
                paymentLink
                paymentRef
              }
            }
        ''', payload: {
        "bookingId": bookingId,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['createPayment']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}
