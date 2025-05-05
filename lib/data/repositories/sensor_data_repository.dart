import 'package:rmts/data/models/hive/ppg_data.dart';
import 'package:rmts/data/services/sensor_data_service.dart';

class SensorDataRepository {
  final SensorDataService _sensorDataService = SensorDataService();

  Future<void> savePpgData(PpgData data, String patientId) {
    return _sensorDataService.addPpgData(data, patientId);
  }
}
