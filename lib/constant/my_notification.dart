//
// import 'package:bpro_app_wallet/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// class MyNotification {
//   static Future<void> initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//         new AndroidInitializationSettings('logo');
//     // var iOSInitialize = IOSInitializationSettings();
//     var initializationsSettings =
//         InitializationSettings(android: androidInitialize);
//     flutterLocalNotificationsPlugin.initialize(initializationsSettings,
//        );
//
//
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       showNotification(message, flutterLocalNotificationsPlugin,
//           message.notification == null);
//     });
//
//
//   }
//
//   static late String? url;
//
//   static Future<void> showNotification(RemoteMessage message,
//       FlutterLocalNotificationsPlugin fln, bool data) async {
//     String _title;
//     String _body;
//     if (data) {
//       _title = message.data['title'];
//       _body = message.data['body'];
//
//
//     } else {
//       _title = message.notification!.title!;
//       _body = message.notification!.body!;
//     }
//     showTextNotification(_title, _body, fln);
//   }
// }
//
// Future<void> showTextNotification(
//     String title, String body, FlutterLocalNotificationsPlugin fln) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     playSound: true,
//     importance: Importance.max,
//     priority: Priority.max,
//     sound: RawResourceAndroidNotificationSound('notification'),
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await fln.show(
//     DateTime.now().millisecond,
//     title,
//     body,
//     platformChannelSpecifics,
//   );
// }
//
// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   // print(message.data);
//   MyNotification.showNotification(
//       message, flutterLocalNotificationsPlugin, message.notification == null);
//
//   //print("onBackground: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
// }
