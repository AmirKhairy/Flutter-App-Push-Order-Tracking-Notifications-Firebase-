import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/firebase_notification_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/core/services/http_service.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_cubit.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_state.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/view/widgets/order_bar_row_widget.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/view/widgets/order_screen_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderCubit(FirebaseNotificationService(), HttpService())
            ..initializeNotifications(),
      child: Scaffold(
        appBar: OrderScreenAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              final cubit = OrderCubit.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Wed, 12 Sep",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Order ID: 1234",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  OrderBarRow(
                    active: cubit.currentOrderStatusIndex >= 0,
                    stateName: "Pending",
                    stateIcon: Icons.pending,
                    iconColor: Colors.orange,
                    buttonName:
                        (state is SentNotificationLoadingState &&
                            cubit.currentButtonSendingIndex == 0)
                        ? "Loading..."
                        : "Make Pending",
                    buttonOnTap: () {
                      final oldStatus =
                          cubit.orderStatuses[cubit.currentOrderStatusIndex];
                      final newStatus = cubit.orderStatuses[0];
                      (cubit.currentOrderStatusIndex == 0 ||
                              (state is SentNotificationLoadingState &&
                                  cubit.currentButtonSendingIndex == 0))
                          ? null
                          : cubit.sendNotifiaction(
                              newIndex: 0,
                              title: "Order Status Update with Pharma seller",
                              body:
                                  "Your order status changed from $oldStatus to $newStatus.",
                            );
                    },
                    connectorLine: true,
                  ),
                  OrderBarRow(
                    active: cubit.currentOrderStatusIndex >= 1,
                    stateName: "Confirmed",
                    stateIcon: Icons.check_circle,
                    iconColor: Colors.blue,
                    buttonName:
                        (state is SentNotificationLoadingState &&
                            cubit.currentButtonSendingIndex == 1)
                        ? "Loading..."
                        : "Make Confirmed",
                    buttonOnTap: () {
                      final oldStatus =
                          cubit.orderStatuses[cubit.currentOrderStatusIndex];
                      final newStatus = cubit.orderStatuses[1];
                      (cubit.currentOrderStatusIndex == 1 ||
                              (state is SentNotificationLoadingState &&
                                  cubit.currentButtonSendingIndex == 1))
                          ? null
                          : cubit.sendNotifiaction(
                              newIndex: 1,
                              title: "Order Status Update with Pharma seller",
                              body:
                                  "Your order status changed from $oldStatus to $newStatus.",
                            );
                    },
                    connectorLine: true,
                  ),
                  OrderBarRow(
                    active: cubit.currentOrderStatusIndex >= 2,
                    stateName: "Shipped",
                    stateIcon: Icons.local_shipping_rounded,
                    iconColor: Colors.deepPurple,
                    buttonName:
                        (state is SentNotificationLoadingState &&
                            cubit.currentButtonSendingIndex == 2)
                        ? "Loading..."
                        : "Make Shipped",
                    buttonOnTap: () {
                      final oldStatus =
                          cubit.orderStatuses[cubit.currentOrderStatusIndex];
                      final newStatus = cubit.orderStatuses[2];
                      (cubit.currentOrderStatusIndex == 2 ||
                              (state is SentNotificationLoadingState &&
                                  cubit.currentButtonSendingIndex == 2))
                          ? null
                          : cubit.sendNotifiaction(
                              newIndex: 2,
                              title: "Order Status Update with Pharma seller",
                              body:
                                  "Your order status changed from $oldStatus to $newStatus.",
                            );
                    },
                    connectorLine: true,
                  ),
                  OrderBarRow(
                    active: cubit.currentOrderStatusIndex >= 3,
                    stateName: "Delivered",
                    stateIcon: Icons.delivery_dining_rounded,
                    iconColor: Colors.green,
                    buttonName:
                        (state is SentNotificationLoadingState &&
                            cubit.currentButtonSendingIndex == 3)
                        ? "Loading..."
                        : "Make Delivered",
                    buttonOnTap: () {
                      final oldStatus =
                          cubit.orderStatuses[cubit.currentOrderStatusIndex];
                      final newStatus = cubit.orderStatuses[3];
                      (cubit.currentOrderStatusIndex == 3 ||
                              (state is SentNotificationLoadingState &&
                                  cubit.currentButtonSendingIndex == 3))
                          ? null
                          : cubit.sendNotifiaction(
                              newIndex: 3,
                              title: "Order Status Update with Pharma seller",
                              body:
                                  "Your order status changed from $oldStatus to $newStatus.",
                            );
                    },
                    connectorLine: false,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
