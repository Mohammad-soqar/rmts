import 'package:flutter/material.dart';


class VitalsCard extends StatelessWidget {
  final String label;
  final int value;
  final String unit;
   final Color? backgroundColor;
    final Color? iconColor;
  final IconData icon;
  final VoidCallback onTap;

  const VitalsCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    this.backgroundColor,
    this.iconColor,
    required this.icon,
    required this.onTap,
  });

    @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: iconColor ?? Colors.black54, // 👈 Use custom icon color
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unit,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}