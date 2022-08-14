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

part of 'race.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RaceAdapter extends TypeAdapter<Race> {
  @override
  final int typeId = 3;

  @override
  Race read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Race.ningen;
      case 1:
        return Race.inu;
      case 2:
        return Race.kitsune;
      case 3:
        return Race.neko;
      case 4:
        return Race.okami;
      case 5:
        return Race.tanuki;
      case 6:
        return Race.usagi;
      default:
        return Race.ningen;
    }
  }

  @override
  void write(BinaryWriter writer, Race obj) {
    switch (obj) {
      case Race.ningen:
        writer.writeByte(0);
        break;
      case Race.inu:
        writer.writeByte(1);
        break;
      case Race.kitsune:
        writer.writeByte(2);
        break;
      case Race.neko:
        writer.writeByte(3);
        break;
      case Race.okami:
        writer.writeByte(4);
        break;
      case Race.tanuki:
        writer.writeByte(5);
        break;
      case Race.usagi:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
