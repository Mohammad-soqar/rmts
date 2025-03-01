import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/ui/widgets/characteristic_tile.dart';
import 'package:rmts/ui/widgets/descriptor_tile.dart';
import 'package:rmts/ui/widgets/service_tile.dart';
import 'package:rmts/utils/extra.dart';
import 'package:rmts/utils/snackbar.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({super.key, required this.device});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  int? _rssi;
  int? _mtuSize;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  List<BluetoothService> _services = [];
  bool _isDiscoveringServices = false;
  bool _isConnecting = false;
  bool _isDisconnecting = false;
  String idwwww = "";

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;

  // Real-time data variables
  String realTimeData = 'No data yet';
  late BluetoothCharacteristic _realTimeDataCharacteristic;

  @override
  void initState() {
    super.initState();

    // Listen to connection state changes
    _connectionStateSubscription =
        widget.device.connectionState.listen((state) async {
      _connectionState = state;
      if (state == BluetoothConnectionState.connected) {
        _services = []; // Rediscover services on reconnection
        await _discoverServices();
      }
      if (state == BluetoothConnectionState.connected && _rssi == null) {
        _rssi = await widget.device.readRssi();
      }
      if (mounted) {
        setState(() {});
      }
    });

    // Listen for MTU changes
    _mtuSubscription = widget.device.mtu.listen((value) {
      _mtuSize = value;
      if (mounted) {
        setState(() {});
      }
    });

    // Listen for connecting/disconnecting status
    _isConnectingSubscription = widget.device.isConnecting.listen((value) {
      _isConnecting = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isDisconnectingSubscription =
        widget.device.isDisconnecting.listen((value) {
      _isDisconnecting = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    _mtuSubscription.cancel();
    _isConnectingSubscription.cancel();
    _isDisconnectingSubscription.cancel();
    super.dispose();
  }

  bool get isConnected =>
      _connectionState == BluetoothConnectionState.connected;

  // Update real-time data display
  void _updateRealTimeData(String newData) {
    setState(() {
      realTimeData = newData;
    });
  }

  Future<void> _discoverServices() async {
    try {
      _services = await widget.device.discoverServices();
      _findRealTimeDataCharacteristic();
      Snackbar.show(ABC.c, "Discover Services: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Discover Services Error:", e),
          success: false);
      print(e);
    }
  }

  void _findRealTimeDataCharacteristic() {
    bool found = false;
    for (var service in _services) {
      for (var characteristic in service.characteristics) {
        idwwww = characteristic.uuid.toString();
        // Debug: Log each discovered UUID

        // Use a case-insensitive check for the target characteristic UUID.
        // Updated to match the UUID observed in your debug logs.
        if (characteristic.uuid.toString().toUpperCase() ==
            'BEB5483E-36E1-4688-B7F5-EA07361B26A8') {
          _realTimeDataCharacteristic = characteristic;
          _setRealTimeDataListener();
          found = true;
          break;
        }
      }
      if (found) break;
    }
    if (!found) {
      print("Real-time data characteristic not found.");
    }
  }

  // Listen for notifications on the characteristic
  void _setRealTimeDataListener() {
    _realTimeDataCharacteristic.setNotifyValue(true).then((_) {
      _realTimeDataCharacteristic.value.listen((value) {
        // Log the raw byte data
        print("Received data: $value");
        // Convert bytes to String (expected format: "Counter: 1258")
        String parsedData = String.fromCharCodes(value);
        print("Parsed data: $parsedData");
        _updateRealTimeData(parsedData);
      });
    });
  }

  Widget buildRealTimeData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Real-time Data: $realTimeData',
          style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Future onConnectPressed() async {
    try {
      await widget.device.connectAndUpdateStream();
      Snackbar.show(ABC.c, "Connect: Success", success: true);
    } catch (e) {
      if (e is FlutterBluePlusException &&
          e.code == FbpErrorCode.connectionCanceled.index) {
        // Ignore user-canceled connections
      } else {
        Snackbar.show(ABC.c, prettyException("Connect Error:", e),
            success: false);
        print(e);
      }
    }
  }

  Future onCancelPressed() async {
    try {
      await widget.device.disconnectAndUpdateStream(queue: false);
      Snackbar.show(ABC.c, "Cancel: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Cancel Error:", e), success: false);
      print(e);
    }
  }

  Future onDisconnectPressed() async {
    try {
      await widget.device.disconnectAndUpdateStream();
      Snackbar.show(ABC.c, "Disconnect: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Disconnect Error:", e),
          success: false);
      print(e);
    }
  }

  Future onDiscoverServicesPressed() async {
    if (mounted) {
      setState(() {
        _isDiscoveringServices = true;
      });
    }
    try {
      _services = await widget.device.discoverServices();
      Snackbar.show(ABC.c, "Discover Services: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Discover Services Error:", e),
          success: false);
      print(e);
    }
    if (mounted) {
      setState(() {
        _isDiscoveringServices = false;
      });
    }
  }

  Future onRequestMtuPressed() async {
    try {
      await widget.device.requestMtu(223, predelay: 0);
      Snackbar.show(ABC.c, "Request Mtu: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Change Mtu Error:", e),
          success: false);
      print(e);
    }
  }

  /*
  
str =
"1801"
str128 =
"00001801-0000-1000-8000-00805f9b34fb"
uuid =
"1801"
uuid128 =
"00001801-0000-1000-8000-00805f9b34fb"
  */

  List<Widget> _buildServiceTiles(BuildContext context, BluetoothDevice d) {
    return _services
        .where((s) =>
            s.uuid.toString() != "1801" &&
            s.uuid.toString() != "1800") // Filter out default services
        .map((s) {
      return ServiceTile(
        service: s,
        characteristicTiles:
            s.characteristics.map((c) => _buildCharacteristicTile(c)).toList(),
      );
    }).toList();
  }

  CharacteristicTile _buildCharacteristicTile(BluetoothCharacteristic c) {
    return CharacteristicTile(
      characteristic: c,
      descriptorTiles:
          c.descriptors.map((d) => DescriptorTile(descriptor: d)).toList(),
    );
  }

  Widget buildSpinner(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(14.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.black12,
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget buildRemoteId(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('${widget.device.remoteId}'),
    );
  }

  Widget buildGetServices(BuildContext context) {
    return IndexedStack(
      index: (_isDiscoveringServices) ? 1 : 0,
      children: <Widget>[
        TextButton(
          onPressed: onDiscoverServicesPressed,
          child: const Text("Get Services"),
        ),
        const IconButton(
          icon: SizedBox(
            width: 18.0,
            height: 18.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.grey),
            ),
          ),
          onPressed: null,
        )
      ],
    );
  }

  Widget buildConnectButton(BuildContext context) {
    return Row(
      children: [
        if (_isConnecting || _isDisconnecting) buildSpinner(context),
        TextButton(
          onPressed: _isConnecting
              ? onCancelPressed
              : (isConnected ? onDisconnectPressed : onConnectPressed),
          child: Text(
            _isConnecting ? "CANCEL" : (isConnected ? "DISCONNECT" : "CONNECT"),
            style: Theme.of(context)
                .primaryTextTheme
                .labelLarge
                ?.copyWith(color: Colors.white),
          ),
        )
      ],
    );
  }

  // --- End of vibrator buttons ---

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildRemoteId(context),
          ListTile(
            title: Text(
                'Device is ${_connectionState.toString().split('.')[1]}. ${widget.device.platformName}'),
            trailing: buildGetServices(context),
          ),
          buildRealTimeData(context),
          ..._buildServiceTiles(context, widget.device),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyC,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.device.platformName),
          actions: [buildConnectButton(context)],
        ),
        body: buildBody(context),
      ),
    );
  }
}
