import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

final myCreatePostInstance = PasswordChangeRepository.instance;

class PasswordChangeRepository {
  PasswordChangeRepository._();
  static PasswordChangeRepository instance = PasswordChangeRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> passwordChange({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation passwordChange(\$oldPassword:String!,\$newPassword1:String!,\$newPassword2:String!) {
            passwordChange(oldPassword:\$oldPassword,newPassword1:\$newPassword1,newPassword2:\$newPassword2) {
              success,
              errors,
              token,
            }
          }

        ''', payload: {
        'oldPassword': oldPassword,
        'newPassword1': newPassword1,
        'newPassword2': newPassword2
      });

      return result.fold((left) {
        return Left(left);
      }, (right) {
        print('Password change response $right');
        return Right(right!['passwordChange']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
