import 'package:rmts/data/models/hive/flex_data.dart';
import 'package:rmts/data/models/hive/fsr_data.dart';
import 'package:rmts/data/models/hive/mpu_data.dart';
import 'package:rmts/data/models/hive/ppg_data.dart';
import 'package:rmts/data/services/sensor_data_service.dart';

class SensorDataRepository {
  final SensorDataService _sensorDataService = SensorDataService();

  Future<void> savePpgData(PpgData data, String patientId) {
    return _sensorDataService.addPpgData(data, patientId);
  }

  Future<void> saveMpuData(MpuData data, String patientId) {
    return _sensorDataService.addMpuData(data, patientId);
  }

  Future<void> saveFlexData(FlexData data, String patientId) {
    return _sensorDataService.addFlexData(data, patientId);
  }

  Future<void> saveFsrData(FSRData data, String patientId) {
    return _sensorDataService.addFsrData(data, patientId);
  }
}
