// mpu_test_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/services/ble_service.dart';
import 'package:rmts/viewmodels/mpu_test_viewmodel.dart';



class MpuTestView extends StatefulWidget {
  const MpuTestView({super.key});

  @override
  State<MpuTestView> createState() => _MpuTestViewState();
}

class _MpuTestViewState extends State<MpuTestView> 
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation; 
  late Animation<double> _scaleAnimation; 
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: const Offset(0, -0.05),)
     .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MpuTestViewModel>().startMpuTest('userId').catchError(
            (_) => _showErr('Please wear the glove properly and try again.'),
          );
    });
  }
 
 @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
  void _showErr(String m) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(m),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              child: const Text('OK'),
            ),
          ],
        ),
      );

  Widget _buildStageText(MpuTestStage stage) {
    switch (stage) {
      case MpuTestStage.idle:
        return const Text('Idle');
     case MpuTestStage.waitingRaise:
       return const Text('Please raise your wrist for 5 seconds...',style: TextStyle(fontSize: 18));
      case MpuTestStage.waitingLower:
          return const Text("Now lower your wrist for 5 seconds...", style: TextStyle(fontSize: 18));
      case MpuTestStage.done:
        return const Text('Test completed!', style: TextStyle(fontSize: 18));
    }
  }

Widget _buildProgressBar(MpuTestStage stage) {
    double progress = 0.0;
    switch (stage) {
      case MpuTestStage.waitingRaise:
        progress = 0.0; // Example value, adjust as needed
        break;
      case MpuTestStage.waitingLower:
        progress = 0.5; // Example value, adjust as needed
        break;
      case MpuTestStage.done:
        progress = 1.0;
        break;   
        default:
        progress = 0.0;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: Colors.grey[300],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );

}

  Widget build(BuildContext context) {
    final vm = Provider.of<MpuTestViewModel>(context);

    return Scaffold(
      body: Center(
        child: vm.isTesting
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                 child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Icon(
                        Icons.back_hand,
                        size: 150,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
              const SizedBox(height: 24),
              _buildStageText(vm.stage),
              _buildProgressBar(vm.stage),
            
                  Text(
                    'Raise and lower your wrist…',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                        onPressed: () async {
                          await vm.loadMpuData();
                          await BleService.sendCommand("stopMPUTest");
                          Navigator.pop(context, true);
                        },
                        child: const Text('Cancel'),
                      ),
                ],
              )
            
          : vm.result != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Test Result:',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Raised: ${vm.result!.raised.toStringAsFixed(2)} degrees',
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        'Lowered: ${vm.result!.lowered.toStringAsFixed(2)} degrees',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await context.read<MpuTestViewModel>().loadMpuData();
                          Navigator.pop(context, true);
                        },
                        child: const Text('Return to Results'),
                      ),
                      
                    ],
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}