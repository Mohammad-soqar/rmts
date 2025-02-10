import 'package:rmts/data/models/abstract/abstract.dart';

class Glove extends BaseModel {
  final String? gloveId;
  final String? status;
  final String? patientId;
  final String? model;
  final String? version;
  final String? productionDate;
  final String? lastSynced;
  final String? lastUpdated;
  final String? lastCalibrated;

  Glove({
    required this.gloveId,
    required this.status,
    this.patientId = '',
    required this.model,
    required this.version,
    required this.productionDate,
    this.lastSynced,
    this.lastUpdated,
    this.lastCalibrated,
  });
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
