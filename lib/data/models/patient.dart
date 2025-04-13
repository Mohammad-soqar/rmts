import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String uid;
  final String emergencyContact;
  final String doctorId;
  final String prescriptionId;
  final String gloveId;
  final String gloveName; //from doctor
  final DateTime lastSynced; //from glove
  final DateTime lastCheckIn; //from doctor

  const Patient({
    required this.uid,
    required this.emergencyContact,
    required this.doctorId,
    required this.prescriptionId,
    required this.gloveId,
    required this.gloveName,
    required this.lastSynced,
    required this.lastCheckIn,
  });

  factory Patient.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    // New logic to parse dates
    DateTime? parseDate(dynamic value) {
      if (value != null) {
        Timestamp timestamp = value as Timestamp;
        return timestamp.toDate();
      }
      return null;
    }

    return Patient(
      uid: snapshot['uid'],
      emergencyContact: snapshot['emergencyContact'],
      doctorId: snapshot['doctorId'],
      prescriptionId: snapshot['prescrptionId'],
      gloveId: snapshot['gloveId'],
      gloveName: snapshot['gloveName'],
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
      'prescrptionId': prescriptionId,
      'gloveId': gloveId,
      'gloveName': gloveName,
      'lastSynced': Timestamp.fromDate(lastSynced),
      'lastCheckIn': Timestamp.fromDate(lastCheckIn),
    };
  }
}
