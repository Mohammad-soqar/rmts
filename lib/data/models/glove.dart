import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmts/data/models/abstract/abstract.dart';
import 'package:rmts/data/models/enums/glove_status.dart';

class Glove extends BaseModel {
  final String gloveId;
  final GloveStatus status;
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

  static Glove fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    GloveStatus parseStatus(String? status) {
      return GloveStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
        orElse: () => GloveStatus.idle,
      );
    }

    return Glove(
      gloveId: snap.id,
      status: parseStatus(snapshot['status'] as String?),
      patientId: snapshot['patientId'] ?? '',
      model: snapshot['model'] ?? '',
      version: snapshot['version'] ?? '',
      productionDate: snapshot['productionDate'] ?? '',
      lastSynced: snapshot['lastSynced'] ?? '',
      lastUpdated: snapshot['lastUpdated'] ?? '',
      lastCalibrated: snapshot['lastCalibrated'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status.toString().split('.').last,
      'patientId': patientId,
      'model': model,
      'version': version,
      'productionDate': productionDate,
      'lastSynced': lastSynced,
      'lastUpdated': lastUpdated,
      'lastCalibrated': lastCalibrated,
    };
  }
}
