// mpu_test_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/mpu_test_viewmodel.dart';

class MpuTestView extends StatefulWidget {
  const MpuTestView({super.key});

  @override
  State<MpuTestView> createState() => _MpuTestViewState();
}

class _MpuTestViewState extends State<MpuTestView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MpuTestViewModel>(context, listen: false)
          .startMpuTest("userId"); // Replace with real userId
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MpuTestViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Running MPU Test")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: vm.isTesting
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Please follow the on-screen instructions..."),
                  ],
                )
              : vm.result != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "✅ Test Completed!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                            "Raised: ${vm.result!.raised.toStringAsFixed(2)}°"),
                        Text(
                            "Lowered: ${vm.result!.lowered.toStringAsFixed(2)}°"),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<MpuTestViewModel>(context,
                                    listen: false)
                                .loadMpuData();
                            Navigator.pop(context, true);
                          },
                          child: const Text("Return"),
                        ),
                      ],
                    )
                  : const Text("Something went wrong"),
        ),
      ),
    );
  }
}
