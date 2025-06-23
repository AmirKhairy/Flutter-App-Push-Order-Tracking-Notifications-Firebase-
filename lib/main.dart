import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/firebase_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/local_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/firebase_options.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/view/order_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(
    FirebaseNotificationService.firebaseMessagingBackgroundHandler,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OrderScreen(), debugShowCheckedModeBanner: false);
  }
}
