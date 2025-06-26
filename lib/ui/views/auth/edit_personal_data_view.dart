import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/patient.dart';
import 'package:rmts/data/models/user.dart';
import 'package:rmts/ui/widgets/inputs/app_text_field.dart';
import 'package:rmts/viewmodels/auth/edit_pesronal_data_viewmodel.dart';

class EditPersonalDataView extends StatelessWidget {
  final Patient patient;
  final User? userInfo;

  const EditPersonalDataView(
      {super.key, required this.patient, required this.userInfo});

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AppTextField(
        labelText: label,
        controller: TextEditingController(text: value),
        isPassword: false,
        readOnly: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditPersonalDataViewModel(patient),
      child: Consumer<EditPersonalDataViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    "assets/rmtslogo.svg",
                    color: Theme.of(context).colorScheme.primary,
                    fit: BoxFit.contain,
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildReadOnlyField(
                            'Patient Name', userInfo!.fullName),
                        _buildReadOnlyField('Doctor Name',
                            patient.doctorName ?? 'Not assigned'),
                        _buildReadOnlyField('Glove Name', patient.gloveName),
                       
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    labelText: 'Emergency Contact',
                    controller: vm.emergencyContactController,
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        onPressed: vm.isSaving
                            ? null
                            : () => vm.updateEmergencyContact(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: vm.isSaving
                            ? const CircularProgressIndicator(color: Colors.white)
                            :  Text(
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16),
                              'Save'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
