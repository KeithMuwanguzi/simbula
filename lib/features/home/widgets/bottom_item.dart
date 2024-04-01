import "package:flutter/material.dart";
import "package:some_ride/core/shared/widgets/export.dart";

class BottomItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const BottomItem({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          TextWidget(
            text: label,
            size: 12,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
