import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/appointment.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'appointments';

  Future<DocumentReference> addAppointment(Appointment appointment) async {
    return await _firestore.collection(_collection).add(appointment.toJson());
  }

  Future<List<Appointment>> fetchByPatient(String patientId) async {
    final snap = await _firestore
        .collection(_collection)
        .where('patientId', isEqualTo: patientId)
        .orderBy('dateTime', descending: false)
        .get();

    return snap.docs.map((d) => Appointment.fromSnap(d)).toList();
  }

  Future<List<Appointment>> fetchByDoctor(String doctorId) async {
  final snap = await _firestore
      .collection(_collection)
      .where('doctorId', isEqualTo: doctorId)
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

  Future<List<Appointment>> fetchAppointmentsByDoctor(String doctorId) {
  return _service.fetchByDoctor(doctorId);
}

}
