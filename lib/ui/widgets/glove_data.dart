import 'package:flutter/material.dart';
import 'package:rmts/ui/widgets/glove_data_tile.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';

class GloveDataWidget extends StatelessWidget {
  const GloveDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Glove',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              Text(
                'Last Scanned 15:04 17/04/2025',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap:
              true, // Important: Makes GridView take only the needed height
          physics:
              const NeverScrollableScrollPhysics(), // Important: Disables scrolling
          children: const [
            GloveDataTileWidget(
              sensorName: 'Heart Rate',
              sensorIcon: 'assets/icons/Heart.svg',
              lastResult: '86 BPM',
            ),
            GloveDataTileWidget(
              sensorName: 'Motion',
              sensorIcon: 'assets/icons/hand.svg',
              lastResult: '87° 78°',
            ),
            GloveDataTileWidget(
              sensorName: 'Pressure',
              sensorIcon: 'assets/icons/Pressure.svg',
              lastResult: 'Light Grip',
            ),
            GloveDataTileWidget(
              sensorName: 'Finger Flex',
              sensorIcon: 'assets/icons/Flex.svg',
              lastResult: 'Half-Bent',
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Glove Test",
          onPressed: () {},
        ),
      ],
    );
  }
}
