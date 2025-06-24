import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/mpu_data.dart';
import 'package:rmts/data/repositories/sensor_data_repository.dart';
import 'package:rmts/data/services/ble_service.dart';

enum MpuTestStage {
  idle,
  waitingRaise,
  waitingLower,
  done,
}

class MpuTestViewModel extends ChangeNotifier {
  bool isTesting = false;
  MpuData? result;
  MpuTestStage stage = MpuTestStage.idle;
  final SensorDataRepository _sensorDataRepository = SensorDataRepository();

  List<MpuData> _mpuDataList = [];
  List<MpuData> get mpuDataList => _mpuDataList;

  Future<void> loadMpuData() async {
    final box = Hive.box<MpuData>('mpu_data');
    _mpuDataList = box.values.toList().cast<MpuData>();
    notifyListeners();
  }

  Future<void> startMpuTest(String userId) async {
    isTesting = true;
    result = null;
    stage = MpuTestStage.waitingRaise;
    String error;
    notifyListeners();
    await BleService.sendCommand("startMPUTest");

    BleService.onDataReceived((data) async {
      if (!isTesting) return;
      if (data == "RAISED_CAPTURED") {
        stage = MpuTestStage.waitingLower;
        notifyListeners();
        return;
      }
      if (data.startsWith("MPUResult:")) {
        final parts = data.replaceFirst("MPUResult:", "").split(",");
        final raised = double.parse(parts[0]);
        final lowered = double.parse(parts[1]);

        final mpu = MpuData(
          raised: raised,
          lowered: lowered,
          timestamp: DateTime.now(),
        );
        final box = Hive.box<MpuData>('mpu_data');
        if (box.isNotEmpty) await box.clear();
        await box.add(mpu);

        result = mpu;
        isTesting = false;
        _sensorDataRepository.saveMpuData(mpu, userId);

        stage = MpuTestStage.done;
        notifyListeners();
        await BleService.sendCommand("stopMPU");
      }
    }); // notify for result view
  }
}
