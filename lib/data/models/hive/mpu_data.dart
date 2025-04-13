import 'package:hive/hive.dart';

part 'mpu_data.g.dart';

@HiveType(typeId: 1)
class MpuData extends HiveObject {
  @HiveField(0)
  final double raised;

  @HiveField(1)
  final double lowered;

  @HiveField(2)
  final DateTime timestamp;

  MpuData({
    required this.raised,
    required this.lowered,
    required this.timestamp,
  });

  Map<String, dynamic> toFirebaseJson() => {
    'raised': raised,
    'lowered': lowered,
    'timestamp': timestamp.toIso8601String(),
  };
}
