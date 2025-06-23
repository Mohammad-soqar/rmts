// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';

class AppointmentTile extends StatelessWidget {
  final String doctorName;
  final String date;
  final String time;
  final String btn_1_text;
  final String btn_2_text;
  final Function()? onTap_1;
  final Function()? onTap_2;


  const AppointmentTile({
    required this.doctorName,
    required this.date,
    required this.time,
    this.btn_1_text = '',
    this.btn_2_text = '',
    this.onTap_1,
    this.onTap_2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          Text(
            doctorName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          ),
          Row(
            children: [
              Text(
          date,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              ),
              const SizedBox(width: 8),
              Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             CustomButton(
                color: Theme.of(context).colorScheme.primary,
                label: btn_1_text,
                onPressed: onTap_1 ?? () {},
              ),
              CustomButton(
                color: Theme.of(context).colorScheme.secondary,
                label: btn_2_text,
                onPressed: onTap_2 ?? () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
