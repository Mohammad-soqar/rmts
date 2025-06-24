import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/fsr_data.dart';
import 'package:rmts/data/repositories/sensor_data_repository.dart';
import 'package:rmts/data/services/ble_service.dart';
import 'dart:async';
import 'package:rmts/viewmodels/glovestatus_viewmodel.dart';

class FSRViewModel extends ChangeNotifier {
  bool isTesting = false;
  FSRData? result;
  double? pressureValue;

  final GloveStatusViewModel gloveStatusViewModel;

  List<FSRData> _fsrDataList = [];
  List<FSRData> get fsrDataList => _fsrDataList;
  final SensorDataRepository _sensorDataRepository = SensorDataRepository();

  FSRViewModel(this.gloveStatusViewModel);

  Future<void> loadFsrdata() async {
    final box = Hive.box<FSRData>('fsr_data');
    _fsrDataList = box.values.toList().cast<FSRData>();
    notifyListeners();
  }

  Future<void> startFsrTest(String userId) async {
    isTesting = true;
    result = null;
    notifyListeners();

    final completer = Completer<void>();

    BleService.onDataReceived((data) async {
      if (data.startsWith("FsrLive:")) {
        final val = double.tryParse(data.replaceFirst("FsrLive:", ""));
        if (val != null) {
          pressureValue = val;
          notifyListeners();
        }
        return;
      }
      if (data.startsWith("FSRResult:")) {
        final parts = data.replaceFirst("FSRResult:", "").split(",");
        final pressure = double.parse(parts[0]);

        final fsr = FSRData(
          pressure: pressure,
          timestamp: DateTime.now(),
        );

        final box = Hive.box<FSRData>('fsr_data');
        if (box.isNotEmpty) await box.clear();
        await box.add(fsr);

        result = fsr;
        isTesting = false;
        gloveStatusViewModel.updateSyncTime();  
        _sensorDataRepository.saveFsrData(fsr, userId);

        notifyListeners();

        if (!completer.isCompleted) {
          completer.complete();
        }
      } else if (data.contains("Error: No Glove Detected")) {
        isTesting = false;
        notifyListeners();

        if (!completer.isCompleted) {
          completer.completeError(Exception("No glove detected"));
        }
      }
    });

    await BleService.sendCommand("startFSRTest");
    return completer.future;
  }

  Future<void> sendCaptureCommand() async {
    await BleService.sendCommand("captureFSR");
  }
}
