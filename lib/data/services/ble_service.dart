import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  static BluetoothDevice? _device;
  static BluetoothCharacteristic? _commandChar;
  static BluetoothCharacteristic? _notifyChar;
  static StreamSubscription<List<int>>? _notifySubscription;
  static String? lastData;

  static void setDevice(BluetoothDevice device) {
    _device = device;
  }

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
      print('❌ Error sending command: $e');
    }
  }

  static void onDataReceived(Function(String) callback) {
    _notifySubscription?.cancel();
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

  static bool get isConnected =>
      _device != null &&
      _commandChar != null &&
      _notifyChar != null &&
      _device!.isConnected;

  static Future<void> disconnect() async {
    if (_device != null) {
      try {
        await _device!.disconnect();
        print("🔌 BLE device disconnected.");
      } catch (e) {
        print("❌ Error during disconnect: $e");
      }
    }

    _device = null;
    _commandChar = null;
    _notifyChar = null;
    _notifySubscription?.cancel();
    _notifySubscription = null;
    lastData = null;
  }
}
