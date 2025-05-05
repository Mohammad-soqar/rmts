// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flex_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlexDataAdapter extends TypeAdapter<FlexData> {
  @override
  final int typeId = 3;

  @override
  FlexData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlexData(
      bent: fields[0] as double,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FlexData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.bent)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlexDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
