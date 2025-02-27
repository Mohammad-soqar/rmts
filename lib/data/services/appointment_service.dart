import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/appointment.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collection = 'appointments'; 

  // Add an appointment
  Future<void> addAppointment(Appointment appointment) async {
    try {
      await _firestore
          .collection(collection)
          .doc(appointment.appointmentId)
          .set(appointment.toJson());

      print("Appointment added: ${appointment.toJson()}"); 
    } catch (e) {
      print(" Error adding appointment: $e");
      throw Exception("Failed to add appointment: $e");
    }
  }

  // Fetch all appointments for a given patient
  Future<List<Appointment>> getAppointmentsByPatientId(String patientId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(collection)
          .where('patientId', isEqualTo: patientId)
          .orderBy('dateTime', descending: true)
          .get();

      List<Appointment> appointments = snapshot.docs
          .map((doc) => Appointment.fromSnap(doc))
          .toList();

      print("Retrieved ${appointments.length} appointments for patient $patientId"); 
      return appointments;
    } catch (e) {
      print("Error fetching appointments: $e");
      throw Exception("Failed to fetch appointments: $e");
    }
  }
}
