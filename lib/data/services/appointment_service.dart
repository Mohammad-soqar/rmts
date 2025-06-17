import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/data/models/doctor.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'appointments';

  Future<void> addAppointment(Appointment appointment) async {
    await _firestore
      .collection(_collection)
      .doc(appointment.appointmentId)
      .set(appointment.toJson());
  }

  Future<List<Appointment>> fetchByPatient(String patientId) async {
    final snap = await _firestore
      .collection(_collection)
      .where('patientId', isEqualTo: patientId)
      .orderBy('dateTime', descending: false)
      .get();

    return snap.docs.map((d) => Appointment.fromSnap(d)).toList();
  }
}



class AppointmentRepository {
  final AppointmentService _service;

  AppointmentRepository({AppointmentService? service})
      : _service = service ?? AppointmentService();

  Future<void> addAppointment(Appointment appointment) {
    return _service.addAppointment(appointment);
  }

  Future<List<Appointment>> fetchAppointmentsByPatient(String patientId) {
    return _service.fetchByPatient(patientId);
  }
}



class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'users';

  Future<Doctor?> fetchDoctor(String doctorId) async {
    final snap = await _firestore.collection(_collection).doc(doctorId).get();
    if (snap.exists) {
      return Doctor.fromSnap(snap);
    }
    return null;
  }
}
