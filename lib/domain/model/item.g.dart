// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemIdAdapter extends TypeAdapter<ItemId> {
  @override
  final int typeId = 11;

  @override
  ItemId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemId(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemId obj) {
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
      other is ItemIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
