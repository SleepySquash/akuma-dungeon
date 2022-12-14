// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 2;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      name: fields[0] as String,
      race: fields[1] as Race,
      gender: fields[2] as Gender,
      exp: fields[3] as Decimal?,
      rank: fields[4] as Decimal?,
      equipped: (fields[5] as List?)?.cast<ItemId>(),
      weapons: (fields[6] as List?)?.cast<ItemId>(),
      party: (fields[7] as List?)?.cast<CharacterId>(),
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.race)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.exp)
      ..writeByte(4)
      ..write(obj.rank)
      ..writeByte(5)
      ..write(obj.equipped)
      ..writeByte(6)
      ..write(obj.weapons)
      ..writeByte(7)
      ..write(obj.party);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
