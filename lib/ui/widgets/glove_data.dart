import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/sensors/mpu_test_view.dart';
import 'package:rmts/ui/views/sensors/ppg_test_view.dart';
import 'package:rmts/ui/widgets/glove_data_tile.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';
import 'package:rmts/viewmodels/flex_test_viewmodel.dart';
import 'package:rmts/viewmodels/fsr_viewmodel.dart';
import 'package:rmts/ui/views/sensors/fsr_test_view.dart';
import 'package:rmts/viewmodels/mpu_test_viewmodel.dart';
import 'package:rmts/viewmodels/ppg_test_viewmodel.dart';
import 'package:rmts/ui/views/sensors/flex_test_view.dart';
import 'package:rmts/viewmodels/glovestatus_viewmodel.dart';

class GloveDataWidget extends StatefulWidget {
  const GloveDataWidget({
    super.key,
  });

  @override
  State<GloveDataWidget> createState() => _GloveDataWidgetState();
}

class _GloveDataWidgetState extends State<GloveDataWidget> {
  @override
  void initState() {
    super.initState();
    // Load data on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PpgTestViewModel>(context, listen: false).loadPpgData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PpgTestViewModel>(context);
    final gloveStatus = Provider.of<GloveStatusViewModel>(context);

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
              if (gloveStatus.formattedSyncTime != null)
                Text(
                  'Last Scanned: ${gloveStatus.formattedSyncTime}',
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
          children: [
            GloveDataTileWidget(
              sensorName: 'Heart Rate',
              sensorIcon: 'assets/icons/Heart.svg',
              lastResult: vm.ppgDataList.isEmpty
                  ? 'No data found'
                  : '${vm.ppgDataList.last.bpm} BPM',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PpgTestView()),
                );
                if (result == true) {
                  // This triggers rebuild of the screen and reloads data
                  Provider.of<PpgTestViewModel>(context, listen: false)
                      .loadPpgData();
                  setState(() {}); // 🔁 triggers UI rebuild
                }
              },
            ),
            GloveDataTileWidget(
              sensorName: 'Motion',
              sensorIcon: 'assets/icons/hand.svg',
              lastResult: Provider.of<MpuTestViewModel>(context)
                      .mpuDataList
                      .isEmpty
                  ? 'No data found'
                  : '${Provider.of<MpuTestViewModel>(context).mpuDataList.last.raised} '
                      "°"
                      ' ${Provider.of<MpuTestViewModel>(context).mpuDataList.last.lowered} '
                      "°"
                      '',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MpuTestView()),
                );
                if (result == true) {
                  // This triggers rebuild of the screen and reloads data
                  Provider.of<MpuTestViewModel>(context, listen: false)
                      .loadMpuData();
                  setState(() {}); // 🔁 triggers UI rebuild
                }
              },
            ),
            GloveDataTileWidget(
              sensorName: 'Pressure',
              sensorIcon: 'assets/icons/Pressure.svg',
              lastResult: Provider.of<FSRViewModel>(context).fsrDataList.isEmpty
                  ? 'No data found'
                  : '${Provider.of<FSRViewModel>(context).fsrDataList.last.pressure} '
                      "°"
                      '',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FSRTestView()),
                );
                if (result == true) {
                  // This triggers rebuild of the screen and reloads data
                  Provider.of<FSRViewModel>(context, listen: false)
                      .loadFsrdata();
                  setState(() {}); // 🔁 triggers UI rebuild
                }
              },
            ),
            GloveDataTileWidget(
              sensorName: 'Finger Flex',
              sensorIcon: 'assets/icons/Flex.svg',
              lastResult: Provider.of<FlexTestViewModel>(context)
                      .flexDataList
                      .isEmpty
                  ? 'No data found'
                  : '${Provider.of<FlexTestViewModel>(context).flexDataList.last.bent} '
                      "°"
                      '',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FlexTestView()),
                );
                if (result == true) {
                  // This triggers rebuild of the screen and reloads data
                  Provider.of<FlexTestViewModel>(context, listen: false)
                      .loadFlexdata();
                  setState(() {}); // 🔁 triggers UI rebuild
                }
              },
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
