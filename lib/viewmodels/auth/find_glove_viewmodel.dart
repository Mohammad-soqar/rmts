import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/data/models/patient.dart';
import 'package:rmts/data/services/ble_service.dart';
import 'package:rmts/utils/extra.dart';
import 'package:rmts/utils/snackbar.dart';

class FindGloveViewmodel extends ChangeNotifier {
  // Add your properties and methods here
  String? errorMessage;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Patient?> getCurrentPatient() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return null;
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUser.uid)
          .get();
      if (!doc.exists) return null;
      Patient currentPatient = Patient.fromSnap(doc);
      return currentPatient;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
  }

Future<String> findGlove() async {
  _isLoading = true;
  notifyListeners();

  try {
    Patient? currentPatient = await getCurrentPatient();
    if (currentPatient == null) return "No patient found";

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen(
      (results) async {
        for (var result in results) {
          print("Found device: ${result.device.platformName}");

          if (result.device.platformName == currentPatient.gloveName) {
            try {
              await FlutterBluePlus.stopScan();
              await result.device.connectAndUpdateStream();
              await _scanResultsSubscription.cancel();

              // Discover characteristics
              List<BluetoothService> services =
                  await result.device.discoverServices();

              BluetoothCharacteristic? commandChar;
              BluetoothCharacteristic? notifyChar;

              for (var service in services) {
                for (var char in service.characteristics) {
                  String uuid = char.uuid.toString().toLowerCase();
                  if (uuid ==
                      '6e400002-b5a3-f393-e0a9-e50e24dcca9e') {
                    commandChar = char;
                  } else if (uuid ==
                      'beb5483e-36e1-4688-b7f5-ea07361b26a8') {
                    notifyChar = char;
                  }
                }
              }

              if (commandChar != null && notifyChar != null) {
                await notifyChar.setNotifyValue(true);
                BleService.setCharacteristics(
                  commandCharacteristic: commandChar,
                  notifyCharacteristic: notifyChar,
                );
                print("✅ BLE characteristics registered");
              } else {
                print("❌ BLE characteristics not found");
              }

              _isLoading = false;
              notifyListeners();
              return;
            } catch (e) {
              Snackbar.show(
                ABC.b,
                prettyException("Connect Error:", e),
                success: false,
              );
            }
          }
        }
      },
      onError: (e) {
        Snackbar.show(
          ABC.b,
          prettyException("Scan Error:", e),
          success: false,
        );
      },
    );

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    await Future.delayed(const Duration(seconds: 17));
    await FlutterBluePlus.stopScan();
    await _scanResultsSubscription.cancel();

    return "Glove not found";
  } catch (e) {
    errorMessage = e.toString();
    return "Error: $errorMessage";
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
          success: false);
      print(e);
    }
  }

 
}
