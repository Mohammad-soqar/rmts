import 'package:flutter/material.dart';

class WeeklyAvailability extends StatelessWidget {
  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  WeeklyAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    final circleColor = Theme.of(context).colorScheme.primary.withOpacity(0.8);
    final unavailableColor =
        Theme.of(context).colorScheme.primary.withOpacity(0.5);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(days.length, (index) {
        final isWeekend =
            index == 0 || index == 6; // Sunday (0) and Saturday (6)
        final currentColor = isWeekend ? unavailableColor : circleColor;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                days[index],
                style: TextStyle(
                  fontSize: 8,
                  color: currentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
