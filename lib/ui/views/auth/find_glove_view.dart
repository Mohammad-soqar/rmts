import 'package:flutter/material.dart';

class FindGloveView extends StatefulWidget {
  const FindGloveView({super.key});

  @override
  _FindGloveViewState createState() => _FindGloveViewState();
}

class _FindGloveViewState extends State<FindGloveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/rmt_logo.png",
          fit: BoxFit.contain,
          height: 32,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Find your glove here!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your action here
              },
              child: const Text('Find Glove'),
            ),
          ],
        ),
      ),
    );
  }
}
