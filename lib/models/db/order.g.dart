// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 12;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as int,
      table: fields[1] as int,
      openDate: fields[2] as int,
      closeDate: fields[3] as int,
      items: (fields[4] as List).cast<OrderItem>(),
      cardId: fields[5] as int,
      administrator: fields[6] as String,
      guests: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.table)
      ..writeByte(2)
      ..write(obj.openDate)
      ..writeByte(3)
      ..write(obj.closeDate)
      ..writeByte(4)
      ..write(obj.items)
      ..writeByte(5)
      ..write(obj.cardId)
      ..writeByte(6)
      ..write(obj.administrator)
      ..writeByte(7)
      ..write(obj.guests);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
