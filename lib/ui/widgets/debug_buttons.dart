import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/appointment_management/appointment_view.dart';
import 'package:rmts/ui/views/bluetooth_view.dart';
import 'package:rmts/ui/views/glove_management/add_edit_glove.dart';
import 'package:rmts/ui/views/sensors/mpu_data_view.dart';
import 'package:rmts/ui/views/sensors/ppg_data_view.dart';
import 'package:rmts/ui/widgets/inputs/app_button.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/auth/find_glove_viewmodel.dart';

class DebugButtons extends StatelessWidget {
  const DebugButtons({
    super.key,
  });

  Widget build(BuildContext context) {
    final findGloveViewmodel = Provider.of<FindGloveViewmodel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Column(
      children: [
        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Bluetooth Page",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const BluetoothView()));
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Connect Glove",
          onPressed: () async {
            await findGloveViewmodel.findGlove();
          },
        ),
        const SizedBox(height: 20),

        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Mpu Test",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MpuDataView()),
            );
          },
        ),
        const SizedBox(height: 20),

        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Ppg Test",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PpgDataView()),
            );
          },
        ),
        const SizedBox(height: 20),

        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Add Glove Page",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddEditGloveView()));
          },
        ),

        const SizedBox(height: 20),
        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "connect Glove",
          onPressed: () async {
            await findGloveViewmodel.findGlove();
          },
        ),

        const SizedBox(height: 20),
        //  New Appointments Button

        CustomButton(
          color: Theme.of(context).colorScheme.primary,
          label: "Appointments",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AppointmentView(
                  patientId: authViewModel.currentPatient!.uid,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
