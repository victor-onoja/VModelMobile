import 'package:either_option/either_option.dart';
// import 'package:get/get.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

final myCreatePostInstance = AccountSecurityRepository.instance;

class AccountSecurityRepository {
  AccountSecurityRepository._();
  static AccountSecurityRepository instance = AccountSecurityRepository._();
  Future<Either<CustomException, bool>> deactivateAccount(
      {required String password}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
           mutation deactivateAccount(\$password: String!) {
             deleteAccount(password:\$password){
              success
              errors
              }
           }
        ''', payload: {
        'password': password,
      });

      return result.fold((left) => Left(left),
          (right) => Right(right!['deleteAccount']['success']));
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
