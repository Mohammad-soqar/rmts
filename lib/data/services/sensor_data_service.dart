import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rmts/data/models/hive/mpu_data.dart';
import 'package:firebase_database/firebase_database.dart';


class SensorDataService extends ChangeNotifier {
  final _mpuBox = Hive.box<MpuData>('mpu_data');
  final _firebaseRef = FirebaseDatabase.instance.ref();

  List<MpuData> get allMpuReadings => _mpuBox.values.toList();

  Future<void> addMpuData(MpuData mpudata, String patientId) async {
    await _mpuBox.add(mpudata);

    await _firebaseRef
        .child('users/$patientId/mpu_data')
        .push()
        .set(mpudata.toFirebaseJson());

    notifyListeners();
  }
}
