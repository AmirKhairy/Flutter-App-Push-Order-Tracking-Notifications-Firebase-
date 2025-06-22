import 'package:flutter/material.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/view/widgets/order_bar_row_widget.dart';
import 'package:flutter_app_push_order_tracking_notifications_firebase/view/widgets/order_screen_app_bar_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderScreenAppBarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                active: true,
                stateName: "Pending",
                stateIcon: Icons.pending,
                iconColor: Colors.orange,
                buttonName: "Make Pending",
                buttonOnTap: () {},
                connectorLine: true,
              ),
              OrderBarRow(
                active: false,
                stateName: "Confirmed",
                stateIcon: Icons.check_circle,
                iconColor: Colors.blue,
                buttonName: "Make Confirmed",
                buttonOnTap: () {},
                connectorLine: true,
              ),
              OrderBarRow(
                active: false,
                stateName: "Shipped",
                stateIcon: Icons.local_shipping_rounded,
                iconColor: Colors.deepPurple,
                buttonName: "Make Shipped",
                buttonOnTap: () {},
                connectorLine: true,
              ),
              OrderBarRow(
                active: false,
                stateName: "Delivered",
                stateIcon: Icons.delivery_dining_rounded,
                iconColor: Colors.green,
                buttonName: "Make Delivered",
                buttonOnTap: () {},
                connectorLine: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
