import 'package:flutter/material.dart';

class OrderBarRow extends StatelessWidget {
  const OrderBarRow({
    super.key,
    required this.active,
    required this.stateName,
    required this.stateIcon,
    required this.iconColor,
    required this.buttonName,
    required this.buttonOnTap,
    required this.connectorLine,
  });

  final bool active;
  final String stateName;
  final IconData stateIcon;
  final Color iconColor;
  final String buttonName;
  final VoidCallback buttonOnTap;
  final bool connectorLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: active
                    ? const Color(0xFF75c226)
                    : const Color(0xffdae8c9),
                radius: 10,
              ),
              if (connectorLine) const SizedBox(height: 8),
              if (connectorLine)
                Container(width: 2, height: 30, color: Colors.grey.shade400),
            ],
          ),
          const SizedBox(width: 12),
          Icon(stateIcon, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              stateName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                color: active ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ),
          TextButton(
            onPressed: buttonOnTap,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              buttonName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
