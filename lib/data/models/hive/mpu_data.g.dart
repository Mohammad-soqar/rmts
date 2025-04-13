// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpu_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MpuDataAdapter extends TypeAdapter<MpuData> {
  @override
  final int typeId = 1;

  @override
  MpuData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MpuData(
      raised: fields[0] as double,
      lowered: fields[1] as double,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MpuData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.raised)
      ..writeByte(1)
      ..write(obj.lowered)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MpuDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
