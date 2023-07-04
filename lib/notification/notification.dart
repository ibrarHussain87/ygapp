import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOSInitialize = IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future<void> showTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'yurn_guru_app',
      'yurn_guru',
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  setDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();

    if (Platform.isAndroid) {
      token = await _firebaseMessaging.getToken();
    } else if (Platform.isIOS) {
      token = await _firebaseMessaging.getAPNSToken();
    }

    if (token != null) {
      SharedPreferenceUtil.addStringToSF(USER_DEVICE_TOKEN_KEY, token);
      print(token);
    }

    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      SharedPreferenceUtil.addStringToSF(USER_DEVICE_TOKEN_KEY, newToken);
      print(newToken);
    });
  }

  setNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // handle when app in active state
    forgroundNotification(flutterLocalNotificationsPlugin);

    // handle when app running in background state
    backgroundNotification(flutterLocalNotificationsPlugin);

    // handle when app completely closed by the user
    terminateNotification(flutterLocalNotificationsPlugin);

    // With this token you can test it easily on your phone
    final token =
        _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  forgroundNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);

        showTextNotification(
            message.notification!.title!,
            message.notification!.body!,
            "orderID",
            flutterLocalNotificationsPlugin);
      },
    );
  }

  backgroundNotification(flutterLocalNotificationsPlugin) {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
        showTextNotification(
            message.notification!.title!,
            message.notification!.body!,
            "orderID",
            flutterLocalNotificationsPlugin);
      },
    );
  }

  terminateNotification(flutterLocalNotificationsPlugin) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (initialMessage.data.containsKey('data')) {
        // Handle data message
        streamCtlr.sink.add(initialMessage.data['data']);
      }
      if (initialMessage.data.containsKey('notification')) {
        // Handle notification message
        streamCtlr.sink.add(initialMessage.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(initialMessage.notification!.title!);
      bodyCtlr.sink.add(initialMessage.notification!.body!);
      // showTextNotification(message.notification!.title!, message.notification!.body!, "orderID", flutterLocalNotificationsPlugin);

    }
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
