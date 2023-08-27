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
      tableId: fields[1] as int,
      placeId: fields[2] as int,
      x: fields[3] as double,
      y: fields[4] as double,
      color: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TablePosition obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tableId)
      ..writeByte(2)
      ..write(obj.placeId)
      ..writeByte(3)
      ..write(obj.x)
      ..writeByte(4)
      ..write(obj.y)
      ..writeByte(5)
      ..write(obj.color);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TablePosition _$TablePositionFromJson(Map<String, dynamic> json) =>
    TablePosition(
      id: json['id'] as int,
      tableId: json['tableId'] as int,
      placeId: json['placeId'] as int,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      color: json['color'] as int,
    );

Map<String, dynamic> _$TablePositionToJson(TablePosition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'placeId': instance.placeId,
      'x': instance.x,
      'y': instance.y,
      'color': instance.color,
    };
