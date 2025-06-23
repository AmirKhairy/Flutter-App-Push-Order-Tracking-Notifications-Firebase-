import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/local_notification_service.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    NotificationSettings settings = await _fcm.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Notification permission granted');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('❌ Notification permission denied');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      print('⚠️ Notification permission not determined');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        LocalNotificationService.showNotification(
          id: message.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📬 Notification tapped: ${message.notification?.title}');
      // You can navigate to a specific screen here
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print('📥 Background FCM message: ${message.messageId}');

    final notification = message.notification;
    if (notification != null) {
      await LocalNotificationService.showNotification(
        id: message.hashCode,
        title: notification.title ?? '',
        body: notification.body ?? '',
      );
    }
  }

  Future<String?> getDeviceToken() async {
    return await _fcm.getToken();
  }
}
