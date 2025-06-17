// viewmodels/appointment_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/data/services/appointment_service.dart';

class AppointmentViewmodel extends ChangeNotifier {
  final AppointmentRepository _repository;

  List<Appointment> appointments = [];
  bool isLoading = false;
  String? errorMessage;

  AppointmentViewmodel({AppointmentRepository? repository})
      : _repository = repository ?? AppointmentRepository();

  Future<void> loadAppointments(String patientId) async {
    _setLoading(true);
    try {
      appointments = await _repository.fetchAppointmentsByPatient(patientId);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error loading appointments: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addAppointment(Appointment appt) async {
    _setLoading(true);
    try {
      await _repository.addAppointment(appt);
      appointments.add(appt);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error adding appointment: ${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
