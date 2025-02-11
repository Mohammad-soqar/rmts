import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/bluetooth_view.dart';
import 'package:rmts/ui/views/glove_management/add_edit_glove.dart';
import 'package:rmts/ui/views/reports_view.dart';

import '../../viewmodels/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: registerViewModel.fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: registerViewModel.phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: registerViewModel.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: registerViewModel.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: registerViewModel.nationalityController,
                decoration: const InputDecoration(labelText: 'Nationality'),
              ),
              TextField(
                controller: registerViewModel.genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: registerViewModel.birthDateController,
                decoration:
                    const InputDecoration(labelText: 'Birth Date (YYYY-MM-DD)'),
              ),
              DropdownButton<String>(
                value: registerViewModel.role,
                onChanged: (value) {
                  registerViewModel.setRole(value ?? 'Patient');
                },
                items: const [
                  DropdownMenuItem(value: 'Patient', child: Text('Patient')),
                  DropdownMenuItem(value: 'Doctor', child: Text('Doctor')),
                ],
              ),
              if (registerViewModel.role == 'Patient') ...[
                TextField(
                  controller: registerViewModel.emergencyContactController,
                  decoration:
                      const InputDecoration(labelText: 'Emergency Contact'),
                ),
                TextField(
                  controller: registerViewModel.doctorIdController,
                  decoration: const InputDecoration(labelText: 'Doctor ID'),
                ),
              ],
              if (registerViewModel.role == 'Doctor') ...[
                TextField(
                  controller: registerViewModel.licenseNumberController,
                  decoration:
                      const InputDecoration(labelText: 'License Number'),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await registerViewModel.registerUser();
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BluetoothView()),
                  );
                },
                child: const Text('Bluetooth Page'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditGloveView()),
                  );
                },
                child: const Text('Add Glove Page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportsView()),
                  );
                },
                child: const Text('Reports Page'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
