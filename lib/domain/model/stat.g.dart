// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatAdapter extends TypeAdapter<Stat> {
  @override
  final int typeId = 17;

  @override
  Stat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stat(
      fields[0] as StatType,
      fields[1] as Decimal?,
    );
  }

  @override
  void write(BinaryWriter writer, Stat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatTypeAdapter extends TypeAdapter<StatType> {
  @override
  final int typeId = 16;

  @override
  StatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StatType.atk;
      case 1:
        return StatType.atkPercent;
      case 2:
        return StatType.critDamage;
      case 3:
        return StatType.critRate;
      case 4:
        return StatType.def;
      case 5:
        return StatType.defPercent;
      case 6:
        return StatType.hp;
      case 7:
        return StatType.hpPercent;
      case 8:
        return StatType.ult;
      case 9:
        return StatType.ultPercent;
      default:
        return StatType.atk;
    }
  }

  @override
  void write(BinaryWriter writer, StatType obj) {
    switch (obj) {
      case StatType.atk:
        writer.writeByte(0);
        break;
      case StatType.atkPercent:
        writer.writeByte(1);
        break;
      case StatType.critDamage:
        writer.writeByte(2);
        break;
      case StatType.critRate:
        writer.writeByte(3);
        break;
      case StatType.def:
        writer.writeByte(4);
        break;
      case StatType.defPercent:
        writer.writeByte(5);
        break;
      case StatType.hp:
        writer.writeByte(6);
        break;
      case StatType.hpPercent:
        writer.writeByte(7);
        break;
      case StatType.ult:
        writer.writeByte(8);
        break;
      case StatType.ultPercent:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
