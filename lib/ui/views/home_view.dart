import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/appointment_management/appointment_view.dart';
import 'package:rmts/ui/views/bluetooth_view.dart';
import 'package:rmts/ui/views/glove_management/add_edit_glove.dart';
import 'package:rmts/ui/views/glove_management/glove_view.dart';
import 'package:rmts/ui/views/mpu_data_view.dart';
import 'package:rmts/ui/views/ppg_data_view.dart';
import 'package:rmts/ui/widgets/app_button.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/auth/find_glove_viewmodel.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  void _fetchData() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final gloveViewModel = Provider.of<GloveViewModel>(context, listen: false);

    if (authViewModel.currentPatient != null) {
      final patientId = authViewModel.currentPatient!.uid;

      print("Fetching data for patient ID: $patientId");

      // Fetch Glove Data
      if (authViewModel.currentPatient!.gloveId.isNotEmpty) {
        print(
            "Fetching glove data for: ${authViewModel.currentPatient!.gloveId}");
        await gloveViewModel.fetchGlove(authViewModel.currentPatient!.gloveId);
      }
    } else {
      print("No logged-in patient found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final gloveViewModel = Provider.of<GloveViewModel>(context);
    final findGloveViewmodel = Provider.of<FindGloveViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authViewModel.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authViewModel.currentUser?.fullName ?? ''}!'),

            // Display Glove Container if available
            if (gloveViewModel.currentGlove != null)
              CustomButton(
                color: Theme.of(context).colorScheme.primary,
                label:
                    "Glove Page  Status: ${gloveViewModel.currentGlove!.status.name}",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GloveView()),
                  );
                },
              ),

            const SizedBox(height: 20),
            CustomButton(
              color: Theme.of(context).colorScheme.primary,
              label: "Bluetooth Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BluetoothView()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEditGloveView()),
                );
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
            /*  const SizedBox(height: 20),

            CustomButton(
              color: Theme.of(context).colorScheme.primary,
              label: "Reports Page",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsView()),
                );
              },
            ), */
            const SizedBox(height: 20),
            //  New Appointments Button
            CustomButton(
              color: Theme.of(context).colorScheme.primary,
              label: "Appointments",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentView(
                      patientId: authViewModel.currentPatient!.uid,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
