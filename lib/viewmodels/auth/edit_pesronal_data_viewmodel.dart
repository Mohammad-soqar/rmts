import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmts/data/models/patient.dart';

class EditPersonalDataViewModel extends ChangeNotifier {
  final Patient patient;
  final TextEditingController emergencyContactController;
  bool _isSaving = false;

  bool get isSaving => _isSaving;

  EditPersonalDataViewModel(this.patient)
      : emergencyContactController =
            TextEditingController(text: patient.emergencyContact);

  Future<void> updateEmergencyContact(BuildContext context) async {
    _isSaving = true;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(patient.uid)
          .update({'emergencyContact': emergencyContactController.text});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Emergency contact updated successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error updating emergency contact: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update emergency contact.')),
        );
      }
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emergencyContactController.dispose();
    super.dispose();
  }
}
