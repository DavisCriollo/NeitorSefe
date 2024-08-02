

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

// class LocalNotificationsService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//         static final onNotification = BehaviorSubject<String?>();


//   static Future<void> initialize() async {
//     final InitializationSettings initializationSettings =
//         const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'), // Especifica el icono de tu app aquí
//       iOS: IOSInitializationSettings(),
//     );

//     await _notificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (String? payload) async {
//         onNotification.add(payload);
//       },
//     );
//   }

//   static Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       // 'your_channel_id', // Personaliza tu ID de canal
//       // 'your_channel_name', // Personaliza tu nombre de canal
//        'neitor', // Personaliza tu ID de canal
//       'NeitorSafe', // Personaliza tu nombre de canal
//      channelDescription: 'Sistema de seguridad integral',
// //         importance: Importance.max,
//        sound: RawResourceAndroidNotificationSound('ipsnapchat'),
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: IOSNotificationDetails(),
//     );

//     await _notificationsPlugin.show(
//       id,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: payload,
//     );
//   }



// }

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future<void> initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'), // Especifica el icono de tu app aquí
      iOS: IOSInitializationSettings(),
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        onNotification.add(payload);
      },
    );
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'neitor', // Personaliza tu ID de canal
      'NeitorSafe', // Personaliza tu nombre de canal
      channelDescription: 'Sistema de seguridad integral',
      sound: RawResourceAndroidNotificationSound('ipsnapchat'),
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: IOSNotificationDetails(),
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
