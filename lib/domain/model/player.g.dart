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
      exp: fields[3] as int,
      rank: fields[4] as int,
      money: fields[5] as int,
      hp: fields[6] as int,
      mp: fields[7] as int,
      equipped: (fields[8] as List).cast<MyEquipable>(),
      weapon: (fields[9] as List).cast<MyWeapon>(),
      party: (fields[10] as List).cast<MyCharacter>(),
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.money)
      ..writeByte(6)
      ..write(obj.hp)
      ..writeByte(7)
      ..write(obj.mp)
      ..writeByte(8)
      ..write(obj.equipped)
      ..writeByte(9)
      ..write(obj.weapon)
      ..writeByte(10)
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
