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

part of 'application_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationSettingsAdapter extends TypeAdapter<ApplicationSettings> {
  @override
  final int typeId = 1;

  @override
  ApplicationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApplicationSettings(
      locale: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationSettings obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.locale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
