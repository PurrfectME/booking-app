// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final int typeId = 1;

  @override
  PlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as String?,
      fields[5] as int,
      (fields[6] as List).cast<TableModel>(),
      fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.logoId)
      ..writeByte(4)
      ..write(obj.base64Logo)
      ..writeByte(5)
      ..write(obj.updateDate)
      ..writeByte(6)
      ..write(obj.tables)
      ..writeByte(7)
      ..write(obj.ownerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      json['id'] as int,
      json['name'] as String,
      json['description'] as String,
      json['logoId'] as int,
      json['base64Logo'] as String?,
      json['updateDate'] as int,
      (json['tables'] as List<dynamic>)
          .map((e) => TableModel.fromJson(e as String))
          .toList(),
      json['ownerId'] as int,
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoId': instance.logoId,
      'base64Logo': instance.base64Logo,
      'updateDate': instance.updateDate,
      'tables': instance.tables,
      'ownerId': instance.ownerId,
    };
