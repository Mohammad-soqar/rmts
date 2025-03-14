import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rmts/ui/widgets/characteristic_tile.dart';
import 'package:rmts/ui/widgets/descriptor_tile.dart';
import 'package:rmts/ui/widgets/service_tile.dart';
import 'package:rmts/utils/extra.dart';
import 'package:rmts/utils/snackbar.dart';

class DeviceScreen extends StatelessWidget {
 
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
