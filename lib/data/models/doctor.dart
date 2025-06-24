import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String uid;
  final String nationalId;
  final String description;
  final String licenseNumber;
  final List patientIds;

  const Doctor({
    required this.uid,
    required this.nationalId,
    required this.description,
    required this.licenseNumber,
    required this.patientIds,
  });

  factory Doctor.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Doctor(
      uid: snapshot['uid'],
      nationalId: snapshot['nationalId'],
      description: snapshot['description'],
      licenseNumber: snapshot['licenseNumber'],
      patientIds: List<dynamic>.from(snapshot['patientIds'] ?? []),
    );
  }

  /// Converts the User object to a JSON-compatible map.
  /// This method is used to serialize the User object so it can be stored in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nationalId': nationalId,
      'description': description,
      'licenseNumber': licenseNumber,
      'patientIds': patientIds,
    };
  }
}
