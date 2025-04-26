import 'package:flutter/material.dart';

class GloveView extends StatelessWidget {
  const GloveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glove'),
      ),
      body: const Center(
        child: Text('GloveView'),
      ),
    );
  }
}
