import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class FCM {
  RemoteMessage? _messages;
  BuildContext? _context;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> _downloadAndSaveImage(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';

    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }

  Future<void> _showLocalNotification(
      String? title, String? body, String? imageUrl) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true);

    var android = const AndroidInitializationSettings('@mipmap/branding');
    var initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
            android: android, iOS: initializationSettingsDarwin),
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    var androidPlatformChannelSpecifics =
        const AndroidNotificationDetails("VModel", "VModel",
            importance: Importance.max,
            playSound: true,
            showProgress: true,
            priority: Priority.high,
            ticker: 'test ticker',
            // largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            icon: "");

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: DarwinNotificationDetails(
            categoryIdentifier: "plainCategory",
            attachments: [
              DarwinNotificationAttachment(
                  await _downloadAndSaveImage(imageUrl!, 'image.jpg'),
                  identifier: 'image')
            ],
            presentSound: true,
            presentAlert: true,
            presentBadge: true));

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  setNotifications(context) {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    //background click handle call back
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleClick(context, message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleClick(context, message);
      }
    });

    // foreground message
    // FirebaseMessaging.onMessage.listen((message) async {
    //   _messages = message;
    //   _context = context;
    //   _showLocalNotification(message.notification!.title,
    //       message.notification!.body, message.notification?.apple!.imageUrl);
    // });
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    handleClick(_context!, _messages!);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    print("payload: $_messages");
    if (notificationResponse.payload != null) {
      handleClick(_context!, _messages!);
    }
  }

  handleClick(BuildContext context, RemoteMessage message) {
    if (message.data['click_action'] == '') {
    } else if (message.data['click_action'] == '') {
    } else if (message.data['click_action'] == '') {
    } else if (message.data['click_action'] == '') {}
  }

  void clearNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}

// background message
Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
}
