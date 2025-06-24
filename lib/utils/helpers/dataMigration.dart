import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentMigrationService {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'users';

  Future<void> migrateDates() async {
    final snap = await _firestore.collection(_collection).get();
    final batch = _firestore.batch();

    for (final doc in snap.docs) {
      final data = doc.data();

      Map<String, dynamic> updates = {};

      updates.addAll(_convertField(data, 'dateTime'));
      updates.addAll(_convertField(data, 'createdAt'));
      updates.addAll(_convertField(data, 'updatedAt'));

      if (updates.isNotEmpty) {
        batch.update(doc.reference, updates);
        print("Prepared update for ${doc.id}: $updates");
      }
    }

    await batch.commit();
    print("Migration completed!");
  }

  Map<String, dynamic> _convertField(Map<String, dynamic> data, String key) {
    final value = data[key];

    if (value is String) {
      try {
        final dt = DateTime.parse(value);
        return {key: Timestamp.fromDate(dt)};
      } catch (e) {
        print("Failed to parse $key: $value");
      }
    }

    return {};
  }
}
