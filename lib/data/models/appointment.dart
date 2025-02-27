import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmts/data/models/abstract/abstract.dart';
import 'package:rmts/data/models/enums/appointment_status.dart';

class Appointment extends BaseModel {
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;
  final AppointmentStatus status;
  final String notes;
  // final String prescriptionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
    required this.status,
    required this.notes,
    // required this.prescriptionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    AppointmentStatus parseStatus(String? status) {
      return AppointmentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
        orElse: () => AppointmentStatus.upcoming,
      );
    }

    return Appointment(
      appointmentId: snap.id,
      patientId: snapshot['patientId'],
      doctorId: snapshot['doctorId'],
      dateTime: (snapshot['dateTime'] as Timestamp).toDate(),
      status: parseStatus(snapshot['status'] as String ?),
      notes: snapshot['notes'] ?? '', //optional field
      // prescriptionId: snapshot['prescriptionId'],
      createdAt: (snapshot['createdAt'] as Timestamp).toDate(),
      updatedAt: (snapshot['updatedAt'] as Timestamp).toDate(),
    );
  }

  /// Converts the User object to a JSON-compatible map.
  /// This method is used to serialize the User object so it can be stored in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'dateTime': Timestamp.fromDate(dateTime),
      'status': status.toString().split('.').last, //to strore as a string in Firestore
      'notes': notes,
      // 'prescriptionId': prescriptionId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
