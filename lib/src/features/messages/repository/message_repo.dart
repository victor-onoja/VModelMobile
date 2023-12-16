import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/network/graphql_confiq.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../app_locator.dart';
import '../../../core/network/urls.dart';
import '../../../core/utils/exception_handler.dart';

// class MessageRepository {
//   MessageRepository._();
//   static MessageRepository instance = MessageRepository._();
//   final WebSocketChannel channel = IOWebSocketChannel.connect(
//       'wss://vmodel-app.herokuapp.com/ws/graphql/?token=e91f954ec2ace103c012cb540c315829a868b492');

//   StreamSubscription? _messageSubscription;

//   Future<String?> createChat(String name, String recipient) async {
//     try {
//       final event = await vBaseServiceInstance.mutationQuery(
//         mutationDocument: '''
//         mutation CreateChat(\$name: String!, \$recipient: String!) {
//           createChat(name: \$name, recipient: \$recipient) {
//             chat {
//               id
//             }
//           }
//         }
//       ''',
//         payload: {'name': name, 'recipient': recipient},
//       );

//       final Either<CustomException, Map<String, dynamic>?> chatevent = event;

//       return chatevent.fold(
//         (left) {
//           print('Error creating chat: ${left.message}');
//           return null;
//         },
//         (right) {
//           final chatId = right?['createChat']?['chat']?['id'] as String?;
//           return chatId;
//         },
//       );
//     } catch (e) {
//       print('Error creating chat: $e');
//       return null;
//     }
//   }

//   Future<int?> sendMessage(String message, int chatId) async {
//     try {
//       final event = await vBaseServiceInstance.mutationQuery(
//         mutationDocument: '''
//         mutation SendMessage(\$message: String!, \$chatId: Int!) {
//           sendMessage(message: \$message, chatId: \$chatId) {
//             message {
//               id
//             }
//           }
//         }
//       ''',
//         payload: {'message': message, 'chatId': chatId},
//       );

//       final Either<CustomException, Map<String, dynamic>?> sendevent = event;

//       return sendevent.fold(
//         (left) {
//           print('Error sending message: ${left.message}');
//           return null;
//         },
//         (right) {
//           final messageId = right?['sendMessage']?['message']?['id'];
//           return messageId is int ? messageId : null;
//         },
//       );
//     } catch (e) {
//       print('Error sending message: $e');
//       return null;
//     }
//   }

//   Future<void> startListeningForMessages() async {
//     _messageSubscription = channel.stream.listen((message) {
//       print('Received message: $message');
//     });

//     // Send the subscription query to start receiving messages
//     const subscriptionQuery = '''
//     subscription {
//       newMessage(chatroom: "gg500") {
//         message {
//           conversationSet {
//             members {
//               username
//             }
//             messages {
//               text
//             }
//           }
//         }
//       }
//     }
//     ''';
//     channel.sink.add(subscriptionQuery);
//   }

//   void stopListeningForMessages() {
//     _messageSubscription?.cancel();
//     _messageSubscription = null;
//   }
// }

abstract class MessagingRepository {
  Future<String?> createChat(String name, String recipient);
  void sendMessage(String message);
  Stream startListeningForMessages();
  Stream<QueryResult<Object?>> startListeningForNotifications();
  Future<Either<CustomException, List<dynamic>>> getConversations();
  Future<Either<CustomException, List<dynamic>>> getArchivedConversations();
  Future<Either<CustomException, List<dynamic>>> getConversation(int id);
  Future<Either<CustomException, String>> archiveConversation(int id);
}

class MessagesRepository implements MessagingRepository {
  static var token = VCredentials.inst.getRestToken() as String;

  static final WebSocketLink channel = WebSocketLink(
      // 'wss://vmodel-app.herokuapp.com/ws/graphql/',
      // 'wss://uat-api.vmodel.app/ws/graphql/',
      VUrls.webSocketUrl,
      config: const SocketClientConfig(
          autoReconnect: true, inactivityTimeout: Duration(seconds: 30)));

  final socketClient = GraphQLClient(
      link: GraphQlConfig.authLink.concat(channel), cache: GraphQLCache());

  @override
  Stream startListeningForMessages() async* {
    // Send the subscription query to start receiving messages
    // final wsUrl = Uri.parse('wss://vmodel-app.herokuapp.com/ws/chat/68/');

    // final wsUrl = Uri.parse('wss://uat-api.vmodel.app/ws/chat/68/');
    final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/68/');
    WebSocketChannel channel = IOWebSocketChannel.connect(wsUrl, headers: {
      "authorization": "Token db7332bc628836d65a48ed4a872b209fed2ac05e"
    });
    print(channel.stream);

    channel.stream.listen((message) {
      print(message);
      // if (message.hasException) {
      //   print(message.exception.toString());
      //   return;
      // }

      // if (message.isLoading) {
      //   print('awaiting events');
      //   return;
      // }

      // print('New Review: ${message.data}');
    });
    print('object');
    yield channel.stream;
    yield null;
  }

