// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// class FirebaseApi {
//   Future<void> initNotifications() async {
//     final token = await FirebaseMessaging.instance.getToken();

//     if (kDebugMode) {
//       print("Token: $token");
//     }

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print("message recieved");
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print("message clicked");
//       }
//     });
//   }
// }
