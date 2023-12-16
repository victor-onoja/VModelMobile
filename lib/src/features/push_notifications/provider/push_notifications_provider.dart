import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/push_notifications/repository/push_notifications.dart';

// final MessageRepository _messageRepository = MessageRepository.instance;
// final messageRepository = MessageRepository.instance;

final pushNotificationProvider =
    Provider<PushRepository>((ref) => PushNotificationRepository());

class MessageNotifier extends ChangeNotifier {
  MessageNotifier(this.ref) : super();
  final Ref ref;

  Future<String?> sendFcmToken(String token) async {
    final repository = ref.read(pushNotificationProvider);
    final response = await repository.sendFCMToken(token);
    return response;
  }
}
