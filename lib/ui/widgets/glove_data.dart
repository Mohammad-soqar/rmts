import 'package:flutter/material.dart';
import 'package:rmts/ui/widgets/glove_data_tile.dart';

class GloveDataWidget extends StatelessWidget {
  GloveDataWidget({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Glove',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
               Text(
                  'Last Scanned 15:04 17/04/2025',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
             
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
            child: SizedBox(
            height: 350, // adjust height to fit the grid
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
              GloveDataTileWidget(
                sensorName: 'Heart Rate',
                sensorIcon: 'assets/Heart.svg',
                lastResult: '86 BPM',
              ),
              GloveDataTileWidget(
                sensorName: 'Motion',
                sensorIcon: 'assets/hand.svg',
                lastResult: '87° 78°',
              ),
              GloveDataTileWidget(
                sensorName: 'Pressure',
                sensorIcon: 'assets/Pressure.svg',
                lastResult: '1013 hPa',
              ),
              GloveDataTileWidget(
                sensorName: 'Finger Flex',
                sensorIcon: 'assets/Flex.svg',
                lastResult: 'Half-Bent',
              ),
              ],
            ),
            ),
          ),
        

        const SizedBox(height: 16),
      ],
    );
  }
}
