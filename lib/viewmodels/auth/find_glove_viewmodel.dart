import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/utils/snackbar.dart';

class FindGloveViewmodel extends ChangeNotifier {
  // Add your properties and methods here
  String? errorMessage;
  bool _isLoading = false;
  List<ScanResult> _scanResults = [];

  bool get isLoading => _isLoading;

  Future<String> findGlove() async {
    _isLoading = true;
    notifyListeners();
    String res = "Some error occurred";
    try {
         await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
      
      res = "success";
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
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

  void onConnectPressed(BluetoothDevice device) {
    device.connectAndUpdateStream().catchError((e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e),
          success: false);
    });
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => DeviceScreen(device: device),
        settings: RouteSettings(name: '/DeviceScreen'));
    Navigator.of(context).push(route);
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(Duration(milliseconds: 500));
  }
}
