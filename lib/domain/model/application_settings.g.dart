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
      musicVolume: fields[1] as double?,
      soundVolume: fields[2] as double?,
      voiceVolume: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationSettings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.locale)
      ..writeByte(1)
      ..write(obj.musicVolume)
      ..writeByte(2)
      ..write(obj.soundVolume)
      ..writeByte(3)
      ..write(obj.voiceVolume);
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
