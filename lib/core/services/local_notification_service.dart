import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for important notifications',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    AndroidNotificationDetails androidDetails;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/notification_img.jpg';

        final response = await http.get(Uri.parse(imageUrl));
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        final bigPictureStyle = BigPictureStyleInformation(
          FilePathAndroidBitmap(filePath),
          contentTitle: title,
          summaryText: body,
        );

        androidDetails = AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigPictureStyle,
          largeIcon: FilePathAndroidBitmap(filePath),
          icon: '@mipmap/ic_launcher',
        );
      } catch (e) {
        print('❌ Error loading image for notification: $e');

        androidDetails = AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );
      }
    } else {
      androidDetails = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );
    }

    final details = NotificationDetails(android: androidDetails);
    await _notificationsPlugin.show(id, title, body, details);
  }
}
