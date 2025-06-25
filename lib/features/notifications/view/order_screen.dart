import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/firebase_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/http_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_cubit.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/view/widgets/order_screen_app_bar_widget.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/view/widgets/order_status_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationService = FirebaseNotificationService();

    return BlocProvider(
      create: (context) {
        final cubit = OrderCubit(notificationService, HttpService());
        notificationService.bindCubit(cubit);
        cubit.initializeNotifications();
        return cubit;
      },
      child: Scaffold(
        appBar: OrderScreenAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrderStatusSection(),
        ),
      ),
    );
  }
}
