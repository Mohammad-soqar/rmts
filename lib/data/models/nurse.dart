import 'package:cloud_firestore/cloud_firestore.dart';

class Nurse {
  final String uid;
  final List doctorIds;
  final String role;

  const Nurse({
    required this.uid,
    required this.doctorIds,
    required this.role,
   
  });



  factory Nurse.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

   

    return Nurse(
      uid: snapshot['uid'],
      doctorIds: snapshot['doctorId'],
      role: snapshot['role'],
    
    );
  }

  /// Converts the User object to a JSON-compatible map.
  /// This method is used to serialize the User object so it can be stored in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'doctorId': doctorIds,
      'role': role,

    };
    
  }
}
