// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationIdAdapter extends TypeAdapter<LocationId> {
  @override
  final int typeId = 14;

  @override
  LocationId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationId(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocationId obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.val);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
