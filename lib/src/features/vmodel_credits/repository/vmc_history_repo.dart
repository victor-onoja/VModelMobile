import 'package:either_option/either_option.dart';

import '../../../app_locator.dart';
import '../../../core/utils/exception_handler.dart';

class VMCRepository {
  VMCRepository._();

  static VMCRepository instance = VMCRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> vmcHistory({
    int? pageCount,
    int? pageNumber,
  }) async {
    print("Fetching VMV History");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
     query (\$pageNumber: Int, \$pageCount: Int) {
        vmcPointsHistory (pageNumber:\$pageNumber,pageCount: \$pageCount
        ) {
          id
          action
          pointsEarned
          user{
            username
          }
        }
        vmcPointsHistoryTotalNumber
        vmcPointsTotal
      }
        ''', payload: {
        "pageCount": pageCount,
        "pageNumber": pageNumber,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right!);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> vmcLeaderboard() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
     query leaderboard {
  leaderboard {
    id
    username
    displayName
    userType
    thumbnailUrl
    totalPoints
  }
}
        ''', payload: {});

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right!);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
