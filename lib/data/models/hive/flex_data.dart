import 'package:hive/hive.dart';

part 'flex_data.g.dart';

@HiveType(typeId:3)
class FlexData extends HiveObject {
  @HiveField(0)
  final double bent;


   @HiveField(1)
  final DateTime timestamp;


  FlexData({
    required this.bent,
    required this.timestamp,
   
  });

  Map<String, dynamic> toFirebaseJson() => {
    'bent': bent,
    'timestamp': timestamp.toIso8601String(),
  };
}
