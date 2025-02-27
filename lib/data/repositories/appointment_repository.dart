import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/data/services/appointment_service.dart';

class AppointmentRepository {
  final AppointmentService _appointmentService = AppointmentService();

  Future<void> addAppointment(Appointment appointment) async {
    try {
      await _appointmentService.addAppointment(appointment);
    } catch (e) {
      throw Exception('Failed to add Appointment: $e');
    }
  }

  Future<List<Appointment>> fetchAppointmentsByPatientId(String patientId) async {
    try {
      return await _appointmentService.getAppointmentsByPatientId(patientId);
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }
}
