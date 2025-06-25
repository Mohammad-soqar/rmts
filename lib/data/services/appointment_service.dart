import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/appointment.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'appointments';

  Future<DocumentReference> addAppointment(Appointment appointment) async {
    final docRef =
        await _firestore.collection(_collection).add(appointment.toJson());

    await _firestore
        .collection('patients')
        .doc(appointment.patientId)
        .collection('appointments')
        .doc(docRef.id)
        .set(appointment.toJson());

    return docRef;
  }

  Future<List<Appointment>> fetchPatientAppointments(String patientId) async {
    final now = DateTime.now();
    final snap = await _firestore
        .collection('patients')
        .doc(patientId)
        .collection('appointments')
        .where('dateTime', isGreaterThanOrEqualTo: now)
        .get();

    return snap.docs.map((d) => Appointment.fromSnap(d)).toList();
  }

  Future<Map<String, List<Appointment>>> fetchAndCategorizeAppointments(String patientId) async {
  final snap = await _firestore
      .collection('patients')
      .doc(patientId)
      .collection('appointments')
      .orderBy('dateTime')
      .get();

  final now = DateTime.now();
  final all = snap.docs.map((d) => Appointment.fromSnap(d)).toList();

  final upcoming = all.where((a) => a.dateTime.isAfter(now)).toList();
  final past = all.where((a) => a.dateTime.isBefore(now)).toList();

  return {
    'upcoming': upcoming,
    'past': past,
  };
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

  Future<List<Appointment>> fetchPatientAppointments(String patientId) {
    return _service.fetchPatientAppointments(patientId);
  }

  Future<List<Appointment>> fetchAppointmentsByDoctor(String doctorId) {
    return _service.fetchByDoctor(doctorId);
  }

  Future<Map<String, List<Appointment>>> fetchAndCategorizeAppointments(String patientId) {
    return _service.fetchAndCategorizeAppointments(patientId);
  }
}
