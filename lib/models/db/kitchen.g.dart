// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KitchenAdapter extends TypeAdapter<Kitchen> {
  @override
  final int typeId = 11;

  @override
  Kitchen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kitchen(
      id: fields[0] as int,
      name: fields[1] as String,
      amount: fields[2] as double,
      date: fields[3] as int,
      user: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Kitchen obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KitchenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
