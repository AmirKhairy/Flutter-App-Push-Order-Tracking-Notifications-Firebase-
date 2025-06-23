import 'package:flutter/material.dart';

class OrderScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const OrderScreenAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,

      title: Row(
        children: const [
          Icon(Icons.local_shipping_rounded, color: Color(0xFF1565C0)),
          SizedBox(width: 8),
          Text(
            "Order Tracking",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
