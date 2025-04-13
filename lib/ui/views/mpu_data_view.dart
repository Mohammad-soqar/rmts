import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/mpu_test_view.dart';
import 'package:rmts/viewmodels/mpu_test_viewmodel.dart';

class MpuDataView extends StatefulWidget {
  const MpuDataView({super.key});

  @override
  State<MpuDataView> createState() => _MpuDataViewState();
}

class _MpuDataViewState extends State<MpuDataView> {
  @override
  void initState() {
    super.initState();
    // Load data on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MpuTestViewModel>(context, listen: false).loadMpuData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MpuTestViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Motion Sensor Results')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MpuTestView()),
                );
                if (result == true) {
                  // This triggers rebuild of the screen and reloads data
                  Provider.of<MpuTestViewModel>(context, listen: false)
                      .loadMpuData();
                  setState(() {}); // 🔁 triggers UI rebuild
                }
              },
              child: const Text("Start New Test"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: vm.mpuDataList.isEmpty
                  ? const Center(child: Text('No data found'))
                  : ListView.builder(
                      itemCount: vm.mpuDataList.length,
                      itemBuilder: (context, index) {
                        final data = vm.mpuDataList[index];
                        return ListTile(
                          title: Text(
                              "Raised: ${data.raised}, Lowered: ${data.lowered}"),
                          subtitle: Text("Timestamp: ${data.timestamp}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
