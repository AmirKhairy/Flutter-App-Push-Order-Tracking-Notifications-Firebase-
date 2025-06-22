import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/firebase_options.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/view/order_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
