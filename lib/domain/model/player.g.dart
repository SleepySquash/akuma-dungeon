// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

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
      money: fields[4] as int,
      hp: fields[5] as int,
      mp: fields[6] as int,
      equipped: (fields[7] as List).cast<Item>(),
      party: (fields[8] as List).cast<Character>(),
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.race)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.exp)
      ..writeByte(4)
      ..write(obj.money)
      ..writeByte(5)
      ..write(obj.hp)
      ..writeByte(6)
      ..write(obj.mp)
      ..writeByte(7)
      ..write(obj.equipped)
      ..writeByte(8)
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
