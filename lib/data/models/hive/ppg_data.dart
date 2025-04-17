import 'package:hive/hive.dart';

part 'ppg_data.g.dart';

@HiveType(typeId: 2)
class PpgData extends HiveObject {
  @HiveField(0)
  final double bpm;

  @HiveField(1)
  final DateTime timestamp;

  PpgData({
    required this.bpm,
    required this.timestamp,
  });

  Map<String, dynamic> toFirebaseJson() => {
    'bpm': bpm,
    'timestamp': timestamp.toIso8601String(),
  };
}
