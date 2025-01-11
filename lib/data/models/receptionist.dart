import 'package:cloud_firestore/cloud_firestore.dart';

class Receptionist {
  final String uid;
  final List doctorIds;

  const Receptionist({
    required this.uid,
    required this.doctorIds,
   
  });



  factory Receptionist.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

   

    return Receptionist(
      uid: snapshot['uid'],
      doctorIds: snapshot['doctorId'],
    
    );
  }

  /// Converts the User object to a JSON-compatible map.
  /// This method is used to serialize the User object so it can be stored in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'doctorId': doctorIds,

    };
    
  }
}
