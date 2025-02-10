
// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rmts/data/models/user.dart' as userModel;
import 'package:rmts/data/models/doctor.dart' as doctorModel;
import 'package:rmts/data/models/patient.dart' as patientModel;
import 'package:rmts/data/models/receptionist.dart' as receptionistModel;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
  Future<String> registerUser(
      String fullName,
      String phoneNumber,
      String email,
      final String nationality,
      final String gender,
      final DateTime birthDate,
      String password,
      String role) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the generated UID
      String uid = userCredential.user!.uid;

      userModel.User user = userModel.User(
        uid: uid,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        nationality: nationality,
        gender: gender,
        age: userModel.User.calculateAge(birthDate),
        birthDate: birthDate,
        role: role,
        verified: false,
        createdAt: DateTime.now(),
        lastUpdatedAt: DateTime.now(),
      );
      // Save user data to the "users" collection
      await _firestore.collection('users').doc(uid).set(user.toJson());

      return uid;
    } catch (e) {
      print("Error registering user: $e");
      rethrow;
    }
  }

  //register patient
  Future<void> registerPatient(
      String uid,
      String emergencyContact,
      String doctorId,
      String prescriptionId,
      String gloveId,
      DateTime lastSynced,
      DateTime lastCheckIn) async {
    try {
      patientModel.Patient patient = patientModel.Patient(
        uid: uid,
        emergencyContact: emergencyContact,
        doctorId: doctorId,
        prescriptionId: prescriptionId,
        gloveId: gloveId,
        lastSynced: lastSynced,
        lastCheckIn: lastCheckIn,
      );

      // Save patient data to the "patients" collection
      await _firestore.collection('patients').doc(uid).set(patient.toJson());
    } catch (e) {
      print("Error registering patient: $e");
      rethrow;
    }
  }

  //register doctor
  Future<void> registerDoctor(String uid, String nationalId, String description,
      String licenseNumber, List patientIds) async {
    try {
      doctorModel.Doctor doctor = doctorModel.Doctor(
        uid: uid,
        nationalId: nationalId,
        description: description,
        licenseNumber: licenseNumber,
        patientIds: patientIds,
      );

      // Save doctor data to the "doctors" collection
      await _firestore.collection('doctors').doc(uid).set(doctor.toJson());
    } catch (e) {
      print("Error registering doctor: $e");
      rethrow;
    }
  }

  //register receptionist
  Future<void> registerReceptionist(String uid, List doctorIds) async {
    try {
      receptionistModel.Receptionist receptionist =
          receptionistModel.Receptionist(
        uid: uid,
        doctorIds: doctorIds,
      );

      // Save receptionist data to the "receptionists" collection
      await _firestore
          .collection('receptionists')
          .doc(uid)
          .set(receptionist.toJson());
    } catch (e) {
      print("Error registering receptionist: $e");
      rethrow;
    }
  }
}
