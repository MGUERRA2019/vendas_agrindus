import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  //class to set up notification services. Using Cloud Messaging (Firebase). To local notifications, read the docs of the plugin flutter_local_notifications.

  final FirebaseMessaging _fcm = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails platformChannelSpecifics;

  Future initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('agrindusnotification');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('vendas_agrindus',
            'Notificações Vendas Agrindus', 'vendas_agrindus_description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);
    platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    _fcm.configure(
      onBackgroundMessage: backgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _processmessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _processmessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _processmessage(message);
      },
    );
    print('TOKEN: ${await _fcm.getToken()}');
  }

  void _processmessage(message) {
    _pushNotificationManager(message);
  }

  void _pushNotificationManager(message) async {
    String payload;
    if (Platform.isIOS) {
      payload = message['payload'];
    } else {
      payload = message['data']['payload'];
    }
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
    );
  }

  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      return data;
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      return notification;
    }
    // Or do other work.
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

  Future onSelectNotification(String payload) {
    //For future treatment of other notifications, use strategy pattern (factories)
    print('Completed');
  }
}
