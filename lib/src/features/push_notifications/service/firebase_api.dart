import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_history_main.dart';

import '../../../core/cache/local_storage.dart';
import '../../../core/repository/fcm_repo.dart';
import '../../../core/routing/navigator_1.0.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Tittle : ${message.notification?.title}');
  print('Tittle : ${message.notification?.body}');
  print('Tittle : ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('called');
    AppNavigatorKeys.instance.navigatorKey.currentState
        ?.pushNamed(NotificationMain.route, arguments: message);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    VModelSharedPrefStorage().putString("fcmToken", fCMToken);
    FCMRepository.instance.updateFcmToken(fcmToken: fCMToken!);

    print('Token :$fCMToken');

    initPushNotification();
    initLocalNotifications();
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@mipmap/ic_launcher'),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    // const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (notificationResponse) {
        // final message = RemoteMessage.fromMap(payload.payload.);
        // payload.payload.

        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          print('notification payload: $payload');
          AppNavigatorKeys.instance.navigatorKey.currentState
              ?.pushNamed(NotificationMain.route, arguments: payload);
        }
      },
      onDidReceiveNotificationResponse: (notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          print('notification payload: $payload');
          AppNavigatorKeys.instance.navigatorKey.currentState
              ?.pushNamed(NotificationMain.route, arguments: payload);
        }
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }
}
