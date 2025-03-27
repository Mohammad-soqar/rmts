import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


class BleRealTimeViewmodel extends ChangeNotifier{
  final BluetoothDevice device;
  List<BluetoothService> _services = [];
  BluetoothCharacteristic? _realTimeDataCharacteristic;
  String _realTimeData = "Waiting for data...";

  BleRealTimeViewmodel({required this.device});
  
  String get realTimeData => _realTimeData;
  

  void _updateRealTimeData(String newData) async{
    _realTimeData = newData;
    notifyListeners();  
  }


  }