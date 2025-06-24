import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/doctor.dart';
import 'package:rmts/data/models/user.dart';

class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userCollection = 'users';
  final String _doctorCollection = 'doctors';

  Future<Doctor?> fetchDoctor(String doctorId) async {
    final snap =
        await _firestore.collection(_doctorCollection).doc(doctorId).get();
    return snap.exists ? Doctor.fromSnap(snap) : null;
  }

  Future<User?> fetchDoctorUser(String doctorId) async {
    final snap =
        await _firestore.collection(_userCollection).doc(doctorId).get();
    return snap.exists ? User.fromSnap(snap) : null;
  }
}
