import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmts/data/models/hive/flex_data.dart';
import 'package:rmts/data/models/hive/fsr_data.dart';
import 'package:rmts/data/models/hive/mpu_data.dart';
import 'package:rmts/data/models/hive/ppg_data.dart';

class SensorDataService extends ChangeNotifier {
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  Future<void> addPpgData(PpgData ppgdata, String patientId) async {
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .collection('ppg_data')
        .doc('ppg_data_${ppgdata.timestamp.millisecondsSinceEpoch}')
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
        .collection('mpu_data')
        .doc('mpu_data_${mpudata.timestamp.millisecondsSinceEpoch}')
        .set({
      'lowered': mpudata.lowered,
      'raised': mpudata.raised,
      'timestamp': mpudata.timestamp.millisecondsSinceEpoch,
    });

    notifyListeners();
  }

  Future<void> addFlexData(FlexData flexData, String patientId) async {
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .collection('flex_data')
        .doc('flex_data_${flexData.timestamp.millisecondsSinceEpoch}')
        .set({
      'bent': flexData.bent,
      'timestamp': flexData.timestamp.millisecondsSinceEpoch,
    });

    notifyListeners();
  }

  Future<void> addFsrData(FSRData fsrData, String patientId) async {
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientId)
        .collection('fsr_data')
        .doc('fsr_data_${fsrData.timestamp.millisecondsSinceEpoch}')
        .set({
      'pressure': fsrData.pressure,
      'timestamp': fsrData.timestamp.millisecondsSinceEpoch,
    });

    notifyListeners();
  }
}
