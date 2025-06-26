import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/viewmodels/gloveconnectionviewmodel.dart';

class GloveConnectionTile extends StatelessWidget {
  const GloveConnectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GloveConnectionViewModel>(
      builder: (context, vm, _) {
        final device = vm.gloveDevice;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0, // removes the shadow
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: vm.connect,
          child: vm.isConnected
              ? Row(
                  children: [
                    Text(
                      'Connected',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.check_circle,
                        color: Theme.of(context).colorScheme.onSurface),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      'Connect',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                        Icons
                            .signal_cellular_connected_no_internet_0_bar_rounded,
                        color: Theme.of(context).colorScheme.error),
                  ],
                ),
        );
      },
    );
  }
}
