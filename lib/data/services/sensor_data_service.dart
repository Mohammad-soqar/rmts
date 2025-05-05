import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmts/data/models/hive/mpu_data.dart';
import 'package:rmts/data/models/hive/ppg_data.dart';

class SensorDataService extends ChangeNotifier {
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  Future<void> addPpgData(PpgData ppgdata, String patientId) async {
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .collection('sensors')
        .doc('ppg_data')
        .set({
      'bpm': ppgdata.bpm,
      'timestamp': ppgdata.timestamp.millisecondsSinceEpoch,
    });

    notifyListeners();
  }

  Future<void> addMpuData(MpuData mpudata, String patientId) async {
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .collection('sensors')
        .doc('mpu_data')
        .set({
      'lowered': mpudata.lowered,
      'raised': mpudata.raised,
      'timestamp': mpudata.timestamp.millisecondsSinceEpoch,
    });

    notifyListeners();
  }
}
