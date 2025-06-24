import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/patient.dart';
import 'package:rmts/ui/widgets/inputs/app_text_field.dart';
import 'package:rmts/viewmodels/auth/edit_pesronal_data_viewmodel.dart';

class EditPersonalDataView extends StatelessWidget {
  final Patient patient;

  const EditPersonalDataView({super.key, required this.patient});

  Widget _buildReadOnlyField(String label, String value) {
    return AppTextField(
      labelText: label,
      controller: TextEditingController(text: value),
      isPassword: false,
      readOnly: true,
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
              title: const Text('Edit Personal Data'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildReadOnlyField('UID', patient.uid),
                  const SizedBox(height: 10),
                  _buildReadOnlyField('Doctor ID', patient.doctorId),
                  const SizedBox(height: 10),
                  _buildReadOnlyField('Prescription ID', patient.prescriptionId),
                  const SizedBox(height: 10),
                  _buildReadOnlyField('Glove ID', patient.gloveId),
                  const SizedBox(height: 10),
                  _buildReadOnlyField('Glove Name', patient.gloveName),
                  const SizedBox(height: 10),
                  _buildReadOnlyField(
                      'Last Synced', patient.lastSynced.toString()),
                  const SizedBox(height: 10),
                  _buildReadOnlyField(
                      'Last Check-in', patient.lastCheckIn.toString()),
                  const SizedBox(height: 10),
                  AppTextField(
                    labelText: 'Emergency Contact',
                    controller: vm.emergencyContactController,
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: vm.isSaving
                        ? null
                        : () => vm.updateEmergencyContact(context),
                    child: vm.isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
