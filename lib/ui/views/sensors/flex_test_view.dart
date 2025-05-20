import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/flex_test_viewmodel.dart';

class FlexTestView extends StatefulWidget {
  const FlexTestView({super.key});

  @override
  State<FlexTestView> createState() => _FlexTestViewState();
}

class _FlexTestViewState extends State<FlexTestView>
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
      end: const Offset(0, -0.05),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FlexTestViewModel>().startFlexTest('userId').catchError(
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
              onPressed: () =>
                  Navigator.of(context).popUntil((r) => r.isFirst),
              child: const Text('OK'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FlexTestViewModel>();

    return Scaffold(
      body: Center(
        child: vm.isTesting
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(
                        Icons.pan_tool_alt,
                        size: 150,
                        color:Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Bend your finger as much as you can,\nthen press Capture',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  if (vm.bentValue != null) ...[
                   const SizedBox(height: 12),
                      Text(
                         'Live Flex: ${vm.bentValue!.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
                ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await vm.sendCaptureCommand();
                    },
                    icon: const Icon(Icons.check,
                        color: Colors.white),
                    label: const Text("Capture",
                    style: TextStyle(color:Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor:Theme.of(context).colorScheme.primary,
                    ),

                  ),
                     const SizedBox(height: 20),
                  ElevatedButton(
                        onPressed: () async {
                          await vm.loadFlexdata();
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
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Bent: ${vm.result!.bent.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await vm.loadFlexdata();
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
