// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progression.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameProgressionAdapter extends TypeAdapter<GameProgression> {
  @override
  final int typeId = 8;

  @override
  GameProgression read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameProgression(
      goddessTowerLevel: fields[0] as int,
      storyChapter: fields[1] as int,
      secretary: fields[2] as CharacterId?,
    );
  }

  @override
  void write(BinaryWriter writer, GameProgression obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.goddessTowerLevel)
      ..writeByte(1)
      ..write(obj.storyChapter)
      ..writeByte(2)
      ..write(obj.secretary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameProgressionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
