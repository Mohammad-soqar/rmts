import 'package:hive/hive.dart';

part 'fsr_data.g.dart';

@HiveType(typeId:4)
class FSRData extends HiveObject {
  @HiveField(0)
  final double pressure;


   @HiveField(1)
  final DateTime timestamp;


  FSRData({
    required this.pressure,
    required this.timestamp,
   
  });

  Map<String, dynamic> toFirebaseJson() => {
    'pressure': pressure,
    'timestamp': timestamp.toIso8601String(),
  };
}
