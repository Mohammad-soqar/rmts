import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/ui/views/report_view.dart';
import '../../viewmodels/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: registerViewModel.fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: registerViewModel.phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: registerViewModel.emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: registerViewModel.passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: registerViewModel.nationalityController,
                decoration: InputDecoration(labelText: 'Nationality'),
              ),
              TextField(
                controller: registerViewModel.genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: registerViewModel.birthDateController,
                decoration: InputDecoration(labelText: 'Birth Date (YYYY-MM-DD)'),
              ),
              DropdownButton<String>(
                value: registerViewModel.role,
                onChanged: (value) {
                  registerViewModel.setRole(value ?? 'Patient');
                },
                items: [
                  DropdownMenuItem(value: 'Patient', child: Text('Patient')),
                  DropdownMenuItem(value: 'Doctor', child: Text('Doctor')),
                ],
              ),
              if (registerViewModel.role == 'Patient') ...[
                TextField(
                  controller: registerViewModel.emergencyContactController,
                  decoration: InputDecoration(labelText: 'Emergency Contact'),
                ),
                TextField(
                  controller: registerViewModel.doctorIdController,
                  decoration: InputDecoration(labelText: 'Doctor ID'),
                ),
              ],
              if (registerViewModel.role == 'Doctor') ...[
                TextField(
                  controller: registerViewModel.licenseNumberController,
                  decoration: InputDecoration(labelText: 'License Number'),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await registerViewModel.registerUser();
                },
                child: Text('Register'),
              ),
              SizedBox(height: 20),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportsView()),
    );
  },
  child: Text('Reports Page'),
)
            ],
          ),
        ),
      ),
    );
  }
}
