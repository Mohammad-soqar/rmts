import 'package:firebase_database/firebase_database.dart';
import '../models/hive/mpu_data.dart';

class FirebaseService {
  static Future<void> uploadMpuData(String userId, MpuData data) async {
    final ref = FirebaseDatabase.instance.ref("users/$userId/mpu_data");
    await ref.push().set(data.toFirebaseJson());
  }
}
