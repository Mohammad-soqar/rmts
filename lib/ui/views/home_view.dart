import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/bluetooth_view.dart';
import 'package:rmts/ui/views/glove_management/add_edit_glove.dart';
import 'package:rmts/ui/views/glove_management/glove_view.dart';
import 'package:rmts/ui/views/reports_view.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';
import "package:rmts/viewmodels/appointment_viewmodel.dart";
import 'package:rmts/ui/views/appointment_management/appointment_view.dart';

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
        print("Fetching glove data for: ${authViewModel.currentPatient!.gloveId}");
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
              GestureDetector(
                onTap: () {
                  // Navigate to Glove Info Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GloveView(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Your Glove",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Status: ${gloveViewModel.currentGlove!.status.name}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),
            // Navigation Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BluetoothView()),
                );
              },
              child: const Text('Bluetooth Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEditGloveView()),
                );
              },
              child: const Text('Add Glove Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsView()),
                );
              },
              child: const Text('Reports Page'),
            ),
            const SizedBox(height: 20),
            //  New Appointments Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentView(patientId: authViewModel.currentPatient!.uid),
                  ),
                );
              },
              child: const Text("Appointments"),
            ),
          ],
        ),
      ),
    );
  }
}
