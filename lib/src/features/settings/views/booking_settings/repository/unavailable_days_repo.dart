import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
// import 'package:get/get.dart';

class UnavailabiltyRepository {
  UnavailabiltyRepository._();

  static UnavailabiltyRepository instance = UnavailabiltyRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> saveUnavailableDays({
    required List<Map<String, dynamic>> date,
  }) async {
    print(date);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
  mutation saveUnavailability(\$unavailabilityDates: [UnavailabilityInputType]!) {
  saveUnavailability(unavailabilityDates: \$unavailabilityDates) {
    message
  }
}
        ''', payload: {
        "unavailabilityDates": date,
      });
      print('CreatePostRepo Fetching user posts $result');

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) => Left(left), (right) {
        final parentMap = right?['message'];
        if (parentMap != null) {
          return Right(parentMap);
        }
        return Right({"message": "Something went wrong updating service"});
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getUnavailableDays(
      {int? pageCount, int? pageNumber, String? username}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
  query allUserUnavailability(\$pageNumber: Int, \$pageCount: Int, \$username: String) {
  allUserUnavailability(pageNumber: \$pageNumber, pageCount: \$pageCount, username: \$username) {
    id
    user {
      id
      username
      displayName
    }
    date
    startTime
    endTime
    allDay
    deleted
  }
}

        ''', payload: {
        "pageNumber": pageNumber,
        "pageCount": pageCount,
        'username': username,
      });

      return result.fold((left) {
        return Left(left);
      }, (right) {
        print("objectooo ${right!['allUserUnavailability'].length}");
        return Right(right['allUserUnavailability'] as List);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteUnavailableDay(
      int dayId) async {
    print(dayId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation deleteUnavailableDay(\$id: Int!) {
            deleteUnavailability(unavailabilityId: \$id) {
              message
            }
          }
        ''', payload: {
        "id": dayId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['deleteUnavailability']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
