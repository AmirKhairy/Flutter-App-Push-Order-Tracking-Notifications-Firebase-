import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_cubit.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/cubit/order_state.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/features/notifications/view/widgets/order_bar_row_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStatusSection extends StatelessWidget {
  const OrderStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is SentNotificationErrorState) {
          print("Error: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
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
                        imageUrl:
                            'https://assets.sharikatmubasher.com/news/21421372.png',
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
                        imageUrl:
                            'https://assets.sharikatmubasher.com/news/21421372.png',
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
                        imageUrl:
                            'https://assets.sharikatmubasher.com/news/21421372.png',
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
                        imageUrl:
                            'https://assets.sharikatmubasher.com/news/21421372.png',
                      );
              },
              connectorLine: false,
            ),
          ],
        );
      },
    );
  }
}
