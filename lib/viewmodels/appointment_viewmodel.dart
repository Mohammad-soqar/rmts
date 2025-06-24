import 'package:flutter/foundation.dart';
import 'package:rmts/data/models/appointment.dart';
import 'package:rmts/data/models/doctor.dart';
import 'package:rmts/data/models/enums/appointment_status.dart';
import 'package:rmts/data/models/user.dart';
import 'package:rmts/data/services/appointment_service.dart';
import 'package:rmts/data/services/doctor_service.dart';
import 'package:rmts/viewmodels/auth/auth_viewmodel.dart';

class AppointmentViewmodel extends ChangeNotifier {
  final AppointmentRepository _repository;
  final DoctorService _doctorService;
  final AuthViewModel _auth;

  AppointmentViewmodel({
    AppointmentRepository? repository,
    DoctorService? doctorService,
    AuthViewModel? authViewModel,
  })  : _repository = repository ?? AppointmentRepository(),
        _doctorService = doctorService ?? DoctorService(),
        _auth = authViewModel ?? AuthViewModel();

  List<Appointment> appointments = [];
  Doctor? doctorDetails;
  User? doctorUserInfo;
  bool isLoading = false;
  String? errorMessage;

  //add an appointment
  Future<void> addAppointment(
    String doctorId,
    String patientId,
    DateTime dateTime,
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      final appointment = Appointment(
        doctorId: doctorId,
        patientId: patientId,
        dateTime: dateTime,
        status: AppointmentStatus.upcoming,
        notes: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final docRef = await _repository.addAppointment(appointment);

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error adding appointment: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadForDoctor(String doctorId) async {
    isLoading = true;
    notifyListeners();
    try {
      appointments = await _repository.fetchAppointmentsByDoctor(doctorId);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error loading doctor appointments: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllForPatient() async {
    isLoading = true;
    notifyListeners();
    try {
      final patientId = _auth.currentPatient?.uid;
      appointments = await _repository.fetchAppointmentsByPatient(patientId!);

      if (appointments.isNotEmpty) {
        final docId = appointments.first.doctorId;
        doctorDetails = await _doctorService.fetchDoctor(docId);
        doctorUserInfo = await _doctorService.fetchDoctorUser(docId);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error loading data: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
