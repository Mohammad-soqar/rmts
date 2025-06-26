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
  List<Appointment> appointments_patient = [];
  List<Appointment> upcomingAppointments = [];
  List<Appointment> pastAppointments = [];
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

  Future<void> loadAndCategorizeAppointments() async {
    isLoading = true;
    notifyListeners();
    try {
      final patientId = _auth.currentPatient?.uid;
      if (patientId == null) throw Exception("Patient not logged in");

      final categorized =
          await _repository.fetchAndCategorizeAppointments(patientId);
      upcomingAppointments = categorized['upcoming'] ?? [];
      pastAppointments = categorized['past'] ?? [];

      // optional doctor info
      final docId = _auth.currentPatient!.doctorId;
      doctorDetails = await _doctorService.fetchDoctor(docId);
      doctorUserInfo = await _doctorService.fetchDoctorUser(docId);

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error loading appointments: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelAppointment(String appointmentId, patientId) async {
    isLoading = true;
    notifyListeners();
    try {
      await _repository.cancelAppointment(appointmentId, patientId);
      // Optionally, you can remove the appointment from the local list
    
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error canceling appointment: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPatientAppointment(String patientId) async {
    isLoading = true;
    notifyListeners();
    try {
      appointments_patient =
          await _repository.fetchPatientAppointments(patientId);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error loading patient appointments: $e';
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
      if (patientId == null) throw Exception("Patient not logged in");

      // Load all appointments
      appointments = await _repository.fetchAppointmentsByPatient(patientId);

      // Categorize into upcoming and past
      final now = DateTime.now();
      upcomingAppointments =
          appointments.where((a) => a.dateTime.isAfter(now)).toList();
      pastAppointments =
          appointments.where((a) => a.dateTime.isBefore(now)).toList();

      // Load doctor info
      final docId = _auth.currentPatient!.doctorId;
      doctorDetails = await _doctorService.fetchDoctor(docId);
      doctorUserInfo = await _doctorService.fetchDoctorUser(docId);

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error loading data: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
