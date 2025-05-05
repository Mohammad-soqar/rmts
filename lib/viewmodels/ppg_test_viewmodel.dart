import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/ppg_data.dart';
import 'package:rmts/data/repositories/sensor_data_repository.dart';
import 'package:rmts/data/services/ble_service.dart';

class PpgTestViewModel extends ChangeNotifier {
  bool isTesting = false;
  PpgData? result;
  List<PpgData> _ppgDataList = [];
  List<PpgData> get ppgDataList => _ppgDataList;
  final SensorDataRepository _sensorDataRepository = SensorDataRepository();

  Future<void> loadPpgData() async {
    final box = Hive.box<PpgData>('ppg_data');
    _ppgDataList = box.values.toList().cast<PpgData>();
    notifyListeners();
  }

  Future<void> startPpgTest(String userId) async {
    isTesting = true;
    result = null;
    // ignore: unused_local_variable
    String error;
    notifyListeners();

    final completer = Completer<void>();

    BleService.onDataReceived((data) async {
      if (data.startsWith("PPGResult:")) {
        final parts = data.replaceFirst("PPGResult:", "").split(",");
        final bpm = double.parse(parts[0]);

        final ppg = PpgData(
          bpm: bpm,
          timestamp: DateTime.now(),
        );

        final box = Hive.box<PpgData>('ppg_data');
        if (box.isNotEmpty) await box.clear();
        await box.add(ppg);

        result = ppg;
        isTesting = false;
        _sensorDataRepository.savePpgData(ppg, userId);
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

    await BleService.sendCommand("startPPGTest");
    return completer.future;
  }
}
