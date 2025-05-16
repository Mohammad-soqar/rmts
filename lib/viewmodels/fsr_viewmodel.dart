import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/fsr_data.dart';
import 'package:rmts/data/services/ble_service.dart';
import 'dart:async';

class FSRViewModel extends ChangeNotifier {
  bool isTesting = false;
  FSRData? result;

  List<FSRData> _fsrDataList = [];
  List<FSRData> get fsrDataList => _fsrDataList;

  Future<void> loadFsrdata() async {
    final box = Hive.box<FSRData>('fsr_data');
    _fsrDataList = box.values.toList().cast<FSRData>();
    notifyListeners();
  }

  Future<void> startFsrTest(String userId) async {
    isTesting = true;
    result = null;
    String error;
    notifyListeners();

    final completer = Completer<void>();

    BleService.onDataReceived((data) async {
      if (data.startsWith("FSRResult:")) {
        final parts = data.replaceFirst("FSRResult:", "").split(",");
        final pressure = double.parse(parts[0]);

        final fsr = FSRData(
          pressure: pressure,
          timestamp: DateTime.now(),
        );
        print("FSR Result: $pressure");

        final box = Hive.box<FSRData>('fsr_data');
        if (box.isNotEmpty) await box.clear();
        await box.add(fsr);

        result = fsr;
        isTesting = false;
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

    await BleService.sendCommand("startFSRTest");
    return completer.future;
  }
}
