import 'package:flutter/material.dart';
import '../../data/services/registration_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegistrationService _registrationService = RegistrationService();

  // Controllers for form fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();
  final TextEditingController doctorIdController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();

  // Role (Patient or Doctor)
  String role = 'Patient';

  void setRole(String newRole) {
    role = newRole;
    notifyListeners();
  }

  // Registration method
  Future<void> registerUser() async {
    try {
      final String fullName = fullNameController.text;
      final String phoneNumber = phoneNumberController.text;
      final String email = emailController.text;
      final String password = passwordController.text;
      final String nationality = nationalityController.text;
      final String gender = genderController.text;
      final DateTime birthDate = DateTime.parse(birthDateController.text);

      if (role == 'Patient') {
        final String emergencyContact = emergencyContactController.text;
        final String doctorId = doctorIdController.text;

        await _registrationService.registerNewPatient(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          nationality: nationality,
          gender: gender,
          birthDate: birthDate,
          password: password,
          emergencyContact: emergencyContact,
          doctorId: doctorId,
          prescriptionId: '',
          gloveId: '',
        );
      } else if (role == 'Doctor') {
        final String licenseNumber = licenseNumberController.text;

        await _registrationService.registerNewDoctor(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          nationality: nationality,
          gender: gender,
          birthDate: birthDate,
          password: password,
          licenseNumber: licenseNumber,
          nationalId: '',
          description: '',
        );
      }
    } catch (e) {
      print("Error registering user: $e");
    }
  }
}
