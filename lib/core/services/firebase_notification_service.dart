import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/local_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_cubit.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  OrderCubit? _orderCubit;

  // pass the cubit to the service for update the status after recieve notification from firebase console
  void bindCubit(OrderCubit cubit) {
    _orderCubit = cubit;
  }

  // get the fcm token
  Future<String?> getDeviceToken() async {
    return await _fcm.getToken();
  }

  // initialize the firebase messaging service
  Future<void> initialize() async {
    // request notification permission
    NotificationSettings settings = await _fcm.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Notification permission granted');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('❌ Notification permission denied');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      print('⚠️ Notification permission not determined');
    }

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final data = message.data;

      if (notification != null) {
        LocalNotificationService.showNotification(
          id: message.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          imageUrl: notification.android?.imageUrl,
        );
      }
      _handleStatusUpdate(data, notification);
    });
    // Listen for background notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📬 Notification tapped: ${message.notification?.title}');

      final notification = message.notification;
      final data = message.data;

      _handleStatusUpdate(data, notification);
    });
  }

  // Listen for notifications when the app is closed
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
        imageUrl: notification.android?.imageUrl,
      );
    }
  }

  // Handle state updates in ui after notification
  Future<void> _handleStatusUpdate(
    Map<String, dynamic> data,
    RemoteNotification? notification,
  ) async {
    if (_orderCubit == null || !data.containsKey('status')) return;

    final status = data['status']?.toLowerCase();
    const statusMap = {
      'pending': 0,
      'confirmed': 1,
      'shipped': 2,
      'delivered': 3,
    };
    final index = statusMap[status];

    if (index != null) {
      _orderCubit!.updateOrderStatusFromFirebaseNotification(index);
      print('📦 Order status updated to: $status');
    }
  }
}
