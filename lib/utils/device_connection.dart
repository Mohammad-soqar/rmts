import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/utils/extra.dart';

class DeviceConnection {

  Future<String> onConnectPressed(BluetoothDevice device) async{
    try{
      await device.connectAndUpdateStream();
     return "success";

    }catch (e){
      return e.toString();
    }
  }

  
  Future<String> onDisconnectPressed(BluetoothDevice device) async{
    try{
      await device.disconnectAndUpdateStream();
     return "success";

    }catch (e){
      return e.toString();
    }
  }
}