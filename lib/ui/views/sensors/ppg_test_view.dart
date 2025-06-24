import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/ppg_test_viewmodel.dart';
import 'package:rmts/data/services/ble_service.dart';


class PpgTestView extends StatefulWidget {
  const PpgTestView({super.key});
  @override
  State<PpgTestView> createState() => _PpgTestViewState();
}

class _PpgTestViewState extends State<PpgTestView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _elapsedSeconds = 0;
  Timer? _timer; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    } else {
      final userId = user.uid;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PpgTestViewModel>().startPpgTest(userId).catchError(
              (_) => _showErr('Please wear the glove properly and try again.'),
            );
            
            startTimer();
      });
      
    }
  }
  void startTimer() {
        _elapsedSeconds = 0; 
        _timer?.cancel(); 
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _elapsedSeconds++;
          });
        });
      }

   void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopTimer();
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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PpgTestViewModel>();

    return Scaffold(
      body: Center(
        child: vm.isTesting
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 300),
                      painter:
                          HeartWithPolesPainter(pulseValue: _animation.value),
                    ),
                  ),
                  const SizedBox(height: 24),
                   Text(
                    _elapsedSeconds < 8
                        ? 'Hold you hands still for stabilizing: ${8 - _elapsedSeconds}s remaining'
                        : 'Capturing BPM... (${_elapsedSeconds - 8}s)',
                    style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
                    textAlign: TextAlign.center
                  
                  ),
                     const SizedBox(height: 20),
                  ElevatedButton(
                        onPressed: () async {
                          _stopTimer(); 
                          await vm.loadPpgData();
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
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          Text(
                            vm.result!.bpm.toStringAsFixed(1),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          Text(
                            'BPM',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await context.read<PpgTestViewModel>().loadPpgData();
                          Navigator.pop(context, true);
                        },
                        child: const Text('Return'),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
      ),
    );
  }
}

/* ------------ FINAL 3D Heart + Poles Painter ------------- */
class HeartWithPolesPainter extends CustomPainter {
  final double pulseValue; // <<< animate glow intensity based on this

  HeartWithPolesPainter({required this.pulseValue});

  @override
  void paint(Canvas canvas, Size size) {
    final heartPath = HeartPainter.createHeartShapePath(const Size(200, 200));
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final heartOffset =
        Offset(centerX - 100, centerY - 100); // center the heart

    // --- Draw Background Glow (pulsing with animation) ---
    final glowRadius = 200 * pulseValue; // dynamic size based on animation
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.5 * pulseValue,
        colors: [
          Colors.red.withOpacity(0.2 * pulseValue), // more intense at peak
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: glowRadius),
      );

    canvas.drawRect(
      Offset.zero & size,
      glowPaint,
    );

    // --- Draw Background Pulse Poles (Faded Lines) ---
    final polePaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..strokeWidth = 2;

    for (int i = 1; i <= 5; i++) {
      // Left poles
      canvas.drawLine(
        Offset(centerX - i * 30, centerY),
        Offset(centerX - i * 30, centerY - 20),
        polePaint..color = Colors.red.withOpacity(0.15 / i),
      );
      // Right poles
      canvas.drawLine(
        Offset(centerX + i * 30, centerY),
        Offset(centerX + i * 30, centerY - 20),
        polePaint..color = Colors.red.withOpacity(0.15 / i),
      );
    }

    // --- Draw 3D Heart (Gradient Fill) ---
    final colors = [
      Colors.red,
      const Color.fromARGB(255, 87, 0, 0),
      const Color.fromARGB(255, 155, 16, 16).withOpacity(0.8),
    ];

    final stops = List.generate(
      colors.length,
      (index) => index / (colors.length - 1),
    );

    final heartGradientPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.9, -0.3),
        radius: 0.9,
        colors: colors,
        stops: stops,
      ).createShader(Rect.fromLTWH(
        heartOffset.dx,
        heartOffset.dy,
        200,
        200,
      ));

    canvas.save();
    canvas.translate(heartOffset.dx, heartOffset.dy);
    canvas.drawPath(heartPath, heartGradientPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant HeartWithPolesPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue;
  }
}

class HeartPainter extends CustomPainter {
  const HeartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = createHeartShapePath(size);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  static Path createHeartShapePath(Size size) {
    return Path()
      ..moveTo(size.width / 2, size.height * 0.35)
      ..cubicTo(0.2 * size.width, size.height * 0.1, -0.25 * size.width,
          size.height * 0.6, 0.5 * size.width, size.height)
      ..cubicTo(1.25 * size.width, size.height * 0.6, 0.8 * size.width,
          size.height * 0.1, size.width / 2, size.height * 0.35)
      ..close();
  }
}
