// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ppg_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PpgDataAdapter extends TypeAdapter<PpgData> {
  @override
  final int typeId = 2;

  @override
  PpgData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PpgData(
      bpm: fields[0] as double,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PpgData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.bpm)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PpgDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
