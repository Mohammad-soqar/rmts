import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/utils/snackbar.dart';
import "descriptor_tile.dart";

class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;

  const CharacteristicTile({
    Key? key,
    required this.characteristic,
    required this.descriptorTiles,
  }) : super(key: key);

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
      double parsedValue = double.tryParse(receivedData) ?? 2.0;
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
      await c.write(command.codeUnits, withoutResponse: c.properties.writeWithoutResponse);
    } catch (e) {
      print(e);
    }
  }

  Widget buildStartVibratorButton() {
    return TextButton(
      child: const Text("Start Vibrator"),
      onPressed: () async {
        await sendCommand("start");
      },
    );
  }

  Widget buildStopVibratorButton() {
    return TextButton(
      child: const Text("Stop Vibrator"),
      onPressed: () async {
        await sendCommand("stop");
      },
    );
  }

  Widget buildUuid(BuildContext context) {
    String uuid = '0x${widget.characteristic.uuid.toString().toUpperCase()}';
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    String data = _value.toString();
    return Text(data, style: const TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildButtonRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildStartVibratorButton(),
        buildStopVibratorButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Characteristic'),
            buildUuid(context),
            buildValue(context),
          ],
        ),
        subtitle: buildButtonRow(context),
        contentPadding: const EdgeInsets.all(0.0),
      ),
      children: widget.descriptorTiles,
    );
  }
}
