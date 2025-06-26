import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String uid;
  final String emergencyContact;
  final String doctorId;
  final String? doctorName;
  final String prescriptionId;
  final String gloveId;
  final String gloveName; //from doctor
  final DateTime lastSynced; //from glove
  final DateTime lastCheckIn; //from doctor

  const Patient({
    required this.uid,
    required this.emergencyContact,
    required this.doctorId,
    this.doctorName,
    required this.prescriptionId,
    required this.gloveId,
    required this.gloveName,
    required this.lastSynced,
    required this.lastCheckIn,
  });

  factory Patient.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    DateTime? parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return Patient(
      uid: snapshot['uid'] ?? '',
      emergencyContact: snapshot['emergencyContact'] ?? '',
      doctorId: snapshot['doctorId'] ?? '',
      doctorName: snapshot['doctorName'], // Optional, can be null
      prescriptionId: snapshot['prescrptionId'] ?? '',
      gloveId: snapshot['gloveId'] ?? '',
      gloveName: snapshot['gloveName'] ?? '',
      lastSynced: parseDate(snapshot['lastSynced']) ?? DateTime.now(),
      lastCheckIn: parseDate(snapshot['lastCheckIn']) ?? DateTime.now(),
    );
  }

  /// Converts the User object to a JSON-compatible map.
  /// This method is used to serialize the User object so it can be stored in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'emergencyContact': emergencyContact,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'prescrptionId': prescriptionId,
      'gloveId': gloveId,
      'gloveName': gloveName,
      'lastSynced': Timestamp.fromDate(lastSynced),
      'lastCheckIn': Timestamp.fromDate(lastCheckIn),
    };
  }
}
