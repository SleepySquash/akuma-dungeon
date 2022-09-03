// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterIdAdapter extends TypeAdapter<CharacterId> {
  @override
  final int typeId = 12;

  @override
  CharacterId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterId(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterId obj) {
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
      other is CharacterIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
