// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableModelAdapter extends TypeAdapter<TableModel> {
  @override
  final int typeId = 4;

  @override
  TableModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableModel(
      id: fields[0] as int,
      number: fields[1] as int,
      guests: fields[2] as int,
      placeId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TableModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.guests)
      ..writeByte(3)
      ..write(obj.placeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) => TableModel(
      id: json['id'] as int,
      number: json['number'] as int,
      guests: json['guests'] as int,
      placeId: json['placeId'] as int,
    );

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'guests': instance.guests,
      'placeId': instance.placeId,
    };
