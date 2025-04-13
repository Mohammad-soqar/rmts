import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/mpu_data.dart';
import 'package:rmts/data/services/ble_service.dart';

class MpuTestViewModel extends ChangeNotifier {
  bool isTesting = false;
  MpuData? result;

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
    notifyListeners();

    await BleService.sendCommand("startMPUTest");

    BleService.onDataReceived((data) async {
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
        if (box.isNotEmpty) await box.clear(); // await the clear
        await box.add(mpu); // await the add

        result = mpu;
        isTesting = false;
        notifyListeners(); // notify for result view
      }
    });
  }
}
