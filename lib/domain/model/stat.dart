import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/model_type_id.dart';

part 'stat.g.dart';

@HiveType(typeId: ModelTypeId.statType)
enum StatType {
  @HiveField(0)
  atk,

  @HiveField(1)
  atkPercent,

  @HiveField(2)
  critDamage,

  @HiveField(3)
  critRate,

  @HiveField(4)
  def,

  @HiveField(5)
  defPercent,

  @HiveField(6)
  hp,

  @HiveField(7)
  hpPercent,

  @HiveField(8)
  ult,

  @HiveField(9)
  ultPercent,
}

@HiveType(typeId: ModelTypeId.stat)
class Stat {
  Stat(this.type, this.amount);

  factory Stat.atk(int amount) => Stat(StatType.atk, amount);
  factory Stat.atkPercent(int amount) => Stat(StatType.atkPercent, amount);
  factory Stat.critDamage(int amount) => Stat(StatType.critDamage, amount);
  factory Stat.critRate(int amount) => Stat(StatType.critRate, amount);
  factory Stat.def(int amount) => Stat(StatType.def, amount);
  factory Stat.defPercent(int amount) => Stat(StatType.defPercent, amount);
  factory Stat.hp(int amount) => Stat(StatType.hp, amount);
  factory Stat.hpPercent(int amount) => Stat(StatType.hpPercent, amount);
  factory Stat.ult(int amount) => Stat(StatType.ult, amount);
  factory Stat.ultPercent(int amount) => Stat(StatType.ultPercent, amount);

  @HiveField(0)
  final StatType type;

  @HiveField(1)
  int amount;
}

class StatChance {
  const StatChance(this.stat, [this.chance = 1]);
  final Stat stat;
  final double chance;
}

extension ResolveStatChance on List<StatChance> {
  List<Stat> resolve(int i) {
    return sample(i).map((e) => e.stat).toList();
  }
}
