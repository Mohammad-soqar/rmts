import 'package:flutter/material.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';

class AppointmentTile extends StatelessWidget {
  final String doctorName;
  final String date;
  final String time;
  final String btn1Text;
  final String btn2Text;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  const AppointmentTile({
    required this.doctorName,
    required this.date,
    required this.time,
    this.btn1Text = '',
    this.btn2Text = '',
    this.onTap1,
    this.onTap2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor name
          Text(
            doctorName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          // Date & time row
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(date,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(width: 12),
              Icon(Icons.access_time,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(time,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 16),

          // Buttons row
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  color: Theme.of(context).colorScheme.outline,
                  label: btn1Text,
                  onPressed: onTap1 ?? () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  color: Theme.of(context).colorScheme.primary,
                  label: btn2Text,
                  onPressed: onTap2 ?? () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
