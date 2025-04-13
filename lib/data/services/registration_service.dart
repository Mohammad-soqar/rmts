import '../services/firebase_auth_service.dart';

class RegistrationService {
  final AuthMethods _authMethods = AuthMethods();
  // Methods for patient and doctor registration
  Future<void> registerNewPatient({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String nationality,
    required String gender,
    required DateTime birthDate,
    required String password,
    required String emergencyContact,
    required String doctorId,
    required String prescriptionId,
    required String gloveId,
    required String gloveName,
  }) async {
    String uid = await _authMethods.registerUser(
      fullName,
      phoneNumber,
      email,
      nationality,
      gender,
      birthDate,
      password,
      "Patient",
    );
    await _authMethods.registerPatient(uid, emergencyContact, doctorId,
        prescriptionId, gloveId, gloveName, DateTime.now(), DateTime.now());
  }

  Future<void> registerNewDoctor({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String nationality,
    required String gender,
    required DateTime birthDate,
    required String password,
    required String licenseNumber,
    required String nationalId,
    required String description,
  }) async {
    String uid = await _authMethods.registerUser(
      fullName,
      phoneNumber,
      email,
      nationality,
      gender,
      birthDate,
      password,
      "Doctor",
    );
    await _authMethods
        .registerDoctor(uid, nationalId, description, licenseNumber, []);
  }
}
