// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SkillIdAdapter extends TypeAdapter<SkillId> {
  @override
  final int typeId = 11;

  @override
  SkillId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SkillId(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SkillId obj) {
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
      other is SkillIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
