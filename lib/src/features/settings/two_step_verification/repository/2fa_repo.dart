import 'package:either_option/either_option.dart';

import '../../../../app_locator.dart';
import '../../../../core/utils/exception_handler.dart';

class TwoStepVerificationRepository {
  TwoStepVerificationRepository._();

  //For debugging purposes only
  final _TAG = '2FARepository';

  static TwoStepVerificationRepository instance =
      TwoStepVerificationRepository._();

  Future<Either<CustomException, Map<String, dynamic>>>
      getTwoStepVerificationStatus() async {
    _tagPrint("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH getting me");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
        query{
          viewMe{
            id
            username
            use2fa
          }
        }
        ''', payload: {});

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        final profile = right!['viewMe'];
        return Right(profile);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateProfile({
    // int? id,
    bool? use2fa,
  }) async {
    try {
      final response =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
           mutation updateProfile(\$use2fa: Boolean) {
            updateProfile(use2fa: \$use2fa) {
              user {
                id
                username
                use2fa
              }
            }
          }

        ''', payload: {
        // 'id': id ,
        // 'profilePictureUrl': profilePictureUrl,
        'use2fa': use2fa,
      });

      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) => Left(left),
              (right) => Right(right!['updateProfile']['user']));
      return result;
    } catch (e) {
      _tagPrint('Error updating profile picture in  ===> $e');
      return Left(CustomException(e.toString()));
    }
  }

  String _tagPrint(String message) {
    return '[$_TAG] $message';
  }
}
