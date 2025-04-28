import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  static BluetoothCharacteristic? _commandChar;
  static BluetoothCharacteristic? _notifyChar;
  static StreamSubscription<List<int>>? _notifySubscription;
  static String? lastData; // ✅ static here

  static void setCharacteristics({
    required BluetoothCharacteristic commandCharacteristic,
    required BluetoothCharacteristic notifyCharacteristic,
  }) {
    _commandChar = commandCharacteristic;
    _notifyChar = notifyCharacteristic;

    if (!_notifyChar!.isNotifying) {
      _notifyChar!.setNotifyValue(true);
    }
  }

  static Future<void> sendCommand(String command) async {
    try {
      if (_commandChar == null) {
        throw Exception("Command characteristic is not set.");
      }

      await _commandChar!.write(
        command.codeUnits,
        withoutResponse: _commandChar!.properties.writeWithoutResponse,
      );
    } catch (e) {
      print('Error sending command: $e');
    }
  }

  static void onDataReceived(Function(String) callback) {
    _notifySubscription?.cancel(); // Cancel old listener if exists
    _notifySubscription = _notifyChar?.lastValueStream.listen((value) {
      final data = String.fromCharCodes(value);

      if (lastData == data) {
        print('⚠️ Duplicate BLE data detected, ignoring.');
        return;
      }
      lastData = data;

      callback(data);
    });
  }
}
