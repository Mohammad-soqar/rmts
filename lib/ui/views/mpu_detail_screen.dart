import 'package:flutter/material.dart';

class MPUDetailScreen extends StatefulWidget {
  final int initialAngle;

  const MPUDetailScreen({super.key, required this.initialAngle});

  @override
  State<MPUDetailScreen> createState() => _MPUDetailScreenState();
}

class _MPUDetailScreenState extends State<MPUDetailScreen> {
  int angle = 0;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    angle = widget.initialAngle;
  }

  void startMPU() {
    // TODO: Send "startMPU" to BLE
    setState(() => isRunning = true);
  }

  void stopMPU() {
    // TODO: Send "stopMPU" to BLE
    setState(() => isRunning = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Wrist Mobility")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Degress of Motion", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Text(
            "$angle",
            style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          ),
          const Text("degrees", style: TextStyle(fontSize: 24, color: Colors.grey)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: isRunning ? null : startMPU,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start"),
              ),
              ElevatedButton.icon(
                onPressed: isRunning ? stopMPU : null,
                icon: const Icon(Icons.stop),
                label: const Text("Stop"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
