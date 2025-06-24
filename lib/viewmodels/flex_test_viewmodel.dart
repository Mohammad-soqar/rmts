import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/flex_data.dart';
import 'package:rmts/data/repositories/sensor_data_repository.dart';
import 'package:rmts/data/services/ble_service.dart';

class FlexTestViewModel extends ChangeNotifier {
  bool isTesting = false;
  FlexData? result;
  double? bentValue;

  List<FlexData> _flexDataList = [];
  List<FlexData> get flexDataList => _flexDataList;
  final SensorDataRepository _sensorDataRepository = SensorDataRepository();

  Future<void> loadFlexdata() async {
    final box = Hive.box<FlexData>('flex_data');
    _flexDataList = box.values.toList().cast<FlexData>();
    notifyListeners();
  }

  Future<void> startFlexTest(String userId) async {
    isTesting = true;
    result = null;
    String error;
    notifyListeners();

    final completer = Completer<void>();

    BleService.onDataReceived((data) async {
      if (data.startsWith("FlexLive:")) {
        final val = double.tryParse(data.replaceFirst("FlexLive:", ""));
        if (val != null) {
          bentValue = val;
          notifyListeners();
        }
        return;
      }
      if (data.startsWith("FlexResult:")) {
        final parts = data.replaceFirst("FlexResult:", "").split(",");
        final bent = double.parse(parts[0]);

        final flex = FlexData(
          bent: bent,
          timestamp: DateTime.now(),
        );

        final box = Hive.box<FlexData>('flex_data');
        if (box.isNotEmpty) await box.clear();
        await box.add(flex);

        result = flex;
        isTesting = false;
        _sensorDataRepository.saveFlexData(flex, userId);

        notifyListeners();

        if (!completer.isCompleted) {
          completer.complete();
        }
      } else if (data.contains("Error: No Glove Detected")) {
        // ⛔ Handle glove not worn error
        isTesting = false;
        error =
            "Please wear the glove properly and try again."; // ⬅️ Optional if you have UI for error
        notifyListeners();

        if (!completer.isCompleted) {
          completer.completeError(Exception("No glove detected"));
        }
      }
    });

    await BleService.sendCommand("startFlexTest");
    return completer.future;
  }

  Future<void> sendCaptureCommand() async {
    await BleService.sendCommand("captureFlex");
  }
}
