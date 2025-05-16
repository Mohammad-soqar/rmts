import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rmts/data/services/ble_service.dart';

class VibrationMotorViewmodel extends ChangeNotifier {
  bool isTesting = false;

  Future<void> startVibMotor() async {
    isTesting = true;

    notifyListeners();

    final completer = Completer<void>();

    await BleService.sendCommand("startVIB");

    return completer.future;
  }
}
