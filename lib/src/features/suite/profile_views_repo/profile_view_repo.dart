import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';

import '../../../core/utils/exception_handler.dart';

class ProfileViewRepo {
  ProfileViewRepo._();
  static ProfileViewRepo instance = ProfileViewRepo._();

  Future<Either<CustomException, Map<String, dynamic>>> getDailyProfileViews(
      String filterBy) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query profileViewCount(\$filterBy: String) {
  profileViewCount(filterBy: \$filterBy) {
 	totalViewsGraph
  }
}
''', payload: {
        "filterBy": filterBy,
      });

      return result.fold((left) {
        print("nlkwenmfsdlvdd ${left.toString()}");
        return Left(left);
      }, (right) {
        return Right(right!['profileViewCount']);
      });
    } on CustomException catch (e, stack) {
      print("nlkwenmfsdlv ${stack} $e");
      return Left(CustomException(e.toString()));
    }
  }
}