  @override
  Stream<QueryResult<Object?>> startListeningForNotifications() async* {
    // Send the subscription query to start receiving messages
    String subscriptionQuery = '''
    subscription (\$notificationRoom: String){
  newNotification(notificationRoom: \$notificationRoom){
    notification {
      id
      profilePictureUrl
      message
      model
      modelId
      modelGroup
      read
      post{
        id
        caption
      }
      createdAt
    }
  }
}
    ''';
    Map<String, dynamic> payload = {'notificationRoom': 'olufemi'};
    final SubscriptionOptions options = SubscriptionOptions(
        document: gql(subscriptionQuery), variables: payload);
    final res = socketClient.subscribe(options);

    print(channel.url);

    res.listen((event) {
      if (event.hasException) {
        print(event.exception.toString());
        return;
      }

      if (event.isLoading) {
        print('awaiting events');
        return;
      }

      print('New Review: ${event.data}');
    });
    print('object');

    yield* socketClient.subscribe(options);
  }

  // void stopListeningForMessages() {
  //   _messageSubscription?.cancel();
  //   _messageSubscription = null;
  // }

  @override
  Future<String?> createChat(String name, String recipient) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final event = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation CreateChat(\$name: String!, \$recipient: String!) {
          createChat(name: \$name, recipient: \$recipient) {
            chat {
              id
            }
          }
        }
      ''',
        payload: {'name': name, 'recipient': recipient},
      );

      final Either<CustomException, Map<String, dynamic>?> chatevent = event;

      return chatevent.fold(
        (left) {
          print('Error creating chat: ${left.message}');
          return null;
        },
        (right) {
          final chatId = right?['createChat']?['chat']?['id'] as String?;
          prefs.setInt('id', int.parse(chatId!));
          print(chatId);
          return chatId;
        },
      );
    } catch (e) {
      print('Error creating chat: $e');
      return null;
    }
  }

  @override
  void sendMessage(String message) async {
    // final wsUrl = Uri.parse('wss://vmodel-app.herokuapp.com/ws/chat/67/');
    final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/67/');
    // final wsUrl = Uri.parse('wss://uat-api.vmodel.app/ws/chat/67/');

    WebSocketChannel channel = IOWebSocketChannel.connect(wsUrl, headers: {
      "authorization": "Token db7332bc628836d65a48ed4a872b209fed2ac05e"
    });
    var text = jsonEncode(<String, String>{"message": message});
    channel.sink.add(text);
  }

  @override
  Future<Either<CustomException, List<dynamic>>> getConversations() async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query conversations {
  conversations{
    id
    name
    recipient{
      firstName
      lastName
      username
      profilePictureUrl
      thumbnailUrl
      userType
    }
    lastMessage{
      text
      read
      createdAt
    }
    createdAt
    lastModified
  }
}
        ''', payload: {});

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['conversations'] as List<dynamic>?;
        log("this $albumList");
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, List<dynamic>>> getConversation(int id) async {
    print('CreatePostRepo Fetching user posts');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query conversation(\$id: ID!) {
  conversation(id: \$id){
    id
    senderName
    attachment
    isItem
    itemId
    itemType
    text
    read
    createdAt
    deleted
    receiverProfile
  }
}
        ''', payload: {
        'id': id,
      });

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        print("7777777777777 $right");

        final albumList = right?['conversation'] as List<dynamic>?;
        log("this $albumList");
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, String>> archiveConversation(int id) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      mutation archiveConversation(\$conversationId: Int!) {
        archiveConversation(conversationId: \$conversationId){
         message
        }
      }
        ''', payload: {
        'conversationId': id,
      });

      final Either<CustomException, String> response = result.fold((left) {
        print("archiveConversation ${left.message}");
        return Left(left);
      }, (right) {
        print("archiveConversation $right");

        final message = right?['archiveConversation'] as String?;

        return Right(message!);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  @override
  Future<Either<CustomException, List>> getArchivedConversations() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query archivedConversations {
  archivedConversations{
    id
    name
    recipient{
      firstName
      lastName
      username
      profilePictureUrl
      thumbnailUrl
      userType
    }
    lastMessage{
      text
      read
      createdAt
    }
    createdAt
    lastModified
  }
}
        ''', payload: {});

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['archivedConversations'] as List<dynamic>?;
        log("this $albumList");
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
