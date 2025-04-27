import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/ppg_test_viewmodel.dart';

class PpgTestView extends StatefulWidget {
  const PpgTestView({super.key});

  @override
  State<PpgTestView> createState() => _PpgTestViewState();
}

class _PpgTestViewState extends State<PpgTestView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool errorShown = false; // ✅ To avoid showing multiple dialogs

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PpgTestViewModel>(context, listen: false)
          .startPpgTest("userId") // Replace with real userId
          .catchError((error) {
        // ✅ Catch error directly here and show dialog
        _showErrorDialog("Please wear the glove properly and try again.");
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    if (errorShown) return;
    errorShown = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(false); // Exit screen
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_controller.value * 0.3),
          child: child,
        );
      },
      child: const Icon(
        Icons.favorite,
        color: Colors.red,
        size: 80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PpgTestViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Running PPG Test")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: vm.isTesting
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeartAnimation(),
                    const SizedBox(height: 16),
                    const Text(
                      "Please follow the on-screen instructions...",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
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
                        Text("BPM: ${vm.result!.bpm.toStringAsFixed(2)}"),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<PpgTestViewModel>(context,
                                    listen: false)
                                .loadPpgData();
                            Navigator.pop(context, true);
                          },
                          child: const Text("Return"),
                        ),
                      ],
                    )
                  : const SizedBox(), // Empty when no result/error
        ),
      ),
    );
  }
}
