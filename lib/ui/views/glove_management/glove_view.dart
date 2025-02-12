import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';

class GloveView extends StatelessWidget {
  const GloveView({super.key});

  @override
  Widget build(BuildContext context) {
    final gloveViewModel = Provider.of<GloveViewModel>(context);

    if (gloveViewModel.currentGlove == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Glove Info")),
        body: const Center(child: Text("No glove information available.")),
      );
    }

    final glove = gloveViewModel.currentGlove!;

    return Scaffold(
      appBar: AppBar(title: const Text("Glove Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Glove ID: ${glove.gloveId}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Status: ${glove.status.name}"),
            const SizedBox(height: 10),
            const Text("Battery Level: 99%"),
            const SizedBox(height: 10),
            Text("Last Synced: ${glove.lastSynced.toString()}"),
          ],
        ),
      ),
    );
  }
}
