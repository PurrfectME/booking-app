// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReservationModelAdapter extends TypeAdapter<ReservationModel> {
  @override
  final int typeId = 2;

  @override
  ReservationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReservationModel(
      id: fields[0] as int?,
      placeId: fields[1] as int,
      tableId: fields[2] as int,
      userId: fields[3] as int?,
      phoneNumber: fields[4] as String?,
      name: fields[5] as String?,
      start: fields[6] as int,
      end: fields[7] as int,
      guests: fields[8] as int,
      excludeReshuffle: fields[9] as bool,
      comment: fields[10] as String?,
      status: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReservationModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.placeId)
      ..writeByte(2)
      ..write(obj.tableId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.start)
      ..writeByte(7)
      ..write(obj.end)
      ..writeByte(8)
      ..write(obj.guests)
      ..writeByte(9)
      ..write(obj.excludeReshuffle)
      ..writeByte(10)
      ..write(obj.comment)
      ..writeByte(11)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
