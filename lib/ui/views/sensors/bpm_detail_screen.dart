import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BPMDetailScreen extends StatefulWidget {
  final int initialBPM;

  const BPMDetailScreen({super.key, required this.initialBPM});

  @override
  State<BPMDetailScreen> createState() => _BPMDetailScreenState();
}

class _BPMDetailScreenState extends State<BPMDetailScreen> {
  int bpm = 0;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    bpm = widget.initialBPM;
  }
  
  void startPPG() {
    // TODO: Send "startPPG" to BLE
    setState(() {
      isRunning = true;
    });
  }

  void stopPPG() {
    // TODO: Send "stopPPG" to BLE
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Heart Rate")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Heart Rate", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Text(
            "$bpm",
            style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          ),
          const Text("bpm", style: TextStyle(fontSize: 24, color: Colors.grey)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: isRunning ? null : startPPG,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start"),
              ),
              ElevatedButton.icon(
                onPressed: isRunning ? stopPPG : null,
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
