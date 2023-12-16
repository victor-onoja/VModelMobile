import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class ReportAccountRepository {
  ReportAccountRepository._();
  static ReportAccountRepository instance = ReportAccountRepository._();

  /// Block User
  Future<Either<CustomException, Map<String, dynamic>>> reportAccount({
    required String userName,
    required String reason,
    String? content,
  }) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation reportAccount(\$username: String!, \$reason: String!,
         \$content: String) {
          reportAccount(username: \$username, reason: \$reason,
           content: \$content) {
            message
          }
        }
      ''',
        payload: {
          'username': userName,
          'reason': reason,
          'content': content,
        },
      );

      return result.fold(
        (left) => Left(left),
        (right) {
          print(right);
          return Right(right!['reportAccount']);
        },
      );
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
