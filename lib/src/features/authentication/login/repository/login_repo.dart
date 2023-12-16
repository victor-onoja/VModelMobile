import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

final loginRepoInstance = LoginRepository.instance;

class LoginRepository {
  LoginRepository._();
  static LoginRepository instance = LoginRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> loginWithEmail(
      String email, String password) async {
    print('IIIIIIIIIIIIII login with email');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation TokenAuth(\$email: String!, \$password: String!) {
            tokenAuth(email: \$email, password: \$password) {
              success
              use2fa
              token
              restToken
              errors
              user{
                username
                lastName
                firstName
                isActive
                bio
                id
                pk
               }
            }
          }
        ''', payload: {
        'email': email,
        'password': password,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['tokenAuth']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException('${e.toString()} \n ${StackTrace.current}'));
      // return Left(CustomException(e.toString()));
    }
  }

  //make a call to loginwith username

  Future<Either<CustomException, Map<String, dynamic>>> loginWithUserName(
      String username, String password) async {
    print('IIIIIIIIIIIIII login with username');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
         mutation TokenAuth(\$username: String!, \$password: String!) {
            tokenAuth(username: \$username, password: \$password) {
              success
              use2fa
              token
              restToken
              errors
              user{
                username
                lastName
                firstName
                isActive
                bio
                id
                pk
               }
            }
          }
        ''', payload: {
        'username': username,
        'password': password,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        return Right(right!['tokenAuth']);
      });

      return userName;
    } catch (e) {
      print("================================>$e");
      return Left(CustomException('${e.toString()} \n ${StackTrace.current}'));
      // return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> verify2FACode(
      {required String code, String? username, String? email}) async {
    print(
        'IIIIIIIIIIIIII verify 2fa otp: $code username: $username email: $email');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation verify2FAOtpCod(\$code: String!, \$email: String,
             \$username: String) {
              verifyOtpCode(code: \$code, email: \$email,
               username: \$username) {
                token
                restToken
                message
                user {
                  username
                }
              }
            }
        ''', payload: {
        'code': code,
        'username': username,
        'email': email,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        return Right(right!['verifyOtpCode']);
      });

      return userName;
    } catch (e) {
      print("================================>$e");
      return Left(CustomException('${e.toString()} \n ${StackTrace.current}'));
      // return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> socialAuth(
      String provider,
      String accessToken,
      String firstName,
      String lastName) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation SocialAuth(\$provider: String!, \$accessToken: String!,\$firstName: String!,\$lastName: String!) {
           socialAuth(provider: \$provider, accessToken: \$accessToken,firstName: \$firstName,lastName: \$lastName,) {
               social{
               id
               provider
               uid
               extraData
               created
               modified
               }
               token
               user{
               id
               firstName
               lastName
               }
            }
           }
        ''', payload: {
        'provider': provider,
        'accessToken': accessToken,
        'firstName': firstName,
        'lastName': lastName,
      });

      final Either<CustomException, Map<String, dynamic>> userName = result
          .fold((left) => Left(left), (right) => Right(right!['socialAuth']));

      print(userName.left);
      print('user iss');
      print(userName.right);
      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
