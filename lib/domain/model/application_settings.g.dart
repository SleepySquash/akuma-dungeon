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
