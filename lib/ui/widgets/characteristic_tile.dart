import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import "descriptor_tile.dart";

class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;

  const CharacteristicTile({
    super.key,
    required this.characteristic,
    required this.descriptorTiles,
  });

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  double _value = 0.0;
  late StreamSubscription<List<int>> _lastValueSubscription;

  @override
  void initState() {
    super.initState();
    _lastValueSubscription =
        widget.characteristic.lastValueStream.listen((value) {
      String receivedData = String.fromCharCodes(value);
      double parsedValue = double.tryParse(receivedData) ?? 0.0;
      print("Received raw value: $receivedData, Parsed value: $parsedValue");
      if (mounted) {
        setState(() {
          _value = parsedValue;
        });
      }
    });
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    super.dispose();
  }

  BluetoothCharacteristic get c => widget.characteristic;

  Future<void> sendCommand(String command) async {
    try {
      await c.write(command.codeUnits,
          withoutResponse: c.properties.writeWithoutResponse);
    } catch (e) {
      print(e);
    }
  }

  Widget buildUuid(BuildContext context) {
    String uuid = '0x${widget.characteristic.uuid.toString().toUpperCase()}';
    print(widget.characteristic.uuid);
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    String data = _value.toString();
    return Text(data, style: const TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildCommandButton(
      BuildContext context, String label, String command, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        backgroundColor: Colors.blueAccent, // Change the color as needed
        foregroundColor: Colors.white, // Text and icon color
        elevation: 4, // Shadow effect
      ),
      icon: Icon(color: Colors.white, icon, size: 20),
      label: Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      onPressed: () async {
        await sendCommand(command);
      },
    );
  }

  Widget buildButtonGrid(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {
        "label": "Start Vibrator",
        "command": "startVibrator",
        "icon": Icons.vibration
      },
      {
        "label": "Stop Vibrator",
        "command": "stopVibrator",
        "icon": Icons.vibration
      },
      {"label": "Start MPU", "command": "startMPU", "icon": Icons.sensors},
      {"label": "Stop MPU", "command": "stopMPU", "icon": Icons.sensors_off},
      {"label": "Start MLX", "command": "startMLX", "icon": Icons.thermostat},
      {
        "label": "Stop MLX",
        "command": "stopMLX",
        "icon": Icons.thermostat_auto
      },
      {
        "label": "Start PPG",
        "command": "startPPG",
        "icon": Icons.monitor_heart
      },
      {"label": "Stop PPG", "command": "stopPPG", "icon": Icons.heart_broken},
      {"label": "Start FSR", "command": "startFSR", "icon": Icons.touch_app},
      {"label": "Stop FSR", "command": "stopFSR", "icon": Icons.block},
      {"label": "Start Flex", "command": "startFlex", "icon": Icons.swap_vert},
      {
        "label": "Stop Flex",
        "command": "stopFlex",
        "icon": Icons.swap_horizontal_circle
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // Prevents scroll conflicts
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two buttons per row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3, // Adjust button size
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final button = buttons[index];
          if (widget.characteristic.uuid.toString() ==
              '6e400002-b5a3-f393-e0a9-e50e24dcca9e')
            return buildCommandButton(
                context, button["label"], button["command"], button["icon"]);
          else
            return Container();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Characteristic',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildUuid(context),
            const SizedBox(height: 8),
            buildValue(context),
            const SizedBox(height: 16),
            buildButtonGrid(context),
            const SizedBox(height: 16),
            ...widget.descriptorTiles,
          ],
        ),
      ),
    );
  }
}
