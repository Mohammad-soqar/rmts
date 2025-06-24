import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String nationality;
  final String gender;
  final int age; // This will now be dynamically calculated
  final DateTime birthDate;
  final String role;
  final bool verified;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;

  const User({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.nationality,
    required this.gender,
    required this.age,
    required this.birthDate,
    required this.role,
    required this.verified,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    DateTime? parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    final birthDate = parseDate(snapshot['birthDate']) ?? DateTime(1970, 1, 1);
    final createdAt = parseDate(snapshot['createdAt']) ?? DateTime.now();
    final updatedAt = parseDate(snapshot['lastUpdatedAt']) ?? DateTime.now();

    return User(
      uid: snap.id,
      fullName: snapshot['fullName'] ?? '',
      phoneNumber: snapshot['phoneNumber'] ?? '',
      email: snapshot['email'] ?? '',
      nationality: snapshot['nationality'] ?? '',
      gender: snapshot['gender'] ?? '',
      age: calculateAge(birthDate),
      birthDate: birthDate,
      role: snapshot['role'] ?? '',
      verified: snapshot['verified'] ?? false,
      createdAt: createdAt,
      lastUpdatedAt: updatedAt,
    );
  }

  /// Converts the User object to a JSON-compatible map.
  /// This method is used to serialize the User object so it can be stored in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'nationality': nationality,
      'gender': gender,
      'age': calculateAge(birthDate), // Dynamically calculate age before saving
      'birthDate': Timestamp.fromDate(birthDate),
      'role': role,
      'verified': verified,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastUpdatedAt': Timestamp.fromDate(lastUpdatedAt),
    };
  }
}
