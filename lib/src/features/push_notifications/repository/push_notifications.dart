import 'dart:async';

import 'package:either_option/either_option.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_locator.dart';
import '../../../core/utils/exception_handler.dart';

abstract class PushRepository {
  Future<String?> sendFCMToken(String token);
}

class PushNotificationRepository implements PushRepository {
  @override
  Future<String?> sendFCMToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final event = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation updateFcmToken(\$fcmToken: String!) {
          updateFcmToken(fcmToken: \$fcmToken) {
            UpdateFcmToken{
              success
            }
          }
        }
      ''',
        payload: {'fcmToken': token},
      );

      final Either<CustomException, Map<String, dynamic>?> chatevent = event;
      print('Error creating push notification');

      return chatevent.fold(
        (left) {
          print('Error creating chat: ${left.message}');
          return null;
        },
        (right) {
          final chatId = right?['updateFcmToken'] as String?;
          print(chatId);
          return chatId;
        },
      );
    } catch (e) {
      print('Error creating chat: $e');
      return null;
    }
  }
}
