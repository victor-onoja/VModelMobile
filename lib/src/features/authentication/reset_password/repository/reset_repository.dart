import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

final resetRepoInstance = ResetRepository.instance;

class ResetRepository {
  ResetRepository._();
  static ResetRepository instance = ResetRepository._();

  //
  Future<Either<CustomException, Map<String, dynamic>>> resestPassword(
    String email,
  ) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
        # mutation SendPasswordResetEmail(\$email: String!) {
        #   sendPasswordResetEmail(email: \$email) {
        #     errors
        #     success
        #   }
        #}

         mutation SendPasswordResetEmail(\$email: String!) {
          resetPassword(
            email: \$email) {
            message
          }
         }
        ''', payload: {
        'email': email,
      });

      return result.fold(
          (left) => Left(left), (right) => Right(right!["resetPassword"]));
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> resetUserPassword({
    required String otpCode,
    required String email,
    required String newPassword1,
    // required String newPassword2,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
#  mutation passwordReset(
#    \$token: String!,
#    \$newPassword1: String!,
#    \$newPassword2: String!,
#  ) {
#  passwordReset(token:\$token, newPassword1: \$newPassword1,
#   newPassword2: \$newPassword2){
#    success
#    errors
#  }
#}

        mutation passwordReset(\$code: String!,
          \$email: String!,
          \$password: String!) {
          passwordReset(code: \$code,
            email: \$email,
            password: \$password) {
            message
            token
            restToken
          }
        }
        ''', payload: {
        'code': otpCode,
        'email': email,
        'password': newPassword1,
        // 'newPassword2': newPassword2
      });

      return result.fold((left) => Left(left), (right) {
        print('[wow] password reset is $right');
        // return Right(right!['passwordReset']);
        return Right(right!['passwordReset']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
