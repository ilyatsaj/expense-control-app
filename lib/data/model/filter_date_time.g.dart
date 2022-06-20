// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_date_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterDateTimeAdapter extends TypeAdapter<FilterDateTime> {
  @override
  final int typeId = 3;

  @override
  FilterDateTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterDateTime(
      id: fields[0] as double?,
      startDate: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FilterDateTime obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterDateTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
