// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fsr_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FSRDataAdapter extends TypeAdapter<FSRData> {
  @override
  final int typeId = 4;

  @override
  FSRData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FSRData(
      pressure: fields[0] as double,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FSRData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pressure)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSRDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
