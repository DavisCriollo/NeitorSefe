// SHA1: 48:AD:6F:84:93:06:6C:3A:57:ED:43:81:13:E2:58:0F:82:70:C0:C4

// P8  Key ID:F5J43MKAL2    llave notific

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nseguridad/src/api/authentication_client.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/service/local_notifications.dart';
// import 'package:sincop_app/src/api/authentication_client.dart';
// import 'package:sincop_app/src/controllers/home_controller.dart';
// // import 'package:sincop_app/src/service/local_notificaciones.dart';
// import 'package:sincop_app/src/service/local_notifications.dart';

// class PushNotificationService extends ChangeNotifier {
// //   static final localNotification = LocalNotifications();
//   static final homeController = HomeController();

//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//   static String? token;
//   static StreamController<String> _messageStream = StreamController.broadcast();
//   static Stream<String> get messagesStream => _messageStream.stream;

//   static Future _backgroundHandler(RemoteMessage message) async {
//     print(' _backgroundHandler ${message.data}');
//     LocalNotificationsService.showNotification(
//       id: 0,
//       title: message.notification?.title ?? 'Sin título',
//       body: message.notification?.body ?? 'Sin cuerpo',
//       payload: message.data.toString(),
//     );
//   }

//   static Future _onMessageHandler(RemoteMessage message) async {
//     print(' _onMessageHandler ${message.data}');
//     LocalNotificationsService.showNotification(
//       id: 1,
//       title: message.notification?.title ?? 'Sin título',
//       body: message.notification?.body ?? 'Sin cuerpo',
//       payload: message.data.toString(),
//     );
//   }

//   static Future _onMessageOpenApp(RemoteMessage message) async {
//     print(' _onMessageOpenApp ${message.data}');
//     LocalNotificationsService.showNotification(
//       id: 2,
//       title: message.notification?.title ?? 'Sin título',
//       body: message.notification?.body ?? 'Sin cuerpo',
//       payload: message.data.toString(),
//     );
//   }

//   static Future initializeApp() async {
//     await Firebase.initializeApp();
//     await LocalNotificationsService.initialize(); // Inicializa las notificaciones locales
//     await requestPermission();

//     token = await FirebaseMessaging.instance.getToken();
//     print('Token FCM DESDE FCM: $token');
//      await Auth.instance.saveTokenFireBase(token!);
//     // homeController.setTokenFCM(token);



//     FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
//     FirebaseMessaging.onMessage.listen(_onMessageHandler);
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
//   }

//   static requestPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     print('Estado de las notificaciones push del usuario: ${settings.authorizationStatus}');
//   }

//   static closeStreams() {
//     _messageStream.close();
//   }


//  static void stopListening() {
//     FirebaseMessaging.instance.unsubscribeFromTopic('all'); // Deja de escuchar todas las notificaciones
//   }

//   static void resumeListening() {
//     FirebaseMessaging.instance.subscribeToTopic('all'); // Reanuda la escucha de todas las notificaciones
//   }




// }

// class PushNotificationService extends ChangeNotifier {
//   static final homeController = HomeController();

//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//   static String? token;
//   static StreamController<String> _messageStream = StreamController.broadcast();
//   static Stream<String> get messagesStream => _messageStream.stream;

//   static Future _backgroundHandler(RemoteMessage message) async {
//     print(' _backgroundHandler ${message.data}');
//     LocalNotificationsService.showNotification(
//       id: 0,
//       title: message.notification?.title ?? 'Sin título',
//       body: message.notification?.body ?? 'Sin cuerpo',
//       payload: message.data.toString(),
//     );
//   }

//   static Future _onMessageHandler(RemoteMessage message) async {
//     print(' _onMessageHandler ${message.data}');
//     LocalNotificationsService.showNotification(
//       id: 1,
//       title: message.notification?.title ?? 'Sin título',
//       body: message.notification?.body ?? 'Sin cuerpo',
//       payload: message.data.toString(),
//     );
//   }

// static Future _onMessageOpenApp(RemoteMessage message) async {
//   print(' _onMessageOpenApp ${message.data}');
//   // Enviar todo el payload al stream
//   _messageStream.add(message.data.toString());
// }

//   static Future initializeApp() async {
//     await Firebase.initializeApp();
//     await LocalNotificationsService.initialize(); // Inicializa las notificaciones locales
//     await requestPermission();

//     token = await FirebaseMessaging.instance.getToken();
//     print('Token FCM DESDE FCM: $token');
//     await Auth.instance.saveTokenFireBase(token!);

//     FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
//     FirebaseMessaging.onMessage.listen(_onMessageHandler);
//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
//   }

//   static requestPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     print('Estado de las notificaciones push del usuario: ${settings.authorizationStatus}');
//   }

//   static closeStreams() {
//     _messageStream.close();
//   }

//   static void stopListening() {
//     FirebaseMessaging.instance.unsubscribeFromTopic('all'); // Deja de escuchar todas las notificaciones
//   }

//   static void resumeListening() {
//     FirebaseMessaging.instance.subscribeToTopic('all'); // Reanuda la escucha de todas las notificaciones
//   }
// }


class PushNotificationService extends ChangeNotifier {
  static final homeController = HomeController();

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print(' _backgroundHandler ${message.data}');
     _messageStream.sink.add('${message.data}');
    LocalNotificationsService.showNotification(
      id: 0,
      title: message.notification?.title ?? 'Sin título',
      body: message.notification?.body ?? 'Sin cuerpo',
      payload: message.data.toString(),
    );
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print(' _onMessageHandler sdfsdf ${message.data}');
         _messageStream.sink.add('${message.data}');
    LocalNotificationsService.showNotification(
      id: 1,
      title: message.notification?.title ?? 'Sin título',
      body: message.notification?.body ?? 'Sin cuerpo',
      payload: message.data.toString(),
    );
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print(' _onMessageOpenApp ${message.data}');
    // Enviar todo el payload al stream
    _messageStream.add(message.data.toString());
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    await LocalNotificationsService.initialize(); // Inicializa las notificaciones locales
    await requestPermission();

    token = await FirebaseMessaging.instance.getToken();
    print('Token FCM DESDE FCM: $token');
    await Auth.instance.saveTokenFireBase(token!);

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Estado de las notificaciones push del usuario: ${settings.authorizationStatus}');
  }

  static closeStreams() {
    _messageStream.close();
  }

  static void stopListening() {
    FirebaseMessaging.instance.unsubscribeFromTopic('all'); // Deja de escuchar todas las notificaciones
  }

  static void resumeListening() {
    FirebaseMessaging.instance.subscribeToTopic('all'); // Reanuda la escucha de todas las notificaciones
  }
}