import 'dart:convert';

import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:web_socket_channel/io.dart';

import '../../../core/network/urls.dart';
import '../repository/message_repo.dart';

// final MessageRepository _messageRepository = MessageRepository.instance;
// final messageRepository = MessageRepository.instance;

final messageProvider =
    Provider<MessagingRepository>((ref) => MessagesRepository());

final getConversations =
    FutureProvider<Either<CustomException, List<dynamic>>>((ref) async {
  return ref.read(messageProvider).getConversations();
});

final getArchivedConversations =
    FutureProvider<Either<CustomException, List<dynamic>>>((ref) async {
  return ref.read(messageProvider).getArchivedConversations();
});

final getConversation = FutureProvider.autoDispose
    .family<Either<CustomException, List<dynamic>>, int>((ref, id) async {
  return ref.read(messageProvider).getConversation(id);
});

final archiveConversation = FutureProvider.autoDispose
    .family<Either<CustomException, String>, int>((ref, id) async {
  return ref.read(messageProvider).archiveConversation(id);
});

class MessageNotifier extends ChangeNotifier {
  MessageNotifier(this.ref) : super();
  final Ref ref;

  Future<String?> createChat(String name, String recipient) async {
    final repository = ref.read(messageProvider);
    final response = await repository.createChat(name, recipient);
    return response;
  }

  void sendMessage(String message) {
    final repository = ref.read(messageProvider);
    final response = repository.sendMessage(message);
    return response;
  }
}

// Future<String?> createChat(String name, String recipient) async {
//   final repository = ref.read(messageProvider);
//   final response = await messageProvider..createChat(name, recipient);
//   return response;
// }

// void startListeningForMessages() {

//   messageRepository.startListeningForMessages();
// }

final switchedProvider = StateProvider<bool>((ref) => false);
final connectedStatusProvider = StateProvider<bool>((ref) => false);
final cycleStatusProvider = StateProvider<int>((ref) => 0);
final forceStatusProvider = StateProvider<int>((ref) => 0);

final webSocketProvider = StateProvider<IOWebSocketChannel>((ref) {
  // final channel = IOWebSocketChannel.connect(Uri.parse('wss://vmodel-app.herokuapp.com/ws/chat/68/'));
  final channel = IOWebSocketChannel.connect(
      Uri.parse('${VUrls.webSocketBaseUrl}/chat/68/'));
  ref.onDispose(() => channel.sink.close());
  return channel;
});

void updateStateFromMessage(String message, WidgetRef ref) {
  print(message);
  Map<String, dynamic> jsondat = json.decode(message);
  String data = json.encode(jsondat);
  if (data.contains("connected")) {
    ref.read(connectedStatusProvider.notifier).state = true;
    ref.read(cycleStatusProvider.notifier).state = jsondat['cycle'];
    ref.read(forceStatusProvider.notifier).state = jsondat['force'];
  }
}

final providerOfMessages = StreamProvider.autoDispose<String>(
  (ref) async* {
    final channel = ref.watch(webSocketProvider);
    // Close the connection when the stream is destroyed
    ref.onDispose(() => channel.sink.close());

    await for (final value in channel.stream) {
      yield value.toString();
    }
  },
);

final getMessages = StreamProvider.autoDispose((ref) async* {
  print('here now');
  final response = ref.watch(messageProvider).startListeningForMessages();
  yield response;
  yield null;
});

final getNotifications = StreamProvider.autoDispose<Object?>((ref) {
  print('here now');
  final response = ref.read(messageProvider).startListeningForNotifications();
  return response;
});

  // void stopListeningForMessages() {
  //   final messageRepository = MessageRepository.instance;
  //   messageRepository.stopListeningForMessages();
  // }
