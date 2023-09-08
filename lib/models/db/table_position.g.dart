// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_position.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TablePositionAdapter extends TypeAdapter<TablePosition> {
  @override
  final int typeId = 5;

  @override
  TablePosition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TablePosition(
      id: fields[0] as int,
      number: fields[1] as int,
      x: fields[2] as double,
      y: fields[3] as double,
      guests: fields[4] as int,
      vip: fields[5] as int,
      active: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TablePosition obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.x)
      ..writeByte(3)
      ..write(obj.y)
      ..writeByte(4)
      ..write(obj.guests)
      ..writeByte(5)
      ..write(obj.vip)
      ..writeByte(6)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TablePositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
