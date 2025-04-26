import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/sensors/ppg_test_view.dart';
import 'package:rmts/viewmodels/ppg_test_viewmodel.dart';

class PpgDataView extends StatefulWidget {
  const PpgDataView({super.key});

  @override
  State<PpgDataView> createState() => _PpgDataViewState();
}

class _PpgDataViewState extends State<PpgDataView> {
  @override
  void initState() {
    super.initState();
    // Load data on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PpgTestViewModel>(context, listen: false).loadPpgData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PpgTestViewModel>(context);

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
                  MaterialPageRoute(builder: (_) => const PpgTestView()),
                );
                if (result == true) {
                  // This triggers rebuild of the screen and reloads data
                  Provider.of<PpgTestViewModel>(context, listen: false)
                      .loadPpgData();
                  setState(() {}); // 🔁 triggers UI rebuild
                }
              },
              child: const Text("Start New Test"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: vm.ppgDataList.isEmpty
                  ? const Center(child: Text('No data found'))
                  : ListView.builder(
                      itemCount: vm.ppgDataList.length,
                      itemBuilder: (context, index) {
                        final data = vm.ppgDataList[index];
                        return ListTile(
                          title: Text(
                              "bpm: ${data.bpm}"),
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
