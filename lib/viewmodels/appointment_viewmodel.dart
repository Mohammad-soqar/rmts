import 'package:flutter/material.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/data/repositories/appointment_repository.dart';

class AppointmentViewmodel extends ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? errorMessage;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;

  // Fetch Appointments
  Future<void> fetchAppointments(String patientId) async {
    _setLoading(true);

    try {
      _appointments = (await _repository.fetchAppointmentsByPatientId(patientId)) as List<Appointment>;
      print("Loaded ${_appointments.length} appointments for $patientId"); 
      _clearError();
    } catch (e) {
      _setError('Failed to fetch appointments: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Add Appointment
  Future<void> addAppointment(Appointment appointment) async {
    _setLoading(true);

    try {
      await _repository.addAppointment(appointment);
      _appointments.add(appointment);
      notifyListeners();
      _clearError();
    } catch (e) {
      _setError('Failed to add appointment: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
