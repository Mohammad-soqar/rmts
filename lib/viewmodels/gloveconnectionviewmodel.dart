import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/data/services/ble_service.dart';
import 'package:rmts/utils/extra.dart';

class GloveConnectionViewModel extends ChangeNotifier {
  BluetoothDevice? gloveDevice;
  BluetoothConnectionState connectionState = BluetoothConnectionState.disconnected;
  final String targetName;

  StreamSubscription<BluetoothConnectionState>? _connSub;
  Timer? _pingTimer;

  GloveConnectionViewModel({required this.targetName});

  Future<void> init() async {
    print("🔍 Scanning for: $targetName");

    FlutterBluePlus.scanResults.listen((results) async {
      for (var result in results) {
        if (result.device.platformName == targetName) {
          await FlutterBluePlus.stopScan();
          try {
            await result.device.connectAndUpdateStream();
            gloveDevice = result.device;
            BleService.setDevice(gloveDevice!);
            await _discoverAndRegisterCharacteristics(gloveDevice!);

            _startListeningToConnection();
            _startConnectionPinger();

            notifyListeners();
            break;
          } catch (e) {
            print("❌ Connection failed: $e");
          }
        }
      }
    });

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
  }

  Future<void> _discoverAndRegisterCharacteristics(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    BluetoothCharacteristic? commandChar;
    BluetoothCharacteristic? notifyChar;

    for (var service in services) {
      for (var char in service.characteristics) {
        final uuid = char.uuid.toString().toLowerCase();
        if (uuid == '6e400002-b5a3-f393-e0a9-e50e24dcca9e') {
          commandChar = char;
        } else if (uuid == 'beb5483e-36e1-4688-b7f5-ea07361b26a8') {
          notifyChar = char;
        }
      }
    }

    if (commandChar != null && notifyChar != null) {
      BleService.setCharacteristics(
        commandCharacteristic: commandChar,
        notifyCharacteristic: notifyChar,
      );
      print("✅ BLE characteristics registered");
    } else {
      print("❌ BLE characteristics not found");
    }
  }

  void _startListeningToConnection() {
    _connSub?.cancel();
    _connSub = gloveDevice!.connectionState.listen((state) {
      connectionState = state;
      print("📶 Connection state changed: $state");
      notifyListeners();
    });
  }

  void _startConnectionPinger() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        if (gloveDevice != null && connectionState == BluetoothConnectionState.connected) {
          await gloveDevice!.readRssi(); // triggers fast disconnect if fails
        }
      } catch (e) {
        print("⚠️ Ping failed. Marking as disconnected.");
        connectionState = BluetoothConnectionState.disconnected;
        notifyListeners();
      }
    });
  }

Future<void> connect() async {
  if (gloveDevice != null) {
    try {
      await gloveDevice!.connect();
      BleService.setDevice(gloveDevice!);

      await _discoverAndRegisterCharacteristics(gloveDevice!);
      _startListeningToConnection();
      _startConnectionPinger();

      notifyListeners();
    } catch (e) {
      print("❌ Manual connect failed: $e");
    }
  }
}




  bool get isConnected => connectionState == BluetoothConnectionState.connected;

  @override
  void dispose() {
    _connSub?.cancel();
    _pingTimer?.cancel();
    super.dispose();
  }
}
